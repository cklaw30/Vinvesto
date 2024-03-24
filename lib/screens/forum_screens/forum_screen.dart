import 'package:demo_google/componenets/forum_tile.dart';
import 'package:demo_google/repositories/forum_repository.dart';
import 'package:demo_google/screens/forum_screens/add_forum_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final _forumRepo = ForumRepository();
  int? count;

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: mHeight * 0.06581, 
        title: Text("Forum", style: TextStyle(fontSize: mHeight * 0.032905, fontWeight: FontWeight.bold),)),
      body: SafeArea(
        child: Column(
          children: [
            // text field to share a post
            Padding(
              padding: EdgeInsets.only(top: mHeight * 0.01645, bottom: mHeight * 0.01645, left: mWidth * 0.03565, right: mWidth * 0.03565),
              child: Row(
                children: [
                  Container(
                    height: mHeight*0.05288,
                    width: mWidth*0.11458,
                    margin: EdgeInsets.only(right: mWidth * 0.02037),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('images/avatar.png')),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddForumScreen())),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.bubble_chart_outlined),
                            hintText: 'Share us something',
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                borderSide: BorderSide(color: Colors.blue)),
                            contentPadding: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // display all the post
            Expanded(
              flex: 7,
              child: StreamBuilder(
                  stream: _forumRepo.getForumStream(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Connection Error');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var docs = snapshot.data!.docs;

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final forum = docs[index];
                        List<String> likes =
                            List<String>.from(forum['likes'] ?? []);
                        List<Map<String, dynamic>> comments =
                            List<Map<String, dynamic>>.from(
                                forum['comments'] ?? []);
                        return ForumTile(
                          author: forum['author'],
                          content: forum['content'],
                          timestamp: forum['timestamp'],
                          forumId: forum.id,
                          likes: likes,
                          isLiked: likes.contains(user.email),
                          comments: comments,
                          imagePath: forum['imagePath'],
                        );
                      },
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
