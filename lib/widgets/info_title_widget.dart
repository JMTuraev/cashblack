import 'package:flutter/material.dart';

class InfoTitleWidget extends StatelessWidget {
  final String title;

  const InfoTitleWidget({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Text(
        title,
        style: const TextStyle(
          color: Color(0xff34c85a),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      );
}
