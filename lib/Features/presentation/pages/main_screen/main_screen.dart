import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/Features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/Features/presentation/pages/activity/activity_page.dart';
import 'package:instagram_clone/Features/presentation/pages/post/upload_post_page.dart';
import 'package:instagram_clone/Features/presentation/pages/profile/profile_page.dart';
import 'package:instagram_clone/Features/presentation/pages/search/search_page.dart';
import 'package:instagram_clone/consts.dart';

import '../home/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.userId});

  final String userId;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(userId: widget.userId);
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
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, state) {
        if(state is GetSingleUserLoaded){
          final currentUser = state.user;
          return Scaffold(
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
              children:  [
                HomePage(),
                SearchPage(),
                UploadPostPage(currentUser: currentUser),
                ActivityPage(),
                ProfilePage(currentUser: currentUser),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
