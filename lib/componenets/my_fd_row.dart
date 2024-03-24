import 'package:flutter/material.dart';

class MyFDRow extends StatelessWidget {
  final double initial;
  final double current;
  final double rate;
  final String depositDate;
  final String renewalDate;
  const MyFDRow({super.key, required this.initial, required this.current, required this.rate, required this.depositDate, required this.renewalDate});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text('Withdraw'),
          content: Text('Are you sure you want to withdraw?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('No')),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Yes'))
          ],
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(top: mHeight*0.009401),
        decoration: BoxDecoration(border: Border.all()),
        child: Table(
          border: TableBorder.all(color: Colors.white),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.white),
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                    child: Text(initial.toStringAsFixed(2)),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                    child: Text(current.toStringAsFixed(2)),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                    child: Text(rate.toStringAsFixed(2)),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                    child: Text(depositDate),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                    child: Text(renewalDate),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
