import 'package:flutter/material.dart';
import 'package:movie_info_flutter/list/movie_briefs_list.dart';
import 'package:movie_info_flutter/util/custom_search_delegate.dart';

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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              title: Text("Popular Movies"),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                ),
              ],
            ),
          ];
        },
        body: MovieBriefsListView(),
      ),
    );
  }
}
