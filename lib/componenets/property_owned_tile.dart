import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PropertyOwnedTile extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  final String name;
  final double price;
  final double monthlyRepayment;
  final int tenure;
  final String type;
  final List<Timestamp> datePaid; 
  const PropertyOwnedTile({super.key, required this.onTap, required this.imagePath, required this.name, required this.price, required this.monthlyRepayment, required this.tenure, required this.type, required this.datePaid});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    int monthToPay = tenure*12 - datePaid.length;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: mHeight * 0.1645,
        margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16.0),
          color: monthToPay==0 ? Colors.green.shade50 :Colors.blue.shade50,
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
                padding: EdgeInsets.only(left: mWidth*0.02037),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('RM ${price.toString()}'),
                    Text('RM ${monthlyRepayment.toStringAsFixed(2)} / month'),
                    Text(monthToPay==0 ? 'Completed' : '${monthToPay.toString()} months ongoing'),
                    SizedBox(height: mHeight * 0.005876,),
      
                    Container(
                      padding: EdgeInsets.only(left: mWidth*0.02037, right: mWidth*0.02037, top: mHeight*0.00235, bottom: mHeight*0.00235),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(6.0)
                      ),
                      child: Text(type, style: TextStyle(fontSize: mHeight*0.0141025),),
                    ),
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
