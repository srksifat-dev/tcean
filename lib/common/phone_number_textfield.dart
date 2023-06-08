import 'package:flutter/material.dart';

class PhoneNumberTextfield extends StatelessWidget {
  PhoneNumberTextfield({Key? key, required this.controller,required this.focusNode,required this.formKey}) : super(key: key);
  final GlobalKey<FormState> formKey;
  TextEditingController controller;
  FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
        height: 80,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
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
            ),hintText: "01XXXXXXXXX"
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter Mobile Number";
            } else if (value.length != 11 ||
                value.substring(0, 2) != "01" ||
                value.substring(2, 3) == "2" ||
                value.substring(2, 3) == "0" ||
                value.contains(" ")) {
              return "Please Enter valid mobile number";
            }
            return null;
          },
          maxLength: 11,
          keyboardType: TextInputType.phone,
        ),
      ),
    );
  }
}
