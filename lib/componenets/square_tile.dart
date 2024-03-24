import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTile({super.key, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: mHeight*0.0235, bottom: mHeight*0.0235, left: mWidth*0.0509, right: mWidth*0.0509),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.grey.shade200,
        ),
        child: Image.asset(imagePath, height: mHeight*0.0470,),
      ),
    );
  }
}