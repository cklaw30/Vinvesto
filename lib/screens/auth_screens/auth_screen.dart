import 'package:demo_google/models/myuser.dart';
import 'package:demo_google/providers/user_provider.dart';
import 'package:demo_google/repositories/myuser_repository.dart';
import 'package:demo_google/screens/auth_screens/login_or_register_screen.dart';
import 'package:demo_google/screens/home_screens/home_screen.dart';
import 'package:demo_google/screens/home_screens/update_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return FutureBuilder<MyUser>(
              future: MyUserRepository().getUserDetails(uid: snapshot.data!.uid),
              builder: (context, registrationSnapshot) {
                if (registrationSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (registrationSnapshot.hasData) {
                  MyUser userModel = registrationSnapshot.data!;
                  context.read<UserProvider>().storeUserToSP(userModel: userModel);
                  return HomeScreen();
                } else {
                  return const UpdateInfoScreen();
                }
              },
            );
          } else {
            return const LoginOrRegisterScreen();
          }
        },
      ),
    );
  }
}
