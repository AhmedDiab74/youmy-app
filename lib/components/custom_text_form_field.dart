import 'package:flutter/material.dart';

import '../../util/Constants.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String fontFamily;
  final double fontSize;
  final Icon? suffixIcon;
  final Function onPressed;
  final Function onValidate;
  final Function onChange;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool readOnly;

  const CustomTextFormField(
      {Key? key,
      obscureText = true,
      this.textInputType = TextInputType.text,
      this.hintText = '',
      this.fontFamily = 'Roboto Regular',
      this.fontSize = 16,
      this.suffixIcon,
      this.textInputAction = TextInputAction.next,
      this.readOnly = false,
      required this.onPressed,
      required this.onChange,
      required this.onValidate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: () => onPressed,
      maxLines: 1,
      validator: (value) => onValidate(value),
      onChanged: (value) => onChange(value),
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(
              fontSize: fontSize, fontFamily: fontFamily, color: KHintColor)),
      keyboardType: textInputType,
      textInputAction: textInputAction,
    );
  }
}
