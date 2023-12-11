import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/consts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: backGroundColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              MaterialCommunityIcons.home_variant,
              color: primaryColor,
            ),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.md_search,
              color: primaryColor,
            ),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.md_add_circle,
              color: primaryColor,
            ),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: primaryColor,
            ),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              color: primaryColor,
            ),
            label: '',
          ),
        ],

        onTap: navigationTapped,
      ),

      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children:  const [
          Center(
            child: Text(
              'Home',
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),

          Center(
            child: Text(
              'Search',
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),

          Center(
            child: Text(
              'Post',
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),

          Center(
            child: Text(
              'ACtivity',
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),

          Center(
            child: Text(
              'Profile',
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
