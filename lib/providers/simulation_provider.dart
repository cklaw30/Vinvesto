import 'package:flutter/material.dart';

class SimulationProvider extends ChangeNotifier {
  double currentAssets;
  String employmentStatus;
  int age;
  String simulationId;
  List<String> propertyIds;
  List<String> bankIds;
  

  SimulationProvider({
    this.currentAssets = 0.0,
    this.employmentStatus = '',
    this.age = 0,
    this.simulationId = '',
    this.propertyIds = const [],
    this.bankIds = const [],
  });

  void getSimulationDetails({required double currentAssets, required String employmentStatus, required int age, required String simulationId, required List<String> propertyIds, required List<String> bankIds}) async {
    this.currentAssets = currentAssets;
    this.employmentStatus = employmentStatus;
    this.age = age;
    this.simulationId = simulationId;
    this.propertyIds = propertyIds;
    this.bankIds = bankIds;
    notifyListeners();
  }

  void changeCurrentAssets({required double moneySpent}) {
    currentAssets -= moneySpent;
    notifyListeners();
  }

  void addPropertyId({required String propertyId}) {
    propertyIds.add(propertyId);
    notifyListeners();
  }

  void addBankId({required String bankId}) {
    bankIds.add(bankId);
    notifyListeners();
  }
}