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

  @override
  Widget build(BuildContext context) {
    if (_movieDetails != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_movieDetails.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/movie_details', arguments: {
                    'id': _movieDetails.id,
                  });
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w342' +
                        '${_movieDetails.posterPath}',
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(_movieDetails.title),
                subtitle: Text(_movieDetails.releaseDate),
                trailing: Text('${_movieDetails.voteAverage}'),
                isThreeLine: true,
              ),
            ),
            SizedBox(
              height: 38,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _movieGenres.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(_movieGenres[index]),
                        ),
                      ),
                    );
                  }),
            ),
            Card(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft, child: Text('Overview')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_movieDetails.overview),
                ),
              ],
            )),
          ]),
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
