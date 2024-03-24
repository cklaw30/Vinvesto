import 'package:demo_google/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final up = Provider.of<UserProvider>(context, listen: false);
    final nameController = TextEditingController(text: up.userModel!.name);
    final ageController =
        TextEditingController(text: up.userModel!.age.toString());
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Edit Profile',
                style: TextStyle(
                    fontSize: mHeight * 0.02585, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: mHeight * 0.0235,
              ),
              Container(
                height: mHeight * 0.10577,
                width: mWidth * 0.22917,
                margin: EdgeInsets.only(right: mWidth * 0.02037),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage('images/avatar.png')),
                ),
              ),
              SizedBox(
                height: mHeight * 0.04701,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: mHeight * 0.009401,
                    bottom: mHeight * 0.009401,
                    left: mWidth * 0.02037,
                    right: mWidth * 0.02037),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade100)),
                      suffixIcon: IconButton(
                          onPressed: () => nameController.clear(),
                          icon: Icon(Icons.close_rounded))),
                ),
              ),
              SizedBox(
                height: mHeight * 0.005876,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: mHeight * 0.009401,
                    bottom: mHeight * 0.009401,
                    left: mWidth * 0.02037,
                    right: mWidth * 0.02037),
                child: TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Age',
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade100)),
                      suffixIcon: IconButton(
                          onPressed: () => ageController.clear(),
                          icon: Icon(Icons.close_rounded))),
                ),
              ),
              SizedBox(
                height: mHeight * 0.4113,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: mHeight * 0.009401,
                    bottom: mHeight * 0.009401,
                    left: mWidth * 0.02037,
                    right: mWidth * 0.02037),
                width: double.infinity,
                height: mHeight * 0.07051,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blue.shade100,
                ),
                child: Center(
                    child: Text(
                  'Save',
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
