import 'package:only_tix/presentation/widgets/bottom_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:only_tix/presentation/misc/constants.dart';

class BottomNavbar extends StatelessWidget {
  final List<BottomNavbarItem> items;
  final void Function(int index) onTap;
  final int selectedIndex;

  const BottomNavbar(
      {super.key,
      required this.items,
      required this.onTap,
      required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
              color: brightCyan,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, -5))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items
                .map((e) => GestureDetector(
                      onTap: () => onTap(e.index),
                      child: e,
                    ))
                .toList(),
          ),
        ));
  }
}
