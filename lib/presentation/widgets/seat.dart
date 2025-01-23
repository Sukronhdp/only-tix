import 'package:flutter/material.dart';
import 'package:only_tix/presentation/misc/constants.dart';
import 'package:flutter/widgets.dart';

enum SeatStatus { available, reserved, selected }

class Seat extends StatelessWidget {
  final int? number;
  final SeatStatus status;
  final double size;
  final VoidCallback? onTap;

  const Seat(
      {super.key,
      this.number,
      this.status = SeatStatus.available,
      this.size = 30,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: status == SeatStatus.available
                ? Colors.white
                : status == SeatStatus.reserved
                    ? Colors.grey
                    : brightCyan,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Center(
            child: Text(
              number?.toString() ?? '',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
