import 'package:demo_google/screens/forum_screens/forum_screen.dart';
import 'package:demo_google/screens/news_screens/news_screen.dart';
import 'package:demo_google/screens/profile_screens/profile_screen.dart';
import 'package:demo_google/screens/simulation_screens/manage_screens/simulation_acc_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(actions: [IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))],),
      // appBar: AppBar(title: const Text("Demo Google")),
      body: _getBody(),
      bottomNavigationBar: bottomGNav(),
    );
  }

  Widget _getBody() {
    switch (currentIndex) {
      case 0:
        return const NewsScreen();
      case 1:
        return const ForumScreen();
      case 2:
        return const SimulationAccScreen();
      default:
        return const ProfileScreen();
    }
  }

  Widget bottomGNav() {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mWidth * 0.03819, vertical: mHeight * 0.0235),
        child: GNav(
          gap: mWidth * 0.02037,
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          padding: EdgeInsets.only(
              top: mHeight * 0.0188,
              bottom: mHeight * 0.0188,
              left: mWidth * 0.04074,
              right: mWidth * 0.04074),
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.forum,
              text: 'Forum',
            ),
            GButton(
              icon: Icons.data_exploration,
              text: 'Simulation',
            ),
            GButton(
              icon: Icons.manage_accounts,
              text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
