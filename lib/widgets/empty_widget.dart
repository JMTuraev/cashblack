import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Image.asset(
          'assets/images/EmptyState.png',
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.width / 2,
        ),
      );
}
