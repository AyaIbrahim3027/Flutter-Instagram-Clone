import 'package:flutter/material.dart';
import 'package:instagram_clone/Features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/profile_widget.dart';

import '../../../../consts.dart';
import 'open_bottom_modal_sheet.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.currentUser});
  final UserEntity currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: Text(
          '${currentUser.userName}',
          style: const TextStyle(
            color: primaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                openBottomModalSheet(context);
              },
              icon: const Icon(
                Icons.menu,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    // decoration: const BoxDecoration(
                    //   color: secondaryColor,
                    //   shape: BoxShape.circle,
                    // ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: profileWidget(
                        imageUrl: currentUser.profileUrl,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            '${currentUser.totalPosts}',
                            style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          sizeVer(8),
                          const Text(
                            'Posts',
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      sizeHor(25),
                      Column(
                        children: [
                          Text(
                            '${currentUser.totalFollowers}',
                            style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          sizeVer(8),
                          const Text(
                            'Followers',
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      sizeHor(25),
                      Column(
                        children: [
                          Text(
                            '${currentUser.totalFollowing}',
                            style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          sizeVer(8),
                          const Text(
                            'Following',
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              sizeVer(10),
              Text(
                '${currentUser.name == '' ? currentUser.userName : currentUser.name}',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizeVer(10),
              Text(
                '${currentUser.bio}',
                style: const TextStyle(
                  color: primaryColor,
                ),
              ),
              sizeVer(10),
              GridView.builder(
                itemCount: 32,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: secondaryColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
