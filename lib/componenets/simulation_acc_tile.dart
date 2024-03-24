import 'package:flutter/material.dart';

class SimulationAccTile extends StatelessWidget {
  final double currentAssets;
  final void Function()? onTap; 
  const SimulationAccTile({super.key, required this.currentAssets, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: mHeight * 0.09401,
        margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.blue.shade900,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: mWidth * 0.05092),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total Assets', style: TextStyle(color: Colors.white, fontSize: mHeight * 0.01645, fontWeight: FontWeight.bold),),
      
                    SizedBox(height: mHeight * 0.002350,),
      
                    Text(
                      "RM ${currentAssets.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Colors.white, fontSize: mHeight * 0.02938, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
              // const Icon(Icons.arrow_forward_ios_rounded)
              Container(
                width: mWidth*0.30555,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Last week', style: TextStyle(color: Colors.grey.shade300),),
                    Text('+ 0.0%', style: TextStyle(fontSize: mHeight*0.02115 , fontWeight: FontWeight.bold, color: Color.fromARGB(255, 101, 254, 109)),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
