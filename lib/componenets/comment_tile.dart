import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentTile extends StatefulWidget {
  final String commentor;
  final String content;
  final Timestamp timestamp;
  const CommentTile({super.key, required this.commentor, required this.content, required this.timestamp});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: mHeight *0.0141025,bottom: mHeight *0.0141025,left: mWidth *0.030555, right: mWidth *0.030555),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: mHeight *0.0141025,bottom: mHeight *0.0141025,left: mWidth *0.030555, right: mWidth *0.030555),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                
                SizedBox(width: mWidth*0.012731,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.commentor, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(widget.content),
                    Text(timeago.format(getPostedAgo()), style: TextStyle(fontSize: mHeight*0.0141025, color: Colors.grey.shade600),),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  DateTime getPostedAgo() {
    int duration = Timestamp.now().millisecondsSinceEpoch - widget.timestamp.millisecondsSinceEpoch;

    DateTime postedAgo = DateTime.now().subtract(Duration(milliseconds: duration));

    return postedAgo;
  }
}