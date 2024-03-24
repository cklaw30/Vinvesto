import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  final mWidth = MediaQuery.of(context).size.width;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.red),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.red, width: mWidth*0.002546),
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: Colors.grey.shade200,
      ),
    );
  }