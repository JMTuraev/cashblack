import 'package:flutter/material.dart';

class ColorFilterHelpers {
  static const ColorFilter invert = ColorFilter.matrix(
    [
      -1,
      0,
      0,
      0,
      255,
      0,
      -1,
      0,
      0,
      255,
      0,
      0,
      -1,
      0,
      255,
      0,
      0,
      0,
      1,
      0,
    ],
  );
}
