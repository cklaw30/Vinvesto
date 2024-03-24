import 'package:flutter/material.dart';

class BankProvider extends ChangeNotifier {
  String bankId;
  String name;
  bool isOpenedAcc;  

  BankProvider({
    this.bankId = '',
    this.name = '',
    this.isOpenedAcc = false,
  });

  void getBankDetails({required String bankId, required String name, required bool isOpenedAcc}) async {
    this.bankId = bankId;
    this.name = name;
    this.isOpenedAcc = isOpenedAcc;
    notifyListeners();
  }

  void changeIsOpenedAcc({required bool isOpenedAcc}) async {
    this.isOpenedAcc = isOpenedAcc;
    notifyListeners();
  }
}