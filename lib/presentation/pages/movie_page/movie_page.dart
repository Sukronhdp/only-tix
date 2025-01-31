import 'package:only_tix/presentation/pages/movie_page/methods/user_info.dart';
import 'package:only_tix/presentation/providers/movie/now_playing_provider.dart';
import 'package:only_tix/presentation/providers/movie/upcoming_provider.dart';
import 'package:only_tix/presentation/providers/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../misc/methods.dart';
import 'methods/movie_list.dart';
import 'methods/promotion_list.dart';
import 'methods/search_bar.dart';

class MoviePage extends ConsumerWidget {
  final List<String> promotionImageFileNames = const [
    'popcorn.jpg',
    'buy1get1.jpg'
  ];

  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userInfo(ref),
            verticalSpace(40),
            searchBar(context),
            verticalSpace(24),
            ...movieList(
              title: 'Film Sekarang',
              movies: ref.watch(nowPlayingProvider),
              onTap: (movie) {
                ref.read(routerProvider).pushNamed('detail', extra: movie);
              },
            ),
            verticalSpace(30),
            ...promotionList(promotionImageFileNames),
            verticalSpace(30),
            ...movieList(
              title: 'Akan Tayang',
              movies: ref.watch(upcomingProvider),
            ),
            verticalSpace(100),
          ],
        )
      ],
    );
  }
}
