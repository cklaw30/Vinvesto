import 'package:demo_google/componenets/my_snackbar.dart';
import 'package:demo_google/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotPasswordEmailController = TextEditingController();
  bool _obsureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: mHeight * 0.3408,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: mHeight * 0.0235,
                      ),
                      Image.asset('images/logo.png'),
                      Text(
                        'Vinvesto',
                        style: TextStyle(
                            fontSize: mHeight * 0.03525,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: mHeight * 0.6264,
                  padding: EdgeInsets.only(
                      top: mHeight * 0.0294,
                      bottom: mHeight * 0.0294,
                      left: mWidth * 0.06366,
                      right: mWidth * 0.06366),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'SIGN IN',
                        style: TextStyle(
                            fontSize: mHeight * 0.02115,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: mHeight * 0.01175,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email Address',
                            style: TextStyle(
                                fontSize: mHeight * 0.02115,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mHeight * 0.01175,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                                fontSize: mHeight * 0.02115,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: _obsureText,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obsureText = !_obsureText;
                                      });
                                    },
                                    icon: _obsureText
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mHeight * 0.005876,
                      ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          GestureDetector(
                            // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen())),
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Reset Password'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        'We will send you an email to reset your password'),
                                    TextField(
                                      controller: forgotPasswordEmailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          hintText: 'Email Address'),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => passwordReset(),
                                      child: Text('Send'))
                                ],
                              ),
                            ),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontSize: mHeight * 0.0188,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: mHeight * 0.01763,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          signUserIn();
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: mWidth * 0.712958,
                          height: mHeight * 0.058761,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.yellow.shade100),
                          child: Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                  fontSize: mHeight * 0.021154,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mHeight * 0.03526,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          SizedBox(
                            width: mWidth * 0.02546,
                          ),
                          Text(
                            'OR',
                            style: TextStyle(
                                fontSize: mHeight * 0.02115,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: mWidth * 0.02546,
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mHeight * 0.03526,
                      ),
                      GestureDetector(
                        onTap: () => AuthService().signInWithGoogle(),
                        child: Container(
                          width: mWidth * 0.8912,
                          height: mHeight * 0.04701,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/google.png',
                                height: mHeight * 0.03526,
                              ),
                              SizedBox(
                                width: mWidth * 0.02546,
                              ),
                              Text(
                                'SIGN IN WITH GOOGLE',
                                style: TextStyle(
                                    fontSize: mHeight * 0.02115,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mHeight * 0.03526,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('New User?',
                              style: TextStyle(
                                  fontSize: mHeight * 0.02115,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(
                            width: mWidth * 0.01273,
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text('Create An Account',
                                style: TextStyle(
                                    fontSize: mHeight * 0.02115,
                                    color: Colors.blue.shade200,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue.shade200,
                                    decorationThickness: 2)),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      // empty filling email and/or password
      if (e.code == 'channel-error') {
        showSnackBar(context, "Email and Password cannot be empty");
      }

      // invalid-credential
      else if (e.code == 'invalid-credential') {
        showSnackBar(context, 'Invalid Credential');
      }

      // invalid-email (it will be used when email enumeration is enabled to avoid phishing)
      else if (e.code == 'invalid-email') {
        showSnackBar(context, 'Invalid Email');
      }

      // user-not-found
      else if (e.code == 'user-not-found') {
        showSnackBar(context, 'User is not registered yet');
      }

      // wrong-password
      else if (e.code == 'wrong-password') {
        showSnackBar(context,
            'Wrong password. Reset your password if you have forgotten');
      } else {
        showSnackBar(context, e.code);
      }
    }
  }

  Future<void> passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: forgotPasswordEmailController.text.trim());
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: ((context) {
            return const AlertDialog(
              content: Text("Password reset link sent! Check your email"),
            );
          }));
    } on FirebaseAuthException catch (e) {
      // empty filling email and/or password
      if (e.code == 'channel-error') {
        showSnackBar(
            context, "Please enter the email that you want to reset password");
      }

      // invalid-email
      else if (e.code == 'invalid-email') {
        showSnackBar(context, 'Invalid Email');
      }

      // user-not-found
      else if (e.code == 'user-not-found') {
        showSnackBar(context, 'User is not registered yet');
      } else {
        showSnackBar(context, e.code);
      }
    }
  }
}
