import 'package:movie_info_flutter/models/movie_brief.dart';

class MovieBriefsResponse {
  final List<MovieBrief> results;
  final int page;
  final int totalResults;
  final int totalPages;

  MovieBriefsResponse({
    this.results = const [],
    this.page,
    this.totalResults,
    this.totalPages,
  });

  factory MovieBriefsResponse.fromJson(Map<String, dynamic> jsonMap) {
    final List<MovieBrief> movieBriefsList = [];
    final results = jsonMap['results'];

    if (results != null) {
      for (var result in results) {
        MovieBrief movieBrief = MovieBrief.fromJson(result);
        movieBriefsList.add(movieBrief);
      }
    }

    return MovieBriefsResponse(
        results: movieBriefsList,
        page: jsonMap['page'],
        totalResults: jsonMap['total_results'],
        totalPages: jsonMap['total_pages']);
  }

  @override
  String toString() {
    return 'MovieBriefsResponse{results: ${results.length}, page: $page, totalResults: $totalResults, totalPages: $totalPages}';
  }
}
