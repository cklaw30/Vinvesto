import 'package:cloud_firestore/cloud_firestore.dart';

class Property {
  final String name; // project name
  final String street;
  final String city;
  final String county;
  final String type; // project type: condominium
  final double price;
  final int bedroom;
  final int bathroom;
  final String imagePath;
  final int sqft;
  final Timestamp timestamp;

  Property({
    required this.name, 
    required this.street,  
    required this.city, 
    required this.county, 
    required this.type, 
    required this.price, 
    required this.bedroom, 
    required this.bathroom,
    required this.imagePath,
    required this.sqft,
    required this.timestamp,
  });

  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      name: map['name'], 
      street: map['street'],  
      city: map['city'],
      county: map['county'], 
      type: map['type'], 
      price: map['price'], 
      bedroom: map['bedroom'], 
      bathroom: map['bathroom'],
      imagePath: map['imagePath'],
      sqft: map['sqft'],
      timestamp: map['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'name': name,
      'street': street,
      'city': city,
      'county': county,
      'type': type,
      'price': price,
      'bedroom': bedroom,
      'bathroom': bathroom,
      'imagePath': imagePath,
      'sqft': sqft,
      'timestamp': timestamp,
    };
  }
}