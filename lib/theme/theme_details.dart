import 'package:flutter/material.dart';

mixin ThemeDetails {
  static PreferredSize appBarDivider = PreferredSize(
    preferredSize: const Size.fromHeight(4),
    child: Container(
      color: Colors.white30,
      height: 1,
    ),
  );
}
