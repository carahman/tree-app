import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1250),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      backgroundColor: Colors.red,
    ),
  );
}
