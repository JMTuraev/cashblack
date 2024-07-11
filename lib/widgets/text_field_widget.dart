import 'package:flutter/material.dart';

import '../utils/numberic_text_formatter.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.radius,
    this.showLabel,
    this.isReadOnly,
    this.textType,
    this.validator,
    this.onChanged,
  });

  final String hintText;
  TextEditingController? controller;
  double? radius;
  bool? showLabel;
  bool? isReadOnly;
  TextInputType? textType;
  final String? Function(String?)? validator;
  Function(String)? onChanged;
  // NumericTextFormatter numericTextFormatter = NumericTextFormatter();
  // NumericRangeFormatter numericRangeFormatter = NumericRangeFormatter();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: textType == TextInputType.number
          ? [
              NumericTextFormatter(),
            ]
          : [],
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () => controller?.clear(),
          icon: const Icon(Icons.clear),
        ),
        enabled: isReadOnly == true ? false : true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 20),
          ),
        ),
        hintText: showLabel == true ? null : hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 20),
          ),
        ),
        // labelText: showLabel == true ? hintText : null,
        labelText: hintText,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 20),
          ),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      textCapitalization: TextCapitalization.sentences,
      autocorrect: false,
      enableSuggestions: false,
      keyboardAppearance: Brightness.dark,
      showCursor: true,
      keyboardType: textType ?? TextInputType.text,
    );
  }
}
