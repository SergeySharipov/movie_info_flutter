import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_info_flutter/api/movies_client.dart';
import 'package:movie_info_flutter/models/movie_details.dart';

class MovieDetailsPage extends StatefulWidget {
  MovieDetailsPage({Key key}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Map data;
  MovieDetails _movieDetails;
  List<String> _movieGenres = new List<String>();
  final _apiClient = MoviesClient(Dio());

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (data == null) {
      data = ModalRoute.of(context).settings.arguments;

      loadMovie(data['id']);
    }
  }

  void loadMovie(int id) async {
    MovieDetails movieDetails = await _apiClient.loadMovieDetails(id);
    print(movieDetails);
    setState(() {
      _movieDetails = movieDetails;
      _movieGenres.addAll(_movieDetails.genres.values);
    });
  }

  getDetailsBody() {
    final textTheme = Theme.of(context).textTheme;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              if (_movieDetails.posterPath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    width: 100,
                    imageUrl: 'https://image.tmdb.org/t/p/w342' +
                        '${_movieDetails.posterPath}',
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _movieDetails.title,
                        style: textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Vote average: ${_movieDetails.voteAverage}',
                        style: textTheme.bodyText2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Release date: ${_movieDetails.releaseDate}',
                        style: textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 32,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: _movieGenres.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(_movieGenres[index],style: TextStyle(color: Colors.white),),
                ),
              );
            }),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Align(alignment: Alignment.centerLeft, child: Text('Overview')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_movieDetails.overview),
            ),
          ],
        )),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if (_movieDetails != null) {
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: false,
              flexibleSpace: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: 'https://image.tmdb.org/t/p/w780' +
                    '${_movieDetails.backdropPath}',
              ),
              pinned: true,
              expandedHeight: 150,
            ),
            SliverList(
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) => getDetailsBody(),
                // Builds 1000 ListTiles
                childCount: 1,
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading'),
          centerTitle: true,
        ),
      );
    }
  }
}
