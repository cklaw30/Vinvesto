import 'package:flutter/material.dart';

class PropertyProvider extends ChangeNotifier {
  String imagePath;
  String name;
  double price;
  String type;
  int bedroom;
  int bathroom;
  int sqft;
  String street;
  String city;
  String county;
  String propertyId;
  // double downPaymentPercent;
  

  PropertyProvider({
    this.imagePath = '',
    this.name = '',
    this.price = 0.0,
    this.type = '',
    this.bedroom = 0,
    this.bathroom = 0,
    this.sqft = 0,
    this.street = '',
    this.city = '',
    this.county = '',
    this.propertyId = '',
    // this.downPaymentPercent = 10,
  });

  void getPropertyDetails({required String imagePath, required String name, required double price, required String type, required int bedroom, required int bathroom, required int sqft, required String street, required String city, required String county, required String propertyId}) async {
    this.imagePath = imagePath;
    this.name = name;
    this.price = price;
    this.type = type;
    this.bedroom = bedroom;
    this.bathroom = bathroom;
    this.sqft = sqft;
    this.street = street;
    this.city = city;
    this.county = county;
    this.propertyId = propertyId;
    notifyListeners();
  }

  // void getDownPaymentPercent({required double downPaymentPercent}) {
  //   this.downPaymentPercent = downPaymentPercent;
  //   notifyListeners();
  // }
}