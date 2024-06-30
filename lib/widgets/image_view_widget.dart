import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImageViewWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String imageUrl;

  const ImageViewWidget({
    super.key,
    required this.onTap,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                  errorWidget: (context, url, error) => DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(100),
                    dashPattern: const [3, 3, 3, 3],
                    color: Colors.white,
                    child: const Center(
                      child: Icon(
                        Icons.home_repair_service_rounded,
                        size: 100,
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.edit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
