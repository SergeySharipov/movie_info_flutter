import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_info_flutter/api/movies_client.dart';
import 'package:movie_info_flutter/models/movie_briefs_response.dart';

const page = 1;

class MoviesListPage extends StatefulWidget {
  MoviesListPage({Key key}) : super(key: key);

  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  MovieBriefsResponse _movieBriefsResponse =
  MovieBriefsResponse(results: [], page: page);
  final _apiClient = MoviesClient(Dio());

  @override
  void initState() {
    super.initState();
    loadMovieBriefs();
  }

  void loadMovieBriefs() async {
    MovieBriefsResponse movieBriefsResponse =
    await _apiClient.loadMoviesBriefs(page);
    setState(() {
      _movieBriefsResponse = movieBriefsResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
        centerTitle: true,
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    if (_movieBriefsResponse.results.isEmpty) {
      return Text("Error, try again later.");
    }
    return ListView.builder(
        itemCount: _movieBriefsResponse.results.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/movie_details', arguments: {
                    'id': _movieBriefsResponse.results[index].id,
                  });
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network('https://image.tmdb.org/t/p/w342'+
                      '${_movieBriefsResponse.results[index].posterPath}',
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(_movieBriefsResponse.results[index].title),
                subtitle: Text(_movieBriefsResponse.results[index].releaseDate),
                trailing: Text('${_movieBriefsResponse.results[index].voteAverage}'),
                isThreeLine: true,
              ),
            ),
          );
        });
  }
}
