import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/models/property.dart';

class PropertyRepository{
  Future<void> addProperty({required Property property}) async {
    await FirebaseFirestore.instance.collection('properties').add(property.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPropertyStream() {
    return FirebaseFirestore.instance
        .collection('properties')
        .snapshots();
  }

  Future<Property> getPropertyDetails({required String propertyId}) async {
    final docRef = await FirebaseFirestore.instance.collection('properties').doc(propertyId).get();
    final data = docRef.data() as Map<String, dynamic>; // initially was Map<String, dynamic>?
    return Property.fromMap(data);
  }
}