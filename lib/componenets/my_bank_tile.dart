import 'package:demo_google/screens/simulation_screens/simulation_home_screens/fd_screens/view_fd_screen.dart';
import 'package:flutter/material.dart';

class MyBankTile extends StatelessWidget {
  const MyBankTile({super.key});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFDScreen())),
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
                    fit: BoxFit.fill, image: AssetImage('images/cimb.jpg')),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: mHeight *0.0141025,bottom: mHeight *0.0141025,left: mWidth *0.030555, right: mWidth *0.030555),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CIMB Bank',
                    style: TextStyle(fontSize: mHeight*0.018803, fontWeight: FontWeight.bold),
                  ),
                  Text('Savings: RM10000'),
                  Text('eFD: 2'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}