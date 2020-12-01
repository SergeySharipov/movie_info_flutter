// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MoviesClient implements MoviesClient {
  _MoviesClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.themoviedb.org/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<MovieBriefsResponse> loadMoviesBriefs(page) async {
    ArgumentError.checkNotNull(page, 'page');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'page': page};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '3/discover/movie?sort_by=popularity.desc',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl,
            responseType: ResponseType.json),
        data: _data);
    final value = MovieBriefsResponse.fromJson(_result.data);
    return value;
  }
}
