import 'package:flutter/material.dart';

import '../size_config.dart';

class ActiveSwitcherWidget extends StatelessWidget {
  const ActiveSwitcherWidget({
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
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: const Color(0xff262629),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize ?? 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
