import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

class InfoAlertWidget extends StatelessWidget {
  const InfoAlertWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
      ),
      actions: [
        CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
