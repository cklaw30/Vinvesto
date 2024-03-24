import 'package:flutter/material.dart';

class PropertyToSellTile extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  final String name;
  final double price;
  final int bedroom;
  final int bathroom;
  final String type;
  const PropertyToSellTile({super.key, required this.imagePath, required this.name, required this.price, required this.bedroom, required this.bathroom, required this.type, this.onTap});

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: mHeight * 0.1645,
        margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.blue.shade100,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
          child: Row(
            children: [
      
              // property image
              Container(
                height: mHeight * 0.1645,
                width: mWidth * 0.3565,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(imagePath)),
                ),
              ),
      
              Padding(
                padding: EdgeInsets.only(left: mWidth * 0.02037),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontSize: mHeight * 0.01880, fontWeight: FontWeight.bold),),
      
                    SizedBox(height: mHeight * 0.008226,),
      
                    Text('RM $price', style: TextStyle(fontSize: mHeight * 0.01880),),
      
                    SizedBox(height: mHeight * 0.008226,),
                    
                    Row(
                      children: [
                        Text(bedroom.toString()),
                        SizedBox(width: mWidth * 0.01273,),
                        const Icon(Icons.bed_rounded),
                        SizedBox(width: mWidth * 0.01273,),
                        Text(bathroom.toString()),
                        SizedBox(width: mWidth * 0.01273,),
                        const Icon(Icons.bathtub_outlined),
                      ],
                    ),
      
                    SizedBox(height: mHeight * 0.008226,),
      
                    Container(
                      padding: EdgeInsets.only(left: mWidth * 0.02037, right: mWidth * 0.02037, top: mHeight * 0.002350, bottom: mHeight * 0.002350),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(6.0)
                      ),
                      child: Text(type, style: TextStyle(fontSize: mHeight * 0.01410),),
                    )
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
