import 'package:flutter/material.dart';
import 'package:insta_app/screens/add_post_screen.dart';
import 'package:insta_app/screens/home_screen.dart';
import 'package:insta_app/screens/profile_screen.dart';
import 'package:insta_app/screens/search_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selctedIndex = 0;
  List<Widget> listOfScreens = [
    HomeScreen(),
    // Scaffold(),
    SearchScreen(),
    AddPost(),
    ProfileScreen(),
  ];
  void selectedPage(int index) {
    setState(() {
      selctedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: listOfScreens[selctedIndex],
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.white,
          currentIndex: selctedIndex,
          onTap: selectedPage,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 26,
                  color: Colors.white,
                ),
                label: 'Home',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 26, color: Colors.white),
                label: 'Search',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.add, size: 26, color: Colors.white),
                label: 'Add Post',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 26, color: Colors.white),
                label: 'Profile',
                backgroundColor: Colors.black),
          ]),
    );
  }
}
