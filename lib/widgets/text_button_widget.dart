import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    Key? key,
    required this.text,
    required this.method,
  }) : super(key: key);

  final String text;
  final Function method;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => method(),
      child: Text(text),
    );
  }
}
