import 'package:demo_google/componenets/bank_fd_row.dart';
import 'package:demo_google/componenets/my_bar_chart.dart';
import 'package:demo_google/componenets/my_snackbar.dart';
import 'package:demo_google/models/fd.dart';
import 'package:demo_google/models/in_bank.dart';
import 'package:demo_google/providers/bank_provider.dart';
import 'package:demo_google/providers/simulation_provider.dart';
import 'package:demo_google/providers/user_provider.dart';
import 'package:demo_google/repositories/fd_repository.dart';
import 'package:demo_google/repositories/in_bank_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MakeFDScreen extends StatefulWidget {
  const MakeFDScreen({Key? key});

  @override
  State<MakeFDScreen> createState() => _MakeFDScreenState();
}

class _MakeFDScreenState extends State<MakeFDScreen> {
  var methods = ['Savings', 'Other'];
  var rates = ['3.65% (6 months)', '3.7% (12 months)'];
  String? method;
  String? rate;
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final depositController = TextEditingController();
    final oORsController = TextEditingController();
    final ERController = TextEditingController();
    final periodController = TextEditingController();
    final _fdRepo = FDRepository();
    final _inBankRepo = InBankRepository();
    final sp = Provider.of<SimulationProvider>(context, listen: false);
    final bp = Provider.of<BankProvider>(context, listen: false);
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
                Text(
                  '${bp.name} Bank',
                  style: TextStyle(
                      fontSize: mHeight * 0.02821,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                Text(
                  'Funds from Savings',
                  style: TextStyle(
                      fontSize: mHeight * 0.02115, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: mHeight * 0.3525637258934552,
                  padding: EdgeInsets.only(
                      top: mHeight * 0.009401,
                      bottom: mHeight * 0.009401,
                      left: mWidth * 0.02037,
                      right: mWidth * 0.02037),
                  child: Column(
                    children: [
                      Table(
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
                                  child: Text('Effective Rate (% p.a.)'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: mHeight * 0.009401,
                                      bottom: mHeight * 0.009401,
                                      left: mWidth * 0.02037,
                                      right: mWidth * 0.02037),
                                  child: Text('Period (months)'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mHeight * 0.2891022552326333,
                        child: StreamBuilder(
                            stream: _fdRepo.getFDStream(bankId: bp.bankId),
                            builder: ((context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Connection Error');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              var docs = snapshot.data!;
                              List<Map<String, dynamic>> ffss =
                                  List<Map<String, dynamic>>.from(
                                      docs['ffs'] ?? []);

                              return ListView.builder(
                                  itemCount: ffss.length,
                                  itemBuilder: ((context, index) {
                                    final ffo = ffss[index];

                                    return SizedBox(
                                      height: mHeight * 0.04113,
                                      child: Table(
                                        border: TableBorder.all(
                                            color: Colors.black),
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        children: [
                                          BankFDRow.build(context, ffo['rate'],
                                              ffo['period'])
                                        ],
                                      ),
                                    );
                                  }));
                            })),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Funds from Other Banks',
                  style: TextStyle(
                      fontSize: mHeight * 0.02115, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: mHeight * 0.35256,
                  padding: EdgeInsets.only(
                      top: mHeight * 0.009401,
                      bottom: mHeight * 0.009401,
                      left: mWidth * 0.02037,
                      right: mWidth * 0.02037),
                  child: Column(
                    children: [
                      Table(
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
                                  child: Text('Effective Rate (% p.a.)'),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: mHeight * 0.009401,
                                      bottom: mHeight * 0.009401,
                                      left: mWidth * 0.02037,
                                      right: mWidth * 0.02037),
                                  child: Text('Period (months)'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mHeight * 0.2891022552326333,
                        child: StreamBuilder(
                            stream: _fdRepo.getFDStream(bankId: bp.bankId),
                            builder: ((context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Connection Error');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              var docs = snapshot.data!;
                              List<Map<String, dynamic>> ffos =
                                  List<Map<String, dynamic>>.from(
                                      docs['ffo'] ?? []);

                              return ListView.builder(
                                  itemCount: ffos.length,
                                  itemBuilder: ((context, index) {
                                    final ffo = ffos[index];

                                    return SizedBox(
                                      height: mHeight * 0.04113,
                                      child: Table(
                                        border: TableBorder.all(
                                            color: Colors.black),
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        children: [
                                          BankFDRow.build(context, ffo['rate'],
                                              ffo['period'])
                                        ],
                                      ),
                                    );
                                  }));
                            })),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => bp.isOpenedAcc
                      ? showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Make FD'),
                                content: SizedBox(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DropdownButtonFormField(
                                          hint: Text('Funds from'),
                                          items: methods.map((String method) {
                                            return DropdownMenuItem(
                                              value: method,
                                              child: Text(
                                                method,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              method = newValue!;
                                            });
                                          }),
                                      DropdownButtonFormField(
                                          hint: Text('Effective Rate'),
                                          items: rates.map((String rate) {
                                            return DropdownMenuItem(
                                              value: rate,
                                              child: Text(
                                                rate,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              rate = newValue!;
                                            });
                                          }),
                                      TextField(
                                        controller: amountController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: 'Amount (RM)'),
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  content: SizedBox(
                                                      width: mWidth * 0.50926,
                                                      height:
                                                          mHeight * 0.470085,
                                                      child: MyBarChart(
                                                          starting: 0,
                                                          data:
                                                              CalculateList())),
                                                ));
                                      },
                                      child: Text('View Analysis')),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('Confirm'))
                                ],
                              ))
                      : showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Open Bank'),
                            content: TextField(
                              controller: depositController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(hintText: 'Deposit'),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    if (depositController.text != '') {
                                      InBank inBankModel = InBank(
                                          bankId: bp.bankId,
                                          deposit: double.parse(
                                              depositController.text),
                                          fds: []);
                                      _inBankRepo.inBank(
                                          uid: user.uid,
                                          simulationId: sp.simulationId,
                                          inBank: inBankModel);
                                      Navigator.of(context).pop();
                                      setState(() {
                                        context
                                            .read<SimulationProvider>()
                                            .addBankId(bankId: bp.bankId);
                                        context
                                            .read<BankProvider>()
                                            .changeIsOpenedAcc(
                                                isOpenedAcc: true);
                                      });
                                    } else {
                                      showSnackBar(context,
                                          'Please enter the amont of deposit');
                                    }
                                  },
                                  child: Text('Open'))
                            ],
                          ),
                        ),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: mHeight * 0.009401,
                        bottom: mHeight * 0.009401,
                        left: mWidth * 0.02037,
                        right: mWidth * 0.02037),
                    width: double.infinity,
                    height: mHeight * 0.07051,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Center(
                        child: bp.isOpenedAcc
                            ? Text('Make FD')
                            : Text(
                                'Open Bank Account',
                              )),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: (context.watch<UserProvider>().userModel!.role ==
                'Admin')
            ? FloatingActionButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Add FD'),
                    content: SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: oORsController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(hintText: 'ffo/ffs'),
                          ),
                          TextField(
                            controller: ERController,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(hintText: 'Effective Rate'),
                          ),
                          TextField(
                            controller: periodController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: 'Period'),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            if (oORsController.text != '' &&
                                ERController.text != '' &&
                                periodController.text != '') {
                              FD fdModel = FD(
                                  rate: double.parse(ERController.text),
                                  period: int.parse(periodController.text));

                              _fdRepo.addFD(
                                  bankId: bp.bankId,
                                  oORs: oORsController.text,
                                  fd: fdModel);
                            } else {
                              showSnackBar(
                                  context, 'Please fill in every section');
                            }
                          },
                          child: Text('Add'))
                    ],
                  ),
                ),
                child: const Icon(Icons.add),
              )
            : Container());
  }

  List<double> CalculateList() {
    List<double> myList = [];
    double er = 0;
    double amount = double.parse(amountController.text);

    int duration = 0;
    if (rate == '3.65% (6 months)') {
      er = 3.65;
      duration = 6;
    } else {
      er = 3.70;
      duration = 12;
    }

    for (var i = 0; i < duration; i++) {
      amount = amount + (amount * er / 100 / 12);

      myList.add(double.parse(
          (amount - double.parse(amountController.text)).toStringAsFixed(2)));
    }
    return myList;
  }
}
