import 'package:only_tix/presentation/misc/methods.dart';
import 'package:only_tix/presentation/widgets/seat.dart';
import 'package:flutter/material.dart';

Widget legend() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Seat(size: 20),
        horizontalSpace(5),
        const Text(
          'Kosong',
          style: TextStyle(fontSize: 12),
        ),
        horizontalSpace(10),
        const Seat(
          size: 20,
          status: SeatStatus.selected,
        ),
        horizontalSpace(5),
        const Text(
          'Pilihan',
          style: TextStyle(fontSize: 12),
        ),
        horizontalSpace(10),
        const Seat(
          size: 20,
          status: SeatStatus.reserved,
        ),
        horizontalSpace(5),
        const Text(
          'Penuh',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
