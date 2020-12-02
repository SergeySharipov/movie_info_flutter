import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_info_flutter/api/movies_client.dart';
import 'package:movie_info_flutter/list/movie_brief_list_item.dart';
import 'package:movie_info_flutter/models/movie_brief.dart';

class MovieBriefsListView extends StatefulWidget {
  final String query;

  const MovieBriefsListView({Key key, this.query}) : super(key: key);

  @override
  _MovieBriefsListViewState createState() => _MovieBriefsListViewState(query);
}

class _MovieBriefsListViewState extends State<MovieBriefsListView> {
  final String query;
  final _apiClient = MoviesClient(Dio());

  final _pagingController = PagingController<int, MovieBrief>(
    firstPageKey: 1,
  );

  _MovieBriefsListViewState(this.query);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      var newPage;
      if (query == null) {
        newPage = await _apiClient.loadMoviesBriefs(pageKey);
      } else {
        newPage = await _apiClient.searchMovieByName(pageKey, query);
      }

      final isLastPage = newPage.totalPages == pageKey;
      final newItems = newPage.results;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MovieBrief>(
            itemBuilder: (context, _movieBrief, index) => MovieBriefsListItem(
              movieBrief: _movieBrief,
            ),
            firstPageErrorIndicatorBuilder: (context) => FlatButton.icon(
              onPressed: () async {
                _pagingController.refresh();
              },
              icon: Icon(
                Icons.refresh,
              ),
              label: Expanded(
                child: Text(
                  'Something went wrong. Click to try again.',
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
          padding: const EdgeInsets.all(4),
          separatorBuilder: (context, index) => const SizedBox(
            height: 4,
          ),
        ),
      );
}
