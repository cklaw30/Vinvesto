import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/models/comment.dart';

class CommentRepository {
  Future<void> addComment(
      {required String forumId, required Comment comment}) async {
    await FirebaseFirestore.instance.collection('forums').doc(forumId).update({
      'comments': FieldValue.arrayUnion([comment.toMap()])
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCommentStream(
      {required String forumId}) {
    return FirebaseFirestore.instance
        .collection('forums')
        .doc(forumId)
        .snapshots();
  }
}
