import 'package:flutter/material.dart';

class MultilineTextFieldWidget extends StatelessWidget {
  MultilineTextFieldWidget({
    Key? key,
    required this.hintText,
    this.controller,
    this.onTap,
  }) : super(key: key);

  final String hintText;
  final VoidCallback? onTap;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    int maxLength = 200;

    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: onTap != null
            ? IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.attachment,
                  size: 30,
                ),
              )
            : null,
        // counterStyle: TextStyle(
        //   color: controller!.text.length == maxLength ? Colors.red : null,
        // ),
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
      maxLength: maxLength,
      minLines: 2,
      controller: controller,
    );
  }
}
