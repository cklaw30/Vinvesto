import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/models/mysimulation.dart';

class MySimulationRepository {
  Future<DocumentReference> addSimulationAcc({required String uid, required MySimulation simulation}) async {
    return await FirebaseFirestore.instance.collection('users').doc(uid).collection('simulations').add(simulation.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSimulationAccStream({required String uid}) {
    return FirebaseFirestore.instance.collection('users').doc(uid).collection('simulations').orderBy('timestamp', descending: true).snapshots();
  }

  Future<MySimulation> getSimulationModel({required String uid, required String simulationId}) async {
    final docRef = await FirebaseFirestore.instance.collection('users').doc(uid).collection('simulations').doc(simulationId).get();
    final data = docRef.data() as Map<String, dynamic>; // initially was Map<String, dynamic>?
    return MySimulation.fromMap(data);
  }

  void updateCurrentAssets({required String uid, required String simulationId, required double currentAssets}) {
    FirebaseFirestore.instance.collection('users').doc(uid).collection('simulations').doc(simulationId).update({
      "currentAssets": FieldValue.arrayUnion([currentAssets])
    });
  }
}
