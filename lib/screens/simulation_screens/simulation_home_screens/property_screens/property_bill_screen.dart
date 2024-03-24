import 'package:demo_google/providers/owned_property_provider.dart';
import 'package:demo_google/providers/simulation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyBillScreen extends StatefulWidget {
  const PropertyBillScreen({super.key});

  @override
  State<PropertyBillScreen> createState() => _PropertyBillScreenState();
}

class _PropertyBillScreenState extends State<PropertyBillScreen> {
  @override
  Widget build(BuildContext context) {
    final sp = Provider.of<SimulationProvider>(context, listen: false);
    final opp = Provider.of<OwnedPropertyProvider>(context, listen: false);
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Row(
          children: [
            Icon(
              Icons.wallet,
              size: mHeight * 0.04701,
            ),
            SizedBox(
              width: mWidth * 0.01273,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Savings',
                  style: TextStyle(fontSize: mHeight * 0.014103),
                ),
                Text(
                  'RM ${sp.currentAssets.toString()}',
                  style: TextStyle(fontSize: mHeight * 0.01645),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Divider(),
            Container(
              width: double.infinity,
              height: mHeight * 0.094017,
              padding: EdgeInsets.only(
                  top: mHeight * 0.009401,
                  bottom: mHeight * 0.009401,
                  left: mWidth * 0.02037,
                  right: mWidth * 0.02037),
              child: Row(
                children: [
                  Expanded(child: Text('12/05/2024')),
                  Text(opp.monthlyRepayment.toStringAsFixed(2)),
                  SizedBox(
                    width: mWidth * 0.076388,
                  ),
                  Container(
                    width: mWidth * 0.25463,
                    height: mHeight * 0.03526,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.red),
                    child: Center(
                      child: Text('PAY NOW'),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              width: double.infinity,
              height: 80,
              padding: EdgeInsets.only(
                  top: mHeight * 0.009401,
                  bottom: mHeight * 0.009401,
                  left: mWidth * 0.02037,
                  right: mWidth * 0.02037),
              child: Row(
                children: [
                  Expanded(child: Text('12/04/2024')),
                  Text(opp.monthlyRepayment.toStringAsFixed(2)),
                  SizedBox(
                    width: mWidth * 0.076388,
                  ),
                  Container(
                    width: mWidth * 0.25463,
                    height: mHeight * 0.03526,
                    child: Center(
                      child: Text(
                        'PAID',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              width: double.infinity,
              height: mHeight * 0.094017,
              padding: EdgeInsets.only(
                  top: mHeight * 0.009401,
                  bottom: mHeight * 0.009401,
                  left: mWidth * 0.02037,
                  right: mWidth * 0.02037),
              child: Row(
                children: [
                  Expanded(child: Text('12/03/2024')),
                  Text(opp.monthlyRepayment.toStringAsFixed(2)),
                  SizedBox(
                    width: mWidth * 0.076388,
                  ),
                  Container(
                    width: mWidth * 0.25463,
                    height: mHeight * 0.03526,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        'PAID',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
          ],
        )),
      ),
    );
  }
}
