import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/models/forum.dart';
import 'package:demo_google/providers/user_provider.dart';
import 'package:demo_google/repositories/forum_repository.dart';
import 'package:demo_google/utils/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_google/componenets/my_snackbar.dart' as MySnackBar;

class AddForumScreen extends StatefulWidget {
  const AddForumScreen({super.key});

  @override
  State<AddForumScreen> createState() => _AddForumScreenState();
}

class _AddForumScreenState extends State<AddForumScreen> {
  final contentController = TextEditingController();
  final _forumRepo = ForumRepository();
  File? image;

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    final up = Provider.of<UserProvider>(context, listen: false);
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - (mHeight*0.88141),
                width: MediaQuery.of(context).size.width,
              ),

              Container(
                height: mHeight*0.84733,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: mHeight * 0.0188, bottom: mHeight * 0.0188, left: mWidth * 0.04074, right: mWidth * 0.04074),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.zero,
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Expanded(child: Text('Create Post', style: TextStyle(fontSize: mHeight*0.03526, fontWeight: FontWeight.bold),)),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(Icons.close, size: mHeight*0.05288,)
                        )
                      ],
                    ),

                    SizedBox(height: mHeight*0.0235,),

                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: mHeight*0.07639,
                                width: mWidth*0.16551,
                                margin: EdgeInsets.only(right: mWidth * 0.02037),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                  fit: BoxFit.fill, image: AssetImage('images/avatar.png')),
                                ),
                              ),
                          
                              SizedBox(width: mWidth*0.02546,),
                          
                              Text(up.userModel!.name, style: TextStyle(fontSize: mHeight*0.03526, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),

                      GestureDetector(
                        onTap: () => selectImage(),
                        child: Icon(Icons.image_outlined, size: mHeight*0.04701,),
                      ),
                      ],
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: mHeight*0.52885,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: mHeight*0.26442,
                            child: TextFormField(
                              minLines: 1,
                              maxLines: 15,
                              controller: contentController,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: 'Share us something',
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white),
                                )),
                            ),
                          ),

                          image == null
                          ? Container()
                          :
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: mHeight*0.2644,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill, image: FileImage(image!))
                            ),
                          )
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(child: Container()),

                        GestureDetector(
                          onTap: () => addForumContent(),
                          child: Container(
                            width: mWidth*0.17824,
                            height: mHeight*0.08226,
                            margin: EdgeInsets.only(top: mHeight * 0.009401, bottom: mHeight * 0.009401, left: mWidth * 0.02037, right: mWidth * 0.02037),
                            padding: EdgeInsets.only(left: mWidth*0.01273, bottom: mHeight*0.005876),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.blue.shade300
                            ),
                            child: Image.asset('images/post.png'),
                          ),
                        )
                      ],
                    )


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addForumContent() async {
    final up = Provider.of<UserProvider>(context, listen: false);
    if (contentController.text.trim() != "") {

      showDialog(
        context: context, 
        builder: (context) {
          final mHeight = MediaQuery.of(context).size.height;
          final mWidth = MediaQuery.of(context).size.width;
          return Center(
            child: Container(
              padding: EdgeInsets.only(top: mHeight * 0.014102, bottom: mHeight * 0.014102, left: mWidth * 0.03056, right: mWidth * 0.03056),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(16.0)
              ),
              child: Text('Posting... Please wait', style: TextStyle(fontSize: mHeight*0.0188, color: Colors.black),),),);
      });

      if (image == null) {
        Forum forumModel = Forum(
          content: contentController.text,
          author: up.userModel!.name,
          timestamp: Timestamp.now(),
          likes: [],
          comments: [],
          imagePath: '',
        );

        _forumRepo.addForumContent(forum: forumModel);
      } else {
        String downloadUrl = await uploadImageToStorage(image!, 'forum');
        Forum forumModel = Forum(
          content: contentController.text,
          author: up.userModel!.name,
          timestamp: Timestamp.now(),
          likes: [],
          comments: [],
          imagePath: downloadUrl,
        );

        _forumRepo.addForumContent(forum: forumModel);
      }

      contentController.clear();

      Navigator.of(context).pop();
      Navigator.pop(context);

      MySnackBar.showSnackBar(context, "Temporary snackbar, posted!!!");
    } else {
      MySnackBar.showSnackBar(context, "Uhhhh, you are not allowed to share nothing...");
    }
  }
}