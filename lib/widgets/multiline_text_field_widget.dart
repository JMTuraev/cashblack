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
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
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
