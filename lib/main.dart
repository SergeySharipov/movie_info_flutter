import 'package:flutter/material.dart';
import 'package:movie_info_flutter/pages/movie_details_page.dart';
import 'package:movie_info_flutter/pages/movies_list_page.dart';

void main() => runApp(MaterialApp(
        title: 'Movie Info',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.red,
          primaryColorDark: Colors.red[800],
          accentColor: Colors.red,

          textTheme: TextTheme(
              headline6: TextStyle(color: Colors.white)), // search text color
          hintColor: Color.fromRGBO(255, 255, 255, 0.5),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
            ),
          ),
        ),
        initialRoute: '/movies_list',
        routes: {
          '/movies_list': (context) => MoviesListPage(),
          '/movie_details': (context) => MovieDetailsPage(),
        }));
