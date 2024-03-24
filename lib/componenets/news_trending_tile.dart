import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsTrendingTile extends StatelessWidget {
  final Function()? onTap;
  const NewsTrendingTile({Key? key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: mWidth*0.050925, right: mWidth*0.02037, top: mHeight*0.009401, bottom: mHeight*0.047008),
        padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
        width: mWidth*0.86573, // 190 375
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('images/news1.jpeg')),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No Link Between Falling Ringgit And Profligate Money Printing, Says Economist',
              style: TextStyle(color: Colors.white, fontSize: mHeight*0.018803, fontWeight: FontWeight.bold),
            ),
            Text(
              'Lynelle Tham',
              style: TextStyle(fontSize: mHeight*0.0141025, color: Colors.white),
            ),
            Text(
              '16 Mar 2024',
              style: TextStyle(fontSize: mHeight*0.0141025, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
