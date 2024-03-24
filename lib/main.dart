import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_google/firebase_options.dart';
import 'package:demo_google/providers/bank_provider.dart';
import 'package:demo_google/providers/owned_property_provider.dart';
import 'package:demo_google/providers/property_provider.dart';
import 'package:demo_google/providers/simulation_provider.dart';
import 'package:demo_google/providers/user_provider.dart';
import 'package:demo_google/screens/auth_screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PropertyProvider()),
        ChangeNotifierProvider(create: (context) => SimulationProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => OwnedPropertyProvider(timeStamp: Timestamp.now())),
        ChangeNotifierProvider(create: (context) => BankProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthScreen(),
      ),
    );
  }
}