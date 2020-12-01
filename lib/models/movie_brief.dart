class MovieBrief {
  final int id;
  final String title;
  final String overview;

  final String releaseDate;
  final List<int> genreIds;
  final bool adult;

  final String posterPath;
  final String backdropPath;

  final bool video;

  final double voteAverage;
  final int voteCount;

  final String originalTitle;
  final String originalLanguage;
  final double popularity;

  MovieBrief({
    this.id,
    this.title,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.adult,
    this.posterPath,
    this.backdropPath,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.originalTitle,
    this.originalLanguage,
    this.popularity,
  });

  factory MovieBrief.fromJson(Map<String, dynamic> jsonMap) {
    return MovieBrief(
      id: jsonMap['id'],
      title: jsonMap['title'],
      overview: jsonMap['overview'],
      releaseDate: jsonMap['release_date'],
      genreIds: jsonMap['genre_ids'].cast<int>(),
      adult: jsonMap['adult'],
      posterPath: jsonMap['poster_path'],
      backdropPath: jsonMap['backdrop_path'],
      video: jsonMap['video'],
      voteAverage: jsonMap['vote_average'].toDouble(),
      voteCount: jsonMap['vote_count'],
      originalTitle: jsonMap['original_title'],
      originalLanguage: jsonMap['original_language'],
      popularity: jsonMap['popularity'].toDouble(),
    );
  }

  @override
  String toString() {
    return 'MovieBrief{id: $id, title: $title, overview: $overview, releaseDate: $releaseDate}';
  }
}
