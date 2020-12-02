import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_info_flutter/models/movie_brief.dart';

class MovieBriefsListItem extends StatelessWidget {
  const MovieBriefsListItem({
    @required this.movieBrief,
    Key key,
  })  : assert(movieBrief != null),
        super(key: key);
  final MovieBrief movieBrief;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/movie_details', arguments: {
            'id': movieBrief.id,
          });
        },
        child: Row(
          children: [
            if (movieBrief.posterPath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  width: 100,
                  imageUrl: 'https://image.tmdb.org/t/p/w342' +
                      '${movieBrief.posterPath}',
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movieBrief.title,
                      style: textTheme.subtitle1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Vote average: ${movieBrief.voteAverage}',
                      style: textTheme.bodyText2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Release date: ${movieBrief.releaseDate}',
                      style: textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
