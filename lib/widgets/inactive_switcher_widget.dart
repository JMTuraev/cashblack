import 'package:flutter/material.dart';

import '../size_config.dart';

class InactiveSwitcherWidget extends StatelessWidget {
  const InactiveSwitcherWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.fontSize,
  });

  final String title;
  final VoidCallback onPressed;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: getH(50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromRGBO(28, 28, 29, 1),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xff575758),
              fontSize: fontSize ?? 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
