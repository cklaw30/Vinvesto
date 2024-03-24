import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsNormalTile extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  final String author;
  final String date;
  final String title;
  const NewsNormalTile({super.key, required this.onTap, required this.imagePath, required this.author, required this.date, required this.title});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: mHeight*0.12457,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: mWidth*0.030555, right: mWidth*0.02037),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: mHeight*0.094016,
                  width: mWidth*0.30555,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(imagePath)),
                  ),
                ),
                Container(
                  height: mHeight*0.094016,
                  width: mWidth*0.611106,
                  margin: EdgeInsets.only(left: mWidth*0.02037),
                  child: Column(
                    children: [
                      Expanded(
                          child: Text(
                              title)),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              author,
                              style: TextStyle(fontSize: mHeight*0.0141025),
                            ),
                          ),
                          Text(
                            date,
                            style: TextStyle(fontSize: mHeight*0.0141025),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
      
            SizedBox(height: mHeight*0.007051,),
      
            Divider()
          ],
        ),
      ),
    );
  }
}
