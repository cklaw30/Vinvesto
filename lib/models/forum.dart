import 'package:cloud_firestore/cloud_firestore.dart';

class Forum {
  final String content;
  final String author;
  final Timestamp timestamp;
  final List<String> likes;
  final List<Map<String, dynamic>> comments;
  final String imagePath;

  Forum({
    required this.content,
    required this.author,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.imagePath
  });

  factory Forum.fromMap(Map<String, dynamic> map) {
    return Forum(
        content: map['content'],
        author: map['author'],
        timestamp: map['timestamp'],
        likes: List<String>.from(map['likes']),
        comments: List<Map<String, dynamic>>.from(map['comments']),
        imagePath: map['imagePath'],
      );
  }

  Map<String, dynamic> toMap() {
    return{
      'content': content,
      'author': author,
      'timestamp': timestamp,
      'likes': likes,
      'comments': comments,
      'imagePath': imagePath,
    };
  }
}
