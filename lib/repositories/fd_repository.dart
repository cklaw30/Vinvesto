import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/models/fd.dart';

class FDRepository {
  Future<void> addFD(
      {required String bankId, required String oORs, required FD fd}) async {
    await FirebaseFirestore.instance.collection('banks').doc(bankId).update({
      oORs: FieldValue.arrayUnion([fd.toMap()])
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getFDStream(
      {required String bankId}) {
    return FirebaseFirestore.instance
        .collection('banks')
        .doc(bankId)
        .snapshots();
  }
}
