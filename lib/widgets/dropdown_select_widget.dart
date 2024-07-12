import 'package:flutter/material.dart';

import '../size_config.dart';

class DropdownSelectWidget extends StatelessWidget {
  

  final String? selectedOption;
  final List<DropdownMenuItem<String>> categoryItems;
  final Function onChanged;
  final String hint;
  // final String? Function(String?) validator;

  const DropdownSelectWidget({
    super.key,
    this.selectedOption,
    // required this.validator,
    required this.categoryItems,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: DropdownButtonFormField<String>(
          // validator: validator,
          validator: (value) {
                                if (value == null || value == '0') {
                                  return 'Выберите поле';
                                }
                                return null;
                              },
          style: const TextStyle(
            fontSize: 16,
          ),
          menuMaxHeight: SizeConfig.screenHeight / 2,
          hint: Text(hint),
          isExpanded: true,
          value: selectedOption,
          items: categoryItems,
          onChanged: (value) => onChanged(value),
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}