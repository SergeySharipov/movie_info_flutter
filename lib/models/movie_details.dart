class MovieDetails {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;

  final Map<int, String> genres;

  final bool adult;

  final String originalLanguage;
  final String originalTitle;
  final int budget;
  final String homepage;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;

  final String posterPath;
  final String backdropPath;

  final String imdbId;
  final bool video;

  final double voteAverage;
  final int voteCount;
  final double popularity;

  MovieDetails({
    this.id,
    this.title,
    this.overview,
    this.releaseDate,
    this.genres,
    this.adult,
    this.originalLanguage,
    this.originalTitle,
    this.budget,
    this.homepage,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.posterPath,
    this.backdropPath,
    this.imdbId,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.popularity,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> jsonMap) {
    Map<int, String> _genres = {};

    var genresMapList = jsonMap['genres'];
    if (genresMapList != null) {
      for (var genre in genresMapList) {
        _genres[genre['id']] = genre['name'];
      }
    }

    return MovieDetails(
      id: jsonMap['id'],
      title: jsonMap['title'],
      overview: jsonMap['overview'],
      releaseDate: jsonMap['release_date'],
      genres: _genres,
      adult: jsonMap['adult'],
      originalLanguage: jsonMap['original_language'],
      originalTitle: jsonMap['original_title'],
      budget: jsonMap['budget'],
      homepage: jsonMap['homepage'],
      revenue: jsonMap['revenue'],
      runtime: jsonMap['runtime'],
      status: jsonMap['status'],
      tagline: jsonMap['tagline'],
      posterPath: jsonMap['poster_path'],
      backdropPath: jsonMap['backdrop_path'],
      imdbId: jsonMap['imdb_id'],
      video: jsonMap['video'],
      voteAverage: jsonMap['vote_average'],
      voteCount: jsonMap['vote_count'],
      popularity: jsonMap['popularity'],
    );
  }

  @override
  String toString() {
    return 'MovieBrief{id: $id, title: $title, overview: $overview, releaseDate: $releaseDate}';
  }
}
