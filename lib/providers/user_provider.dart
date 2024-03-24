import 'dart:convert';

import 'package:demo_google/models/myuser.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  MyUser? userModel;
  bool isLoading;

  UserProvider({
    this.isLoading = true
  });

  void storeUserToSP({required MyUser userModel}) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("userModel", jsonEncode(userModel.toMap()));
    getUserFromSP();
    notifyListeners();
  }

  void changeIsLoading({required bool isLoading}) async {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void getUserFromSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    final String? userJson = s.getString('userModel');
    userModel = MyUser.fromMap(jsonDecode(userJson!));
    notifyListeners();
  }
}