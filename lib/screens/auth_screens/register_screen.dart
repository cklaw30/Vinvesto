import 'package:demo_google/componenets/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  const RegisterScreen({super.key, this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _obsureText = true;

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
                            fontSize: mHeight * 0.03526,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: mHeight * 0.6264,
                  padding: EdgeInsets.only(
                      top: mHeight * 0.02938,
                      bottom: mHeight * 0.02938,
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
                        'CREATE AN ACCOUNT',
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
                        height: mHeight * 0.01175,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Confirm Password',
                            style: TextStyle(
                                fontSize: mHeight * 0.02115,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          TextField(
                            controller: confirmPasswordController,
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
                        height: mHeight * 0.03526,
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
                          signUserUp();
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: mWidth * 0.71296,
                          height: mHeight * 0.05876,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.yellow.shade100),
                          child: Center(
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                  fontSize: mHeight * 0.02115,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?',
                              style: TextStyle(
                                  fontSize: mHeight * 0.02115,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(
                            width: mWidth * 0.01273,
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text('Sign In Now',
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

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        showSnackBar(context, "Password and Confirm Password does not match");
      }
    } on FirebaseAuthException catch (e) {
      // empty filling email and/or password
      if (e.code == 'channel-error') {
        showSnackBar(context, "Email and Password cannot be empty");
      }

      // email-already-in-use
      else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "This email is already registered.");
      }

      // weak-password
      else if (e.code == 'weak-password') {
        showSnackBar(context,
            "Your password is too weak, please pick a stronger password.");
      }

      // invalid-email
      else if (e.code == 'invalid-email') {
        showSnackBar(context, 'Invalid Email');
      } else {
        showSnackBar(context, e.code);
      }
    }

    Navigator.pop(context);
  }
}
