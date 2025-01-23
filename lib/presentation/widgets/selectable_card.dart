import 'package:only_tix/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isEnable;

  const SelectableCard(
      {super.key,
      required this.text,
      this.onTap,
      this.isSelected = false,
      this.isEnable = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onTap : null,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isSelected ? brightCyan.withOpacity(0.3) : null,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: isEnable ? brightCyan : Colors.grey)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: isEnable ? grey : Colors.grey,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
