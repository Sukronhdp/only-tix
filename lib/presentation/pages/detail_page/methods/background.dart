import 'package:only_tix/domain/entities/movie.dart';
import 'package:only_tix/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

List<Widget> background(Movie movie) => [
      Image.network(
        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          backgroundPage.withOpacity(1),
          backgroundPage.withOpacity(0.7)
        ], begin: const Alignment(0, 0.3), end: Alignment.topCenter)),
      )
    ];
