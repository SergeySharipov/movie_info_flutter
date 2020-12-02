import 'package:dio/dio.dart';
import 'package:movie_info_flutter/models/movie_briefs_response.dart';
import 'package:movie_info_flutter/models/movie_details.dart';
import 'package:retrofit/retrofit.dart';

part 'movies_client.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/")
abstract class MoviesClient {
  factory MoviesClient(Dio dio, {String baseUrl}) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      var queryParameters = {
        'language': 'en',
        'api_key': 'd4d62f8eb2c8b272b9072b7cf201025d',
      };
      return options.queryParameters.addAll(queryParameters);
    }, onResponse: (Response response) async {
      // Do something with response data
      return response;
    }, onError: (DioError e) async {
      // Do something with response error
      return e;
    }));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return _MoviesClient(dio, baseUrl: baseUrl);
  }

  @GET("3/discover/movie?sort_by=popularity.desc")
  @DioResponseType(ResponseType.json)
  Future<MovieBriefsResponse> loadMoviesBriefs(@Query("page") int page);

  @GET("3/movie/{movie_id}")
  @DioResponseType(ResponseType.json)
  Future<MovieDetails> loadMovieDetails(@Path("movie_id") int id);

  @GET("3/search/movie")
  @DioResponseType(ResponseType.json)
  Future<MovieBriefsResponse> searchMovieByName(
      @Query("page") int page, @Query("query") String movieName);
}
