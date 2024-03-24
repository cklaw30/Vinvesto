import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/models/forum.dart';

class ForumRepository {
  Future<void> addForumContent({required Forum forum}) async {
    await FirebaseFirestore.instance.collection('forums').add(forum.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getForumStream() {
    return FirebaseFirestore.instance
        .collection('forums')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
