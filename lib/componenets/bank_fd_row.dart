import 'package:flutter/material.dart';

class BankFDRow {
  static TableRow build(BuildContext context, double rate, int period) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
            child: Text(rate.toString()),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
            child: Text(period.toString()),
          ),
        ),
      ],
    );
  }
}
