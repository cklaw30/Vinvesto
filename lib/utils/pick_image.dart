import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<File?> pickImage(BuildContext context) async {
  // File? image;
  try {
    // final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if(pickedImage != null){
    //   image = File(pickedImage.path);
    // }

    List<MediaFile>? singleMedia = await GalleryPicker.pickMedia(context: context, singleMedia: true);
    return singleMedia?.first.getFile();
  } catch (e) {
    showSnackBar(context, e.toString());
  }

  // return image;
}

Future<String> uploadImageToStorage(File file, String dir) async {
  // final userId = FirebaseAuth.instance.currentUser?.uid;
  final storageRef = FirebaseStorage.instance.ref();
  final fileName = file.path.split("/").last;
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  final uploadRef = storageRef.child('$dir/uploads/$timestamp-$fileName');
  UploadTask uploadTask = uploadRef.putFile(file);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}