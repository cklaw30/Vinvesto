import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/componenets/comment_tile.dart';
import 'package:demo_google/componenets/my_snackbar.dart';
import 'package:demo_google/models/comment.dart';
import 'package:demo_google/providers/user_provider.dart';
import 'package:demo_google/repositories/comment_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final String forumId;
  const CommentScreen({super.key, required this.forumId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final _commentRepo = CommentRepository();
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream:
                      _commentRepo.getCommentStream(forumId: widget.forumId),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Connection Error');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var docs = snapshot.data!;
                    List<Map<String, dynamic>> comments =
                        List<Map<String, dynamic>>.from(docs['comments'] ?? []);
                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return CommentTile(
                            commentor: comment['commentor'],
                            content: comment['comment'],
                            timestamp: comment['timestamp']);
                      },
                    );
                  }))),
          Padding(
            padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.bubble_chart_outlined),
                        hintText: 'Drop your comment here',
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                            borderSide: BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                            borderSide: BorderSide(color: Colors.blue.shade500)),
                        contentPadding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037)),
                  ),
                ),
                IconButton(
                    onPressed: addComment,
                    icon: const Icon(Icons.arrow_circle_right_outlined)),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }

  Future<void> addComment() async {
    final up = Provider.of<UserProvider>(context, listen: false);
    if (commentController.text.trim() != "") {
      Comment commentModel = Comment(
          commentor: up.userModel!.name,
          comment: commentController.text,
          timestamp: Timestamp.now());

      _commentRepo.addComment(forumId: widget.forumId, comment: commentModel);

      commentController.clear();
    } else {
      showSnackBar(context, 'You are not allowed to comment nothing');
    }
  }
}
