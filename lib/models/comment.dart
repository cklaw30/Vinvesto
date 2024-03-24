import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String commentor;
  final String comment;
  final Timestamp timestamp;

  Comment({
    required this.commentor,
    required this.comment,
    required this.timestamp,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
        commentor: map['commentor'],
        comment: map['comment'],
        timestamp: map['timestamp']);
  }

  Map<String, dynamic> toMap() {
    return{
      'commentor': commentor,
      'comment': comment,
      'timestamp': timestamp,
    };
  }
}