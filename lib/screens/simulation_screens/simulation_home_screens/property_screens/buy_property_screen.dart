import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/models/owned_property.dart';
import 'package:demo_google/providers/property_provider.dart';
import 'package:demo_google/providers/simulation_provider.dart';
import 'package:demo_google/repositories/mysimulation_repository.dart';
import 'package:demo_google/repositories/owned_property_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:info_widget/info_widget.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class BuyPropertyScreen extends StatefulWidget {
  final double price;
  const BuyPropertyScreen(
      {super.key,
      required this.price});

  @override
  State<BuyPropertyScreen> createState() => _BuyPropertyScreenState();
}

class _BuyPropertyScreenState extends State<BuyPropertyScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  String errorTextVal = '';
  bool isMoreThanTen = true;
  late double _currentSliderDPValue = widget.price * 0.1;
  double _currentSliderIRValue = 3.5;
  double _currentSliderLTValue = 10.0;
  final _ownedPropertyRepo = OwnedPropertyRepository();

  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<PropertyProvider>(context, listen: false);
    final sp = Provider.of<SimulationProvider>(context, listen: false);
    TextEditingController downPaymentPriceController =
        TextEditingController(text: _currentSliderDPValue.toStringAsFixed(2));
    double downPaymentPercent =
        _currentSliderDPValue / context.watch<PropertyProvider>().price * 100;
    TextEditingController interestRateController =
        TextEditingController(text: _currentSliderIRValue.toStringAsFixed(1));
    TextEditingController loanTenureController =
        TextEditingController(text: _currentSliderLTValue.toStringAsFixed(0));

    double p = pp.price - double.parse(downPaymentPriceController.text);
    double rn = double.parse(interestRateController.text) / 100 / 12;
    double nt = 12 * double.parse(loanTenureController.text);
    double mp = (p * rn) / (1 - (pow(1 + rn, -nt)));

    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Row(
          children: [
            Icon(Icons.wallet, size: mHeight*0.04701,),

            SizedBox(width: mWidth*0.01273,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Savings', style: TextStyle(fontSize: mHeight*0.014103),),
                Text('RM ${sp.currentAssets.toString()}', style: TextStyle(fontSize: mHeight*0.01645),),
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
                margin: EdgeInsets.only(left: mWidth * 0.02037),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth * 0.02037, right: mWidth * 0.02037, bottom: mHeight * 0.009401),
                      child: Text(
                        pp.name,
                        style: TextStyle(
                            fontSize: mHeight*0.03291, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // address
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth * 0.02037, right: mWidth * 0.02037, bottom: mHeight * 0.009401),
                      child: Text(pp.street +
                          ', ' +
                          pp.city +
                          ', ' +
                          pp.county),
                    ),

                    // price
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth * 0.02037, right: mWidth * 0.02037, bottom: mHeight * 0.009401),
                      child: Text(
                        'RM ' +
                            pp.price.toString(),
                        style: TextStyle(fontSize: mHeight*0.02821),
                      ),
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
                          EdgeInsets.only(left: mWidth*0.06111, top: mHeight*0.014103, bottom: mHeight * 0.009401),
                      child: Row(
                        children: [
                          Text(
                            'Down Payment',
                            style: TextStyle(fontSize: mHeight*0.02115),
                          ),
                          SizedBox(
                            width: mWidth*0.01273,
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
                      margin: EdgeInsets.only(left: mWidth*0.06111, right: mWidth*0.06111),
                      width: double.infinity,
                      height: mHeight*0.0587,
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
                              child: Center(child: Text('RM '))),

                          // text field filling down payment price
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: mHeight * 0.014102),
                              child: TextField(
                                controller: downPaymentPriceController,
                                keyboardType: TextInputType.number,
                                onEditingComplete: () {
                                  setState(() {
                                    if (downPaymentPriceController
                                            .text.isEmpty ||
                                        (double.parse(downPaymentPriceController
                                                .text) <
                                            (widget.price * 0.1))) {
                                      _currentSliderDPValue =
                                          widget.price * 0.1;
                                    } else if (double.parse(
                                            downPaymentPriceController.text) >
                                        pp.price) {
                                      _currentSliderDPValue =
                                          widget.price * 0.1;
                                    } else {
                                      _currentSliderDPValue = double.parse(
                                          downPaymentPriceController.text);
                                    }
                                  });
                                },
                                decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    )),
                              ),
                            ),
                          ),

                          Container(
                              width: mWidth*0.12731,
                              height: mHeight*0.05876,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(
                                  child: Text(
                                      downPaymentPercent.toStringAsFixed(0) +
                                          '%'))),
                        ],
                      ),
                    ),
                    Slider(
                        activeColor: Colors.blue.shade800,
                        value: _currentSliderDPValue,
                        max: context.watch<PropertyProvider>().price,
                        divisions: 100,
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderDPValue = value;
                            if (value < (widget.price * 0.1)) {
                              _currentSliderDPValue = widget.price * 0.1;
                            }
                          });
                        }),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                padding: EdgeInsets.only(bottom: mHeight * 0.0188),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.blue.shade50,
                ),
                child: Column(
                  children: [
                    // down payment label
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth*0.06111, top: mHeight*0.014103, bottom: mHeight * 0.009401),
                      child: Row(
                        children: [
                          Text(
                            'Loan Amount',
                            style: TextStyle(fontSize: mHeight*0.02115),
                          ),
                          SizedBox(
                            width: mWidth*0.01273,
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
                              width: mWidth*0.1018,
                              height: mHeight*0.05876,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(child: Text('RM '))),

                          // text field filling down payment price
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: mWidth * 0.03056),
                                child: Text(
                                  p.toStringAsFixed(2),
                                  style: TextStyle(fontSize: mHeight*0.0188),
                                )),
                          ),

                          Container(
                              width: mWidth*0.12731,
                              height: mHeight*0.05876,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.grey.shade100,
                              ),
                              child: Center(
                                  child: Text((100 - downPaymentPercent)
                                          .toStringAsFixed(0) +
                                      '%'))),
                        ],
                      ),
                    ),

                    // down payment label
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth*0.06111, top: mHeight*0.014103, bottom: mHeight * 0.009401),
                      child: Row(
                        children: [
                          Text(
                            'Interest Rate',
                            style: TextStyle(fontSize: 18.0),
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
                              padding: EdgeInsets.only(bottom: mHeight * 0.014102),
                              child: TextField(
                                controller: interestRateController,
                                keyboardType: TextInputType.number,
                                onEditingComplete: () {
                                  setState(() {
                                    if (interestRateController.text.isEmpty ||
                                        (double.parse(
                                                interestRateController.text) <
                                            1)) {
                                      _currentSliderIRValue = 3.5;
                                    } else if (double.parse(
                                            interestRateController.text) >
                                        12) {
                                      _currentSliderIRValue = 3.5;
                                    } else {
                                      _currentSliderIRValue = double.parse(
                                          interestRateController.text);
                                    }
                                  });
                                },
                                decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    )),
                              ),
                            ),
                          ),

                          IgnorePointer(
                            ignoring: (double.parse(downPaymentPriceController.text) == pp.price) ? true : false,
                            child: Slider(
                                activeColor: (double.parse(downPaymentPriceController.text) == pp.price) ? Colors.grey.shade200 : Colors.blue.shade800,
                                value: _currentSliderIRValue,
                                max: 12,
                                divisions: 120,
                                onChanged: (double value) {
                                  setState(() {
                                    _currentSliderIRValue = value;
                                    if (value < 1) {
                                      _currentSliderIRValue = 1;
                                    }
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),

                    // down payment label
                    Padding(
                      padding:
                          EdgeInsets.only(left: mWidth*0.06111, top: mHeight*0.014103, bottom: mHeight * 0.009401),
                      child: Row(
                        children: [
                          Text(
                            'Loan Tenure',
                            style: TextStyle(fontSize:  mHeight*0.02115),
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
                              padding:  EdgeInsets.only(bottom: mHeight * 0.014102),
                              child: TextField(
                                controller: loanTenureController,
                                keyboardType: TextInputType.number,
                                onEditingComplete: () {
                                  setState(() {
                                    if (loanTenureController.text.isEmpty ||
                                        (double.parse(
                                                loanTenureController.text) <
                                            5)) {
                                      _currentSliderLTValue = 10;
                                    } else if (double.parse(
                                            loanTenureController.text) >
                                        35) {
                                      _currentSliderLTValue = 10;
                                    } else {
                                      _currentSliderLTValue = double.parse(
                                          loanTenureController.text);
                                    }
                                  });
                                },
                                decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    )),
                              ),
                            ),
                          ),

                          IgnorePointer(
                            ignoring: (double.parse(downPaymentPriceController.text) == pp.price) ? true : false,
                            child: Slider(
                              activeColor: (double.parse(downPaymentPriceController.text) == pp.price) ? Colors.grey.shade200 : Colors.blue.shade800,
                              value: _currentSliderLTValue,
                              max: 35,
                              divisions: 31,
                              onChanged: (double value) {
                                setState(() {
                                  _currentSliderLTValue = value;
                                  if (value < 5) {
                                    _currentSliderLTValue = 5;
                                  }
                                });
                              }
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
                        Text('RM${mp.toStringAsFixed(2)}', style: TextStyle(fontSize: mHeight*0.02115, fontWeight: FontWeight.bold),),
                        Text("Monthly", style: TextStyle(color: Colors.grey),),
                        Text("Repayment", style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                    
                    PieChart(
                      swapAnimationDuration: const Duration(milliseconds: 750),
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: double.parse((p * rn).toStringAsFixed(2)),
                            title: 'Interest: RM${(p * rn).toStringAsFixed(2)}',
                            color: Colors.grey.shade200
                          ),
                          PieChartSectionData(
                            value: double.parse((mp - (p * rn)).toStringAsFixed(2)),
                            title: 'Principal: RM${(mp - (p * rn)).toStringAsFixed(2)}',
                            color: Colors.blue.shade100
                          ),
                        ]
                      )
                    ),
                  ],
                ),
              ),

              // continue button
              GestureDetector(
                onTap: () {
                  if (sp.employmentStatus == 'Unemployed' && p != 0) {
                    return;
                  } else if ((sp.age + int.parse(loanTenureController.text)) > 70) {
                    showDialog(
                      context: context, 
                      builder: (context) => AlertDialog(
                        title: const Text('Loan Tenure'),
                        content: const Text('Maximum loan tenure in Malaysia is only up to 70 years old'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(), 
                            child: Text('Close')
                          ),
                        ],
                      )
                    );
                  } else if (sp.currentAssets < (double.parse(downPaymentPriceController.text))) {
                    showDialog(
                      context: context, 
                      builder: (context) => AlertDialog(
                        title: const Text('Out of budget'),
                        content: const Text('Your current savings is insufficient for paying the Down Payment'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(), 
                            child: Text('Close')
                          ),
                        ],
                      )
                    );
                  } else {
                    // buy property code
                    List<Timestamp> datePaids = [];
                    OwnedProperty ownedPropertyModel = OwnedProperty(propertyId: pp.propertyId, name: pp.name, street: pp.street, city: pp.city, county: pp.county, type: pp.type, price: pp.price, bedroom: pp.bedroom, bathroom: pp.bathroom, imagePath: pp.imagePath, sqft: pp.sqft, downPayment: double.parse(downPaymentPriceController.text), loan: p, interest: double.parse(interestRateController.text), tenure: int.parse(loanTenureController.text), monthlyRepayment: mp, datePaid: datePaids, timeStamp: Timestamp.now());
                    if ((double.parse(downPaymentPriceController.text) == pp.price)) {
                      ownedPropertyModel = OwnedProperty(propertyId: pp.propertyId, name: pp.name, street: pp.street, city: pp.city, county: pp.county, type: pp.type, price: pp.price, bedroom: pp.bedroom, bathroom: pp.bathroom, imagePath: pp.imagePath, sqft: pp.sqft, downPayment: double.parse(downPaymentPriceController.text), loan: p, interest: 0, tenure: 0, monthlyRepayment: mp, datePaid: datePaids, timeStamp: Timestamp.now());
                    }
                    _ownedPropertyRepo.buyProperty(uid: user.uid, simulationId: sp.simulationId, ownedProperty: ownedPropertyModel);

                    double newCurrentAssets = sp.currentAssets - double.parse(downPaymentPriceController.text);
                    MySimulationRepository().updateCurrentAssets(uid: user.uid, simulationId: sp.simulationId, currentAssets: newCurrentAssets);
                    context.read<SimulationProvider>().changeCurrentAssets(moneySpent: double.parse(downPaymentPriceController.text));
                    context.read<SimulationProvider>().addPropertyId(propertyId: pp.propertyId);

                    Navigator.pop(context);
                    Navigator.pop(context);
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SimulationHomeScreen()),
                    // );
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                  width: double.infinity,
                  height: mHeight*0.07051,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            sp.employmentStatus == 'Unemployed' && p != 0 ? Colors.grey.shade400 : Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                    color: sp.employmentStatus == 'Unemployed' && p != 0 ? Colors.grey.shade100 : Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    'Buy',
                    style: TextStyle(
                        color:
                            sp.employmentStatus == 'Unemployed' && p != 0 ? Colors.grey.shade400 : Colors.black),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
