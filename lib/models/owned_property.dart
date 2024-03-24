import 'package:cloud_firestore/cloud_firestore.dart';

class OwnedProperty {
  final String propertyId;
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
  final double downPayment;
  final double loan;
  final double interest; // rate
  final int tenure;
  final double monthlyRepayment;
  final List<Timestamp> datePaid;
  // final List<double> principal; // just for graphing
  // final List<double> interest; // just for graphing
  final Timestamp timeStamp;

  OwnedProperty({
    required this.propertyId,
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
    required this.downPayment,
    required this.loan,
    required this.interest,
    required this.tenure,
    required this.monthlyRepayment,
    required this.datePaid,
    required this.timeStamp,
  });

  factory OwnedProperty.fromMap(Map<String, dynamic> map) {
    return OwnedProperty(
      propertyId: map['propertyId'], 
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
      downPayment: map['downPayment'], 
      loan: map['loan'], 
      interest: map['interest'], 
      tenure: map['tenure'],
      monthlyRepayment: map['monthlyRepayment'], 
      datePaid: List<Timestamp>.from(map['datePaid']), 
      timeStamp: map['timeStamp'], 
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'propertyId': propertyId,
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
      'downPayment': downPayment,
      'loan': loan,
      'interest': interest,
      'tenure': tenure,
      'monthlyRepayment': monthlyRepayment,
      'datePaid': datePaid,
      'timeStamp': timeStamp,
    };
  }

}