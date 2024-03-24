import 'package:flutter/material.dart';

class AssetsHistoryTile extends StatelessWidget {
  final String date;
  final String description;
  final double price;
  final bool isProfit;
  const AssetsHistoryTile({super.key, required this.date, required this.description, required this.price, required this.isProfit});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: mHeight *0.0141025,bottom: mHeight *0.0141025,left: mWidth *0.030555, right: mWidth *0.030555),
      width: double.infinity,
      height: mHeight *0.11752,
      child: Row(
        children: [
          Container(
              width: mWidth *0.61110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey, fontSize: mHeight *0.01645),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )),
          Container(
            width: mWidth *0.32261,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    isProfit ? '+RM${price.toStringAsFixed(2)}' : '-RM${price.toStringAsFixed(2)}',
                    style: TextStyle(color: isProfit ? Colors.green : Colors.red),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
