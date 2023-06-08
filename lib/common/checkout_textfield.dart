import 'package:flutter/material.dart';

class CheckoutTextfield extends StatelessWidget {
  const CheckoutTextfield({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.textCapitalization,
    required this.textInputType,
    required this.hintText,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.only(
            left: 16,
            bottom: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          ),
        ),
        keyboardType: textInputType,
        textCapitalization: textCapitalization,
      ),
    );
  }
}
