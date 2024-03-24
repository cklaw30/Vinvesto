import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/models/bank.dart';

class BankRepository{
  Future<void> addBank({required Bank bank}) async {
    await FirebaseFirestore.instance.collection('banks').add(bank.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBankStream() {
    return FirebaseFirestore.instance
        .collection('banks')
        .snapshots();
  }

  // Future<Property> getPropertyDetails({required String propertyId}) async {
  //   final docRef = await FirebaseFirestore.instance.collection('properties').doc(propertyId).get();
  //   final data = docRef.data() as Map<String, dynamic>; // initially was Map<String, dynamic>?
  //   return Property.fromMap(data);
  // }
}