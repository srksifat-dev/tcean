import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({required this.error, Key? key}) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
