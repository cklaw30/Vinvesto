import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/models/myuser.dart';

class MyUserRepository {
  Future<void> addUserDetails({required String uid, required MyUser user}) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(user.toMap());
  }

  Future<MyUser> getUserDetails({required String uid}) async {
    final docRef = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = docRef.data() as Map<String, dynamic>; // initially was Map<String, dynamic>?
    return MyUser.fromMap(data);
  }
}
