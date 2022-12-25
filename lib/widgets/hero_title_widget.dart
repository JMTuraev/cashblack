import 'package:flutter/material.dart';

class HeroTitleWidget extends StatelessWidget {
  const HeroTitleWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 34,
      ),
    );
  }
}
