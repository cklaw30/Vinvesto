import 'package:flutter/material.dart';

class MarketBankTile extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  final String name;
  final List<Map<String, dynamic>> ffo;
  final List<Map<String, dynamic>> ffs;
  const MarketBankTile({super.key, required this.onTap, required this.imagePath, required this.name, required this.ffo, required this.ffs});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: mHeight*0.11752,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white)
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: mHeight *0.0141025,bottom: mHeight *0.0141025,left: mWidth *0.030555, right: mWidth *0.030555),
              height: mHeight*0.08226,
              width: mWidth*0.1782395,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(imagePath)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: mHeight *0.0141025,bottom: mHeight *0.0141025,left: mWidth *0.030555, right: mWidth *0.030555),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name Bank',
                    style: TextStyle(fontSize: mHeight*0.018803, fontWeight: FontWeight.bold),
                  ),
                  (ffo.isEmpty && ffs.isEmpty) ? Text('No FD offer yet') : Text('Rate: 3.65'),
                  (ffo.isEmpty && ffs.isEmpty) ? Container() : Text('6 months'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
