import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OwnedPropertyProvider extends ChangeNotifier {
  List<Timestamp> datePaid;
  double downPayment;
  double interest;
  double loan;
  double monthlyRepayment;
  int tenure;
  Timestamp timeStamp;
  

  OwnedPropertyProvider({
    this.datePaid = const [],
    this.downPayment = 0,
    this.interest = 0,
    this.loan = 0,
    this.monthlyRepayment = 0,
    this.tenure = 0,
    required this.timeStamp,
  });

  void getOwnedPropertyDetails({required List<Timestamp> datePaid, required double downPayment, required double interest, required double loan, required double monthlyRepayment, required int tenure, required Timestamp timeStamp}) async {
    this.datePaid = datePaid;
    this.downPayment = downPayment;
    this.interest = interest;
    this.loan = loan;
    this.monthlyRepayment = monthlyRepayment;
    this.tenure = tenure;
    this.timeStamp = timeStamp;
    notifyListeners();
  }
}