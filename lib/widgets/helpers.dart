import 'package:flutter/material.dart';

mixin Helpers {
  static SnackBar customSnackBar(String label) {
    return SnackBar(
      duration: const Duration(milliseconds: 1000),
      backgroundColor: Colors.grey[900],
      content: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
