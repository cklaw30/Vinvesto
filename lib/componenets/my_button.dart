import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: mWidth*0.063656,
      ),
      child: SizedBox(
        height: mHeight*0.05876,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: mHeight*0.018803,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
