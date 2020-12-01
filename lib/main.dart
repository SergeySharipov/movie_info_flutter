import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_info_flutter/api/movies_client.dart';
import 'package:movie_info_flutter/models/movie_briefs_response.dart';

const page = 1;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MovieBriefsResponse _movieBriefsResponse =
  MovieBriefsResponse(results: [], page: page);
  final _apiClient = MoviesClient(Dio());

  void loadMovieBriefs() async {
    MovieBriefsResponse movieBriefsResponse =
    await _apiClient.loadMoviesBriefs(page);
    setState(() {
      _movieBriefsResponse = movieBriefsResponse;
    });
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
                  //updateTime(index);
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

  @override
  void initState() {
    super.initState();
    loadMovieBriefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Popular Movies'),
        centerTitle: true,
      ),
      body: buildList(),
    );
  }
}
