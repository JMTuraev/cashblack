import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Image.asset(
            'assets/images/empty.png',
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.width / 2,
          ),
        ],
      );
}
