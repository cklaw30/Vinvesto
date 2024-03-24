import 'package:cloud_firestore/cloud_firestore.dart';

class Stock {
  final String imagePath;
  final String tickerSymbol;
  final String name;
  final List<Timestamp> timeStamp;
  final List<double> price;

  Stock({
    required this.imagePath,
    required this.tickerSymbol,
    required this.name,
    required this.timeStamp,
    required this.price,
  });

  factory Stock.fromMap(Map<String, dynamic> map) {
    return Stock(
        imagePath: map['imagePath'],
        tickerSymbol: map['tickerSymbol'],
        name: map['name'],
        timeStamp: map['timeStamp'],
        price: map['price'],);
        
  }

  Map<String, dynamic> toMap() {
    return{
      'imagePath': imagePath,
      'tickerSymbol': tickerSymbol,
      'name': name,
      'timeStamp': timeStamp,
      'price': price,
    };
  }
}