import 'package:flutter/material.dart';

class TextFieldWithLabelWidget extends StatelessWidget {
  TextFieldWithLabelWidget({
    Key? key,
    required this.hintText,
    this.controller,
    this.maxLines,
    this.maxLength,
    this.radius,
    this.isCenter,
    this.hasIcons,
    this.showLength,
  }) : super(key: key);

  final String hintText;
  TextEditingController? controller;
  int? maxLines;
  int? maxLength;
  double? radius;
  bool? isCenter;
  bool? hasIcons;
  bool? showLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      decoration: InputDecoration(
        // prefix: Icon(Icons.remove),
        // isDense: true,
        // prefixIcon: hasIcons == true ? Icon(Icons.remove) : null,
        // prefixIconConstraints: hasIcons == true ? const BoxConstraints() : null,
        // suffixIcon: Icon(Icons.add),
        // suffixIcon: hasIcons == true ? Icon(Icons.add) : null,
        // suffixIconConstraints: hasIcons == true ? const BoxConstraints() : null,
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
        counter: showLength == true ? null : const SizedBox(),
      ),
      textAlign: isCenter == true ? TextAlign.center : TextAlign.start,
      textCapitalization: TextCapitalization.sentences,
      autocorrect: false,
      enableSuggestions: false,
      keyboardAppearance: Brightness.dark,
      showCursor: true,
      keyboardType: TextInputType.text,
    );
  }
}
