import 'package:demo_google/componenets/my_fd_row.dart';
import 'package:flutter/material.dart';

class ViewFDScreen extends StatelessWidget {
  const ViewFDScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: mHeight * 0.009401,
                    bottom: mHeight * 0.009401,
                    left: mWidth * 0.02037,
                    right: mWidth * 0.02037),
                child: Text(
                  'CIMB Bank',
                  style: TextStyle(
                      fontSize: mHeight * 0.02821,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
              Container(
                width: double.infinity,
                height: mHeight * 0.8226,
                child: Column(
                  children: [
                    Container(
                      child: Table(
                        border: TableBorder.all(color: Colors.black),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            decoration:
                                BoxDecoration(color: Colors.grey.shade400),
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: mHeight * 0.009401,
                                      bottom: mHeight * 0.009401,
                                      left: mWidth * 0.02037,
                                      right: mWidth * 0.02037),
                                  child: Text('Initial Deposit'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: mHeight * 0.009401,
                                      bottom: mHeight * 0.009401,
                                      left: mWidth * 0.02037,
                                      right: mWidth * 0.02037),
                                  child: Text('Current Balance'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: mHeight * 0.009401,
                                      bottom: mHeight * 0.009401,
                                      left: mWidth * 0.02037,
                                      right: mWidth * 0.02037),
                                  child: Text('Interest Rate'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: mHeight * 0.009401,
                                      bottom: mHeight * 0.009401,
                                      left: mWidth * 0.02037,
                                      right: mWidth * 0.02037),
                                  child: Text('Deposit Date'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: mHeight * 0.009401,
                                      bottom: mHeight * 0.009401,
                                      left: mWidth * 0.02037,
                                      right: mWidth * 0.02037),
                                  child: Text('Renewal Date'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MyFDRow(
                        initial: 7000.00,
                        current: 7000.00,
                        rate: 3.85,
                        depositDate: '2024-03-21',
                        renewalDate: '2024-09-21'),
                    MyFDRow(
                        initial: 7000.00,
                        current: 7000.00,
                        rate: 3.85,
                        depositDate: '2024-03-21',
                        renewalDate: '2024-09-21'),
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
