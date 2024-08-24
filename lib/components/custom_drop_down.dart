import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String? hintText;
  final Function(String?) onChanged;
  final Function(String?)? onValidate;

  CustomDropdownFormField({
    required this.value,
    required this.items,
    this.hintText,
    required this.onChanged,
    this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: hintText != null ? Text(hintText!) : null,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
