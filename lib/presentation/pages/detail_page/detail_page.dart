import 'package:only_tix/domain/entities/movie.dart';
import 'package:only_tix/domain/entities/movie_detail.dart';
import 'package:only_tix/presentation/misc/methods.dart';
import 'package:only_tix/presentation/pages/detail_page/methods/cast_and_crew.dart';
import 'package:only_tix/presentation/providers/movie/movie_detail_provider.dart';
import 'package:only_tix/presentation/providers/router/router_provider.dart';
import 'package:only_tix/presentation/widgets/back_navigation_bar.dart';
import 'package:only_tix/presentation/widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:only_tix/presentation/pages/detail_page/methods/background.dart';
import '../../misc/constants.dart';
import 'methods/movie_overview.dart';
import 'methods/movie_short_info.dart';

class DetailPage extends ConsumerWidget {
  final Movie movie;
  const DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var asyncMovieDetail = ref.watch(movieDetailProvider(movie: movie));
    print(asyncMovieDetail);

    return Scaffold(
      body: Stack(
        children: [
          ...background(movie),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackNavigationBar(
                      movie.title,
                      onTap: () => ref.read(routerProvider).pop(),
                    ),
                    verticalSpace(24),
                    NetworkImageCard(
                      width: MediaQuery.of(context).size.width - 48,
                      height: (MediaQuery.of(context).size.width - 48) * 0.6,
                      borderRadius: 15,
                      imageUrl: asyncMovieDetail.valueOrNull != null
                          ? 'https://image.tmdb.org/t/p/w500${asyncMovieDetail.value!.backdropPath ?? movie.posterPath}'
                          : null,
                      fit: BoxFit.cover,
                    ),
                    verticalSpace(24),
                    ...movieShortInfo(
                        asyncMovieDetail: asyncMovieDetail, context: context),
                    verticalSpace(20),
                    ...movieOverview(asyncMovieDetail),
                    verticalSpace(40),
                  ],
                ),
              ),
              ...castAndCrew(movie: movie, ref: ref),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                child: ElevatedButton(
                    onPressed: () {
                      MovieDetail? movieDetail = asyncMovieDetail.valueOrNull;

                      if (movieDetail != null) {
                        ref
                            .read(routerProvider)
                            .pushNamed('time-booking', extra: movieDetail);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: backgroundPage,
                        backgroundColor: brightCyan,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Pesan film ini')),
              )
            ],
          )
        ],
      ),
    );
  }
}
