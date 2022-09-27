import 'package:flutter/material.dart';
import 'package:quizu/core/utills/assets_manager.dart';
import 'package:quizu/features/leaderboard/presentation/pages/leaderboard_screen.dart';
import 'package:quizu/features/quiz/presentation/pages/home_screen.dart';
import 'package:quizu/features/quiz/presentation/pages/profile_screen.dart';
import 'package:quizu/features/quiz/presentation/pages/quiz_screen.dart';

class BottomNavigationBarTabs extends StatefulWidget {
  const BottomNavigationBarTabs({super.key});

  @override
  State<BottomNavigationBarTabs> createState() => _BottomNavigationBarTabsState();
}

class _BottomNavigationBarTabsState extends State<BottomNavigationBarTabs> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    LeaderboardScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("QuizU ⏳",
                style:
                TextStyle(fontSize: 30, fontWeight: FontWeight.w500,color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SizedBox(),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:   <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(ImageAssets.homeIcon),
              fit: BoxFit.contain,
              color: _selectedIndex == 0?Colors.black:Color(0xff959494),
              height: 35,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(ImageAssets.leaderboardIcon),
              fit: BoxFit.contain,
              color: _selectedIndex == 1?Colors.black:Color(0xff959494),
              height: 40,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(ImageAssets.profileIcon),
              fit: BoxFit.contain,
              color: _selectedIndex == 2?Colors.black:Color(0xff959494),
              height: 35,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}