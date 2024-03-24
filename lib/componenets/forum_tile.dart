import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/componenets/comment_button.dart';
import 'package:demo_google/componenets/like_button.dart';
import 'package:demo_google/screens/forum_screens/comment_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ForumTile extends StatefulWidget {
  final String author;
  final String content;
  final Timestamp timestamp;
  final String forumId;
  final List<String> likes;
  bool isLiked;
  final List<Map<String, dynamic>> comments;
  final String imagePath;

  ForumTile(
      {super.key,
      required this.author,
      required this.content,
      required this.timestamp,
      required this.forumId,
      required this.likes,
      required this.isLiked,
      required this.comments,
      required this.imagePath});

  @override
  State<ForumTile> createState() => _ForumTileState();
}

class _ForumTileState extends State<ForumTile> {
  final user = FirebaseAuth.instance.currentUser!;
  bool changeIsLiked = false;

  void toggleLike() {
    setState(() {
      widget.isLiked = !widget.isLiked;
    });

    DocumentReference forumRef =
        FirebaseFirestore.instance.collection('forums').doc(widget.forumId);

    if (widget.isLiked) {
      forumRef.update({
        'likes': FieldValue.arrayUnion([user.email])
      });
    } else {
      forumRef.update({
        'likes': FieldValue.arrayRemove([user.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: mHeight *0.0141025,bottom: mHeight *0.0141025,left: mWidth *0.030555, right: mWidth *0.030555),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
      child: Padding(
        padding: EdgeInsets.only(top: mHeight *0.0141025,bottom: mHeight *0.0141025,left: mWidth *0.030555, right: mWidth *0.030555),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: mHeight*0.05288,
                  width: mWidth*0.1145825,
                  margin: EdgeInsets.only(right: mWidth*0.02037),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('images/avatar.png')),
                  ),
                ),
                SizedBox(
                  width: mWidth*0.012731,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.author,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      timeago.format(getPostedAgo()),
                      style:
                          TextStyle(fontSize: mHeight*0.0141025, color: Colors.grey.shade600),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: mHeight*0.011752,
            ),
            Padding(
              padding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
              child: Text(widget.content),
            ),
            widget.imagePath != ""
            ? Container(
              width: MediaQuery.of(context).size.width,
              height: mHeight*0.199786,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(widget.imagePath)),
              ),
            )
            :
            Container(),
            SizedBox(
              height: mHeight*0.023504,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LikeButton(isLiked: widget.isLiked, onTap: toggleLike),
                SizedBox(
                  width: mWidth*0.02546,
                ),
                Text(widget.likes.length.toString()),
                SizedBox(
                  width: mWidth*0.02546,
                ),
                CommentButton(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => CommentScreen(
                      forumId: widget.forumId,
                    ),
                  ),
                ),
                SizedBox(
                  width: mWidth*0.02546,
                ),
                Text(widget.comments.length.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }

  DateTime getPostedAgo() {
    int duration = Timestamp.now().millisecondsSinceEpoch -
        widget.timestamp.millisecondsSinceEpoch;

    DateTime postedAgo =
        DateTime.now().subtract(Duration(milliseconds: duration));

    return postedAgo;
  }
}
