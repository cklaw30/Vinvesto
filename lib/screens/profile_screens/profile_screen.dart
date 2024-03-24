import 'package:demo_google/providers/user_provider.dart';
import 'package:demo_google/screens/auth_screens/auth_screen.dart';
import 'package:demo_google/screens/profile_screens/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final up = Provider.of<UserProvider>(context, listen: false);
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: mHeight * 0.06581,
        title: Text(
          "My Profile",
          style: TextStyle(
              fontSize: mHeight * 0.03291, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade100,
      ),
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: mHeight * 0.2703,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: mHeight * 0.10577,
                      width: mWidth * 0.22917,
                      margin: EdgeInsets.only(right: mWidth * 0.02037),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('images/avatar.png')),
                      ),
                    ),
                    SizedBox(
                      height: mHeight * 0.01175,
                    ),
                    Text(
                      up.userModel!.name,
                      style: TextStyle(
                          fontSize: mHeight * 0.02585,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: mHeight * 0.005876,
                    ),
                    Text(
                      up.userModel!.email,
                      style: TextStyle(fontSize: mHeight * 0.0188),
                    ),
                    SizedBox(
                      height: mHeight * 0.005876,
                    ),
                    Text(
                      up.userModel!.age.toString(),
                      style: TextStyle(fontSize: mHeight * 0.0188),
                    ),
                    SizedBox(
                      height: mHeight * 0.03526,
                    )
                  ],
                ),
              ),
              Container(
                height: mHeight * 0.51768,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                    color: Colors.white),
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileScreen())),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: mWidth * 0.15278,
                              ),
                              Container(
                                height: mHeight * 0.05876,
                                width: mWidth * 0.12731,
                                padding: EdgeInsets.only(
                                    top: mHeight * 0.009401,
                                    bottom: mHeight * 0.009401,
                                    left: mWidth * 0.02037,
                                    right: mWidth * 0.02037),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.blue.shade100,
                                ),
                                child: Image.asset('images/edit_profile.png'),
                              ),
                              SizedBox(
                                width: mWidth * 0.076388,
                              ),
                              Text(
                                'Edit Profile',
                                style: TextStyle(fontSize: mHeight * 0.0188),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: mWidth * 0.15278,
                            ),
                            Container(
                              height: mHeight * 0.05876,
                              width: mWidth * 0.12731,
                              padding: EdgeInsets.only(
                                  top: mHeight * 0.009401,
                                  bottom: mHeight * 0.009401,
                                  left: mWidth * 0.02037,
                                  right: mWidth * 0.02037),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.blue.shade100,
                              ),
                              child:
                                  Image.asset('images/privacy and security.png'),
                            ),
                            SizedBox(
                              width: mWidth * 0.076388,
                            ),
                            Text(
                              'Privacy and Security',
                              style: TextStyle(fontSize: mHeight * 0.0188),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: mWidth * 0.15278,
                            ),
                            Container(
                              height: mHeight * 0.05876,
                              width: mWidth * 0.12731,
                              padding: EdgeInsets.only(
                                  top: mHeight * 0.009401,
                                  bottom: mHeight * 0.009401,
                                  left: mWidth * 0.02037,
                                  right: mWidth * 0.02037),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.blue.shade100,
                              ),
                              child: Image.asset('images/support.png'),
                            ),
                            SizedBox(
                              width: mWidth * 0.076388,
                            ),
                            Text(
                              'Support',
                              style: TextStyle(fontSize: mHeight * 0.0188),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => signUserOut(),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: mHeight * 0.07051,
                              ),
                              Container(
                                height: mHeight * 0.05876,
                                width: mWidth * 0.12731,
                                padding: EdgeInsets.only(
                                    top: mHeight * 0.009401,
                                    bottom: mHeight * 0.009401,
                                    left: mWidth * 0.02037,
                                    right: mWidth * 0.02037),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.blue.shade100,
                                ),
                                child: Image.asset('images/logout.png'),
                              ),
                              SizedBox(
                                width: mWidth * 0.076388,
                              ),
                              Text(
                                'Log Out',
                                style: TextStyle(
                                    fontSize: mHeight * 0.0188,
                                    color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }
}
