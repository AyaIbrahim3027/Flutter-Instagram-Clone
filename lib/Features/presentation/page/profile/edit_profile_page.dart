import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone/features/presentation/cubit/user/user_cubit.dart';
import 'package:instagram_clone/features/presentation/page/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/profile_widget.dart';
import 'package:instagram_clone/injection_container.dart' as di;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.currentUser})
      : super(key: key);
  final UserEntity currentUser;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? nameController;
  TextEditingController? usernameController;
  TextEditingController? websiteController;
  TextEditingController? bioController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.currentUser.name);
    usernameController =
        TextEditingController(text: widget.currentUser.username);
    websiteController = TextEditingController(text: widget.currentUser.website);
    bioController = TextEditingController(text: widget.currentUser.bio);
    super.initState();
  }

  bool isUpdating = false;

  File? image;

  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: const Text("Edit Profile"),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.close,
              size: 32,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: updateUserProfileData,
              child: const Icon(
                Icons.done,
                color: blueColor,
                size: 32,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: profileWidget(
                        imageUrl: widget.currentUser.profileUrl, image: image),
                  ),
                ),
              ),
              sizeVer(15),
              Center(
                child: GestureDetector(
                  onTap: selectImage,
                  child: const Text(
                    "Change profile photo",
                    style: TextStyle(
                      color: blueColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              sizeVer(15),
              ProfileFormWidget(title: "Name", controller: nameController),
              sizeVer(15),
              ProfileFormWidget(
                  title: "Username", controller: usernameController),
              sizeVer(15),
              ProfileFormWidget(
                  title: "Website", controller: websiteController),
              sizeVer(15),
              ProfileFormWidget(title: "Bio", controller: bioController),
              sizeVer(10),
              isUpdating == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Please wait...",
                          style: TextStyle(color: Colors.white),
                        ),
                        sizeHor(10),
                        const CircularProgressIndicator()
                      ],
                    )
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    )
            ],
          ),
        ),
      ),
    );
  }

  updateUserProfileData() {
    setState(() => isUpdating = true);
    if (image == null) {
      updateUserProfile("");
    } else {
      di
          .sl<UploadImageToStorageUseCase>()
          .call(image!, false, "profileImages")
          .then((profileUrl) {
        updateUserProfile(profileUrl);
      });
    }
  }

  updateUserProfile(String profileUrl) {
    BlocProvider.of<UserCubit>(context)
        .updateUser(
            user: UserEntity(
                uid: widget.currentUser.uid,
                username: usernameController!.text,
                bio: bioController!.text,
                website: websiteController!.text,
                name: nameController!.text,
                profileUrl: profileUrl))
        .then((value) => clear());
  }

  clear() {
    setState(() {
      isUpdating = false;
      usernameController!.clear();
      bioController!.clear();
      websiteController!.clear();
      nameController!.clear();
    });
    Navigator.pop(context);
  }
}
