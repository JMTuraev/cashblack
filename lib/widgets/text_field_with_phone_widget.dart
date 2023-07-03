import 'package:flutter/material.dart';

import '../size_config.dart';

class TextFieldWithPhoneWidget extends StatelessWidget {
  TextFieldWithPhoneWidget({
    Key? key,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.maxLength,
    this.radius,
    this.isCenter,
  }) : super(key: key);

  final String hintText;
  TextEditingController? controller;
  int? maxLines;
  int? maxLength;
  double? radius;
  bool? isCenter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      decoration: InputDecoration(
        prefixIcon: Container(
          width: 20,
          height: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: getW(28),
                height: getW(6),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                  color: Color(0xff0093cf),
                ),
              ),
              Container(
                width: getW(28),
                height: getW(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                width: getW(28),
                height: getW(6),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                  color: Color(0xff6fb440),
                ),
              ),
            ],
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 20),
          ),
        ),
        // hintText: hintText,
        label:
            isCenter == true ? Center(child: Text(hintText)) : Text(hintText),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 20),
          ),
        ),
      ),
      textCapitalization: TextCapitalization.sentences,
      autocorrect: false,
      enableSuggestions: false,
      keyboardAppearance: Brightness.dark,
      showCursor: true,
      keyboardType: TextInputType.text,
    );
  }
}
