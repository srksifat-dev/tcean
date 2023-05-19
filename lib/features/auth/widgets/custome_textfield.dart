import 'package:flutter/material.dart';
import 'package:tcean/theme/app_colors.dart';

TextFormField kTextField({
  required BuildContext context,
  required TextEditingController controller,
  required FocusNode focusNode,
  // required Color cursorColor,
  // required Color textColor,
  required Color fillColor,
  required String hintText,
  required int maxLength,
  required TextInputType textInputType,
  required String? Function(String?) validator,
}) {
  return TextFormField(
    controller: controller,
    // cursorColor: cursorColor,
    style: Theme.of(context).textTheme.bodyLarge,
    cursorHeight: 5,
    textAlign: TextAlign.center,
    keyboardType: textInputType,
    validator: validator,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        // borderSide: BorderSide(color: Colors.black, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      filled: true,
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.titleLarge,
      counterText: "",
    ),
    focusNode: focusNode,
    maxLength: maxLength,
  );
}
