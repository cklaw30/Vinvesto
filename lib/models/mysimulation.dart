import 'package:cloud_firestore/cloud_firestore.dart';

class MySimulation{
  final int age;
  final List<double> currentAssets;
  final String employmentStatus;
  final String salary;
  final Timestamp timestamp;
  final List<Map<String, dynamic>> properties; // Property property, double downpayment (this downpayment should storing percent, how many percent by total amount should be the down payment), List<double> loan (concept same as total assets, the last elements is the current loan, outstanding is total - down payment - all the elements in list loan)
  final List<Map<String, dynamic>> fds;
  final List<Map<String, dynamic>> stocks;

  MySimulation({
    required this.age,
    required this.currentAssets,
    required this.employmentStatus,
    required this.salary,
    required this.timestamp,
    required this.properties,
    required this.fds,
    required this.stocks,
  });

  factory MySimulation.fromMap(Map<String, dynamic> map) {
    return MySimulation(
        age: map['age'],
        currentAssets: List<double>.from(map['currentAssets']),
        employmentStatus: map['employmentStatus'],
        salary: map['salary'],
        timestamp: map['timestamp'],
        properties: List<Map<String, dynamic>>.from(map['properties']),
        fds: List<Map<String, dynamic>>.from(map['fds']),
        stocks: List<Map<String, dynamic>>.from(map['stocks']),
      );
  }

  Map<String, dynamic> toMap() {
    return{
      'age': age,
      'currentAssets': currentAssets,
      'employmentStatus': employmentStatus,
      'salary': salary,
      'timestamp': timestamp,
      'properties': properties,
      'fds': fds,
      'stocks': stocks,
    };
  }

}