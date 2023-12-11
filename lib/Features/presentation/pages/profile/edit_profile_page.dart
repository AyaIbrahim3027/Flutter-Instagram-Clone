import 'package:flutter/material.dart';
import 'package:instagram_clone/Features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/consts.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: primaryColor),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 32,
          ),
          color: primaryColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.done,
                size: 32,
              ),
              color: blueColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: secondaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              sizeVer(15),
              const Center(
                child: Text(
                  'Change profile photo',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              sizeVer(20),
              const ProfileFormWidget(title: 'Name'),
              sizeVer(15),
              const ProfileFormWidget(title: 'Username'),
              sizeVer(15),
              const ProfileFormWidget(title: 'website'),
              sizeVer(15),
              const ProfileFormWidget(title: 'Bio'),
              sizeVer(15),
            ],
          ),
        ),
      ),
    );
  }
}
