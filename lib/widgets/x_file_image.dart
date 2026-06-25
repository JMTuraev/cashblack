import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Tanlangan rasmni (XFile) barcha platformalarda (mobil + web) ko'rsatish uchun.
/// `dart:io` ishlatmaydi, shuning uchun web build'da ham ishlaydi.
class XFileImage extends StatelessWidget {
  const XFileImage(
    this.file, {
    super.key,
    this.fit,
    this.height,
    this.width,
  });

  final XFile file;
  final BoxFit? fit;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: file.readAsBytes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            fit: fit,
            height: height,
            width: width,
          );
        }
        return SizedBox(
          height: height,
          width: width,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
