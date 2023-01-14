// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MultilineTextFieldWidget extends StatelessWidget {
  MultilineTextFieldWidget({
    Key? key,
    required this.hintText,
    this.controller,
  }) : super(key: key);

  final String hintText;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      textCapitalization: TextCapitalization.sentences,
      autocorrect: false,
      enableSuggestions: false,
      keyboardAppearance: Brightness.dark,
      showCursor: true,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: controller,
    );
  }
}
