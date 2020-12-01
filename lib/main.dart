import 'package:flutter/material.dart';
import 'package:movie_info_flutter/pages/movie_details_page.dart';
import 'package:movie_info_flutter/pages/movies_list_page.dart';


void main() => runApp(MaterialApp(
    title: 'Movie Info',
    theme: ThemeData(
      primarySwatch: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    initialRoute: '/movies_list',
    routes: {
      '/movies_list': (context) => MoviesListPage(),
      '/movie_details': (context) => MovieDetailsPage(),
    }
));
