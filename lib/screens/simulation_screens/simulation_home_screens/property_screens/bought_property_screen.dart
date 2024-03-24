import 'package:demo_google/providers/owned_property_provider.dart';
import 'package:demo_google/providers/property_provider.dart';
import 'package:demo_google/providers/simulation_provider.dart';
import 'package:demo_google/screens/simulation_screens/simulation_home_screens/property_screens/property_bill_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:info_widget/info_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BoughtPropertyScreen extends StatelessWidget {
  const BoughtPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<PropertyProvider>(context, listen: false);
    final sp = Provider.of<SimulationProvider>(context, listen: false);
    final opp = Provider.of<OwnedPropertyProvider>(context, listen: false);
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    double rn = opp.interest / 100 / 12;
    
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Row(
          children: [
            Icon(Icons.wallet, size: mHeight*0.047,),

            SizedBox(width: mWidth*0.0127,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Savings', style: TextStyle(fontSize: mHeight*0.0141),),
                Text('RM ${sp.currentAssets.toString()}', style: TextStyle(fontSize: mHeight*0.0164),),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: mWidth*0.02037),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth*0.02037, right: mWidth*0.02037, bottom: mHeight*0.009401),
                      child: Text(
                        pp.name,
                        style: TextStyle(
                            fontSize: mHeight*0.0329, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // address
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth*0.02037, right: mWidth*0.02037, bottom: mHeight*0.009401),
                      child: Text(pp.street +
                          ', ' +
                          pp.city +
                          ', ' +
                          pp.county),
                    ),

                    // price
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth*0.02037, right: mWidth*0.02037, bottom: mHeight*0.009401),
                      child: Text(
                        'RM ' +
                            pp.price.toString(),
                        style: TextStyle(fontSize: mHeight*0.0282),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: mWidth*0.02037, right: mWidth*0.02037, bottom: mHeight*0.009401),
                      child: Text('Bought on ${DateFormat("yyyy-MM-dd").format(DateTime.fromMillisecondsSinceEpoch(opp.timeStamp.seconds * 1000)).toString()}'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.blue.shade50,
                ),
                child: Column(
                  children: [
                    // down payment label
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth*0.0611, top: mHeight*0.0141025, bottom: mHeight*0.009401),
                      child: Row(
                        children: [
                          Text(
                            'Down Payment',
                            style: TextStyle(fontSize: mHeight*0.02115),
                          ),
                          SizedBox(
                            width: mWidth*0.0127,
                          ),
                          InfoWidget(
                            infoText:
                                'Buyers are required to pay a minimum 10% of the property\'s purchase price.',
                            iconData: Icons.info_outline,
                            iconColor: Colors.black,
                            infoTextStyle: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: mWidth*0.0611, right: mWidth*0.0611),
                      width: double.infinity,
                      height: mHeight*0.0587,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Container(
                              width: mWidth*0.1018,
                              height: mHeight*0.0587,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(child: Text('RM '))),

                          // text field filling down payment price
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left:mWidth*0.030555 ),
                                child: Text(
                                  opp.downPayment.toStringAsFixed(2),
                                  style: TextStyle(fontSize: mHeight*0.0188),
                                )),
                          ),

                          Container(
                              width: mWidth*0.1273,
                              height: mHeight*0.0587,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(
                                  child: Text(
                                      (opp.downPayment/pp.price*100).toStringAsFixed(0) +
                                          '%'))),
                        ],
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Slider(
                          activeColor: Colors.grey.shade300,
                          value: opp.downPayment,
                          max: context.watch<PropertyProvider>().price,
                          divisions: 100,
                          onChanged: (double value) {}),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                padding: EdgeInsets.only(bottom: mWidth*0.0188),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.blue.shade50,
                ),
                child: Column(
                  children: [
                    // down payment label
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth*0.0611, top: mHeight*0.0141025, bottom: mHeight*0.009401),
                      child: Row(
                        children: [
                          Text(
                            'Loan Amount',
                            style: TextStyle(fontSize: mHeight*0.0211),
                          ),
                          SizedBox(
                            width: mWidth*0.0127,
                          ),
                          InfoWidget(
                            infoText:
                                'The amount of loan required to purchase the property after downpayment, or the actual property price. Typically up to 90% for first time homeowners, if 10% downpayment is put down.',
                            iconData: Icons.info_outline,
                            iconColor: Colors.black,
                            infoTextStyle: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: mWidth*0.0611, right: mWidth*0.0611),
                      width: double.infinity,
                      height: mHeight*0.0587,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Container(
                              width: mWidth*0.1018,
                              height: mHeight*0.0587,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(child: Text('RM '))),

                          // text field filling down payment price
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: mWidth*0.030555),
                                child: Text(
                                  (pp.price-opp.downPayment).toStringAsFixed(2),
                                  style: TextStyle(fontSize: mHeight*0.0188),
                                )),
                          ),

                          Container(
                              width: mWidth*0.1273,
                              height: mHeight*0.0587,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(
                                  child: Text((100 - (opp.downPayment/pp.price*100))
                                          .toStringAsFixed(0) +
                                      '%'))),
                        ],
                      ),
                    ),

                    // down payment label
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth*0.0611, top: mHeight*0.0141025, bottom: mHeight*0.009401),
                      child: Row(
                        children: [
                          Text(
                            'Interest Rate',
                            style: TextStyle(fontSize: mHeight*0.0211),
                          ),
                          SizedBox(
                            width: mWidth*0.01273,
                          ),
                          InfoWidget(
                            infoText:
                                'Housing loan interest rate charged by the bank, typically between 2.5% - 4.0%. Please check with your bank for the latest interest rates.',
                            iconData: Icons.info_outline,
                            iconColor: Colors.black,
                            infoTextStyle: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: mWidth*0.06111, right: mWidth*0.06111),
                      width: double.infinity,
                      height: mHeight*0.05876,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Container(
                              width: mWidth*0.10185,
                              height: mHeight*0.05876,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(child: Text('% '))),

                          // text field filling down payment price
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: mWidth * 0.03056),
                                child: Text(
                                  opp.interest.toString(),
                                  style: TextStyle(fontSize: mHeight*0.0188),
                                )),
                          ),

                          IgnorePointer(
                            ignoring: true,
                            child: Slider(
                                activeColor: Colors.grey.shade300,
                                value: opp.interest,
                                max: 12,
                                divisions: 120,
                                onChanged: (double value) {}),
                          ),
                        ],
                      ),
                    ),

                    // down payment label
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth*0.06111, top: mHeight * 0.014102, bottom: mHeight * 0.009401),
                      child: Row(
                        children: [
                          Text(
                            'Loan Tenure',
                            style: TextStyle(fontSize: mHeight*0.02115),
                          ),
                          SizedBox(
                            width: mWidth*0.01273,
                          ),
                          InfoWidget(
                            infoText:
                                'The number of years allocated to pay off your house loan. Maximum loan tenure in Malaysia is 35 years or up to 70 years old (whichever comes earlier).',
                            iconData: Icons.info_outline,
                            iconColor: Colors.black,
                            infoTextStyle: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: mWidth*0.06111, right: mWidth*0.06111),
                      width: double.infinity,
                      height: mHeight*0.05876,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Container(
                              width: mWidth*0.10185,
                              height: mHeight*0.05876,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(child: Text('Yrs '))),

                          // text field filling down payment price
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: mWidth * 0.03056),
                                child: Text(
                                  opp.tenure.toString(),
                                  style: TextStyle(fontSize: mHeight*0.0188),
                                )),
                          ),

                          IgnorePointer(
                            ignoring: true,
                            child: Slider(
                              activeColor: Colors.grey.shade300,
                              value: opp.tenure.toDouble(),
                              max: 35,
                              divisions: 31,
                              onChanged: (double value) {}
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                height: mHeight*0.2938,
                margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('RM${opp.monthlyRepayment.toStringAsFixed(2)}', style: TextStyle(fontSize: mHeight*0.02115, fontWeight: FontWeight.bold),),
                        Text("Monthly", style: TextStyle(color: Colors.grey),),
                        Text("Repayment", style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                    
                    PieChart(
                      swapAnimationDuration: const Duration(milliseconds: 750),
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: double.parse((opp.loan * rn).toStringAsFixed(2)),
                            title: 'Interest: RM${(opp.loan * rn).toStringAsFixed(2)}',
                            color: Colors.grey.shade200
                          ),
                          PieChartSectionData(
                            value: double.parse((opp.monthlyRepayment - (opp.loan * rn)).toStringAsFixed(2)),
                            title: 'Principal: RM${(opp.monthlyRepayment - (opp.loan * rn)).toStringAsFixed(2)}',
                            color: Colors.blue.shade100
                          ),
                        ]
                      )
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: ((context) => PropertyBillScreen()))),
                child: Container(
                    margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                    width: double.infinity,
                    height: mHeight*0.07051,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black)
                    ),
                    child: Center(
                      child: Text('Bill'),
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}