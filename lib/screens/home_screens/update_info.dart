import 'package:demo_google/componenets/my_snackbar.dart';
import 'package:demo_google/models/myuser.dart';
import 'package:demo_google/providers/user_provider.dart';
import 'package:demo_google/repositories/myuser_repository.dart';
import 'package:demo_google/screens/home_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  final _userRepo = MyUserRepository();

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: mHeight * 0.06464,
              ),
              Text(
                'Complete Profile',
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
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
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
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      suffixIcon: IconButton(
                          onPressed: () => ageController.clear(),
                          icon: Icon(Icons.close_rounded))),
                ),
              ),
              SizedBox(
                height: mHeight * 0.4113,
              ),
              GestureDetector(
                onTap: () => addUserDetails(),
                child: Container(
                  margin: EdgeInsets.only(
                      top: mHeight * 0.009401,
                      bottom: mHeight * 0.009401,
                      left: mWidth * 0.02037,
                      right: mWidth * 0.02037),
                  width: double.infinity,
                  height: mHeight * 0.07051,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: Center(
                      child: Text(
                    'Save',
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addUserDetails() async {
    // check if every field is filled completely
    if (nameController.text != "" && ageController.text != "") {
      // get the userModel in type of MyUser
      // MyUser userModel = MyUser(name: nameController.text, email: user.email!, age: int.parse(ageController.text), employmentStatus: employmentStatus!, salary: salary!, role: 'User');
      MyUser userModel = MyUser(
          name: nameController.text,
          email: user.email!,
          age: int.parse(ageController.text),
          role: 'User');

      // pass the uid and userModel to userRepo to add to the Firestore
      _userRepo.addUserDetails(uid: user.uid, user: userModel);

      context.read<UserProvider>().storeUserToSP(userModel: userModel);

      // navigate to the Home Screen
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => HomeScreen())));
    } else {
      showSnackBar(context, "Please fill in every section before proceeding");
    }
  }
}
