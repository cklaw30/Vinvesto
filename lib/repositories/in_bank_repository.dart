import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/models/in_bank.dart';

class InBankRepository {
  Future<void> inBank(
      {required String uid, required String simulationId, required InBank inBank}) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).collection('simulations').doc(simulationId).update({
      'fds': FieldValue.arrayUnion([inBank.toMap()])
    });
  }

  // Stream<DocumentSnapshot<Map<String, dynamic>>> getOwnedPropertyStream(
  //     {required String uid, required String simulationId}) {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .collection('simulations')
  //       .doc(simulationId)
  //       .snapshots();
  // }
}
