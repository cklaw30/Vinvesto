import 'package:demo_google/componenets/my_linechart.dart';
import 'package:flutter/material.dart';

class NewsStockTile extends StatelessWidget {
  const NewsStockTile({super.key});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    List<double> stockYList = [3, 4, 2, 2, 3, 15, 8, 20, 10, 5, 35, 40, 50, 60, 40, 50, 75, 70, 93, 85, 90, 80, 150, 122, 170, 132, 154.19];
      return Container(
        width: double.infinity,
        height: mHeight * 0.1598288890716997,
        padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
        margin: EdgeInsets.only(left: mWidth*0.030555, right: mWidth*0.030555, bottom: mHeight*0.0141025),
        decoration: BoxDecoration(
          // border: Border.all(),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3)
            )
          ]
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: mHeight*0.074038,
                  width: mWidth*0.38194,
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  margin: EdgeInsets.only(right: mWidth*0.02037),
                  child: MyLineChart(yList: stockYList, data: false,),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Warren Buffett', style: TextStyle(fontSize: mHeight*0.021153, fontWeight: FontWeight.bold),),
                    Text('39 holdings', style: TextStyle(fontSize: mHeight*0.018803),)
                  ],
                )
              ],
            ),

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text('Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin'),
                  ),
              
                  Container(
                    height: mHeight*0.06228,
                    width: mWidth*0.30555,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('+47.2%', style: TextStyle(fontSize: mHeight*0.02585, fontWeight: FontWeight.bold, color: Colors.green),),
                        Container(
                          width: mWidth*0.25462,
                          height: mHeight*0.023504,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(16.0)
                          ),
                          child: Center(child: Text('3 Year Return'),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
  }
}