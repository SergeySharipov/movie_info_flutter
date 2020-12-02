import 'package:flutter/material.dart';
import 'package:movie_info_flutter/list/movies_list.dart';

const page = 1;

class MoviesListPage extends StatefulWidget {
  MoviesListPage({Key key}) : super(key: key);

  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
        centerTitle: true,
      ),
      body: PagedMovieBriefsListView(),
    );
  }
}
