import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obsureText;
  final TextInputType inputType;
  bool? enabled = true;

  MyTextField({super.key, this.controller, required this.hintText, required this.obsureText, required this.inputType, this.enabled});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mWidth*0.063656),
      child: TextField(
        enabled: enabled,
        controller: controller,
        obscureText: obsureText,
        keyboardType: inputType,
        decoration: InputDecoration(

          labelText: hintText,
          labelStyle: TextStyle(color: Colors.grey.shade500,),

          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: mWidth*0.00509,
              color: Colors.blue.shade200,
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
