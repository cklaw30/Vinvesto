import 'package:demo_google/screens/simulation_screens/simulation_home_screens/stock_screens/buy_stock_screen.dart';
import 'package:flutter/material.dart';

class StockToSellTile extends StatefulWidget {
  const StockToSellTile({super.key});

  @override
  State<StockToSellTile> createState() => _StockToSellTileState();
}

class _StockToSellTileState extends State<StockToSellTile> {
  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => BuyStockScreen()))),
      child: Container(
        width: double.infinity,
        height: mHeight*0.0822,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        child: Row(
          children: [
            Container(
              height: mHeight*0.05876,
              width: mWidth*0.12731,
              margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
              padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.asset('images/google.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GLG',
                  style: TextStyle(fontSize: mHeight*0.02115, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Google',
                  style: TextStyle(fontSize: mHeight*0.0141),
                )
              ],
            ),
            SizedBox(
              width: mWidth*0.1782,
            ),
            Text(
              'RM153.22',
              style: TextStyle(fontSize: mHeight*0.0141),
            ),
            SizedBox(
              width: mWidth*0.1782,
            ),
            Text(
              'RM154.19',
              style: TextStyle(fontSize: mHeight*0.0141),
            )
          ],
        ),
      ),
    );
  }
}
