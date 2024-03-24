import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/models/owned_property.dart';

class OwnedPropertyRepository {
  Future<void> buyProperty(
      {required String uid, required String simulationId, required OwnedProperty ownedProperty}) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).collection('simulations').doc(simulationId).update({
      'properties': FieldValue.arrayUnion([ownedProperty.toMap()])
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getOwnedPropertyStream(
      {required String uid, required String simulationId}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('simulations')
        .doc(simulationId)
        .snapshots();
  }
}
