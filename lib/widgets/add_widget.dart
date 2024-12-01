// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AddWidget extends StatelessWidget {
  final void Function()? onPressed;
  const AddWidget({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(
            Radius.circular(90),
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
