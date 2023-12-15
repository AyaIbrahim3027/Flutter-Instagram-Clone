import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone/Features/presentation/cubit/user/user_cubit.dart';
import 'package:instagram_clone/Features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/consts.dart';

import '../../../../profile_widget.dart';
import 'package:instagram_clone/injection_container.dart' as di;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.currentUser});
  final UserEntity currentUser;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? nameController;
  TextEditingController? usernameController;
  TextEditingController? websiteController;
  TextEditingController? bioController;

  bool isUpdating = false;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.currentUser.name);
    usernameController =
        TextEditingController(text: widget.currentUser.userName);
    websiteController = TextEditingController(text: widget.currentUser.website);
    bioController = TextEditingController(text: widget.currentUser.bio);
    super.initState();
  }

  File? image;
  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImageFromSource(
        source: ImageSource.gallery,
      );
      setState(() {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          print('no image has been selected');
        }
      });
    } catch (e) {
      toast('some error occurred $e');
    }
  }

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
              onPressed: updateUserProfileData,
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
                  // decoration: const BoxDecoration(
                  //   color: secondaryColor,
                  //   shape: BoxShape.circle,
                  // ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: profileWidget(
                      imageUrl: widget.currentUser.profileUrl,
                      image: image,
                    ),
                  ),
                ),
              ),
              sizeVer(15),
               Center(
                child: GestureDetector(
                  onTap: selectImage,
                  child: const Text(
                    'Change profile photo',
                    style: TextStyle(
                      color: blueColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              sizeVer(20),
              ProfileFormWidget(
                title: 'Name',
                controller: nameController,
              ),
              sizeVer(15),
              ProfileFormWidget(
                title: 'Username',
                controller: usernameController,
              ),
              sizeVer(15),
              ProfileFormWidget(
                title: 'website',
                controller: websiteController,
              ),
              sizeVer(15),
              ProfileFormWidget(
                title: 'Bio',
                controller: bioController,
              ),
              sizeVer(15),
              isUpdating == true ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const Text(
                    'Please wait...',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                  sizeHor(10),
                 const CircularProgressIndicator(),
                ],
              ) : Container(width: 0,height: 0,),
            ],
          ),
        ),
      ),
    );
  }

  updateUserProfileData(){
    if(image == null){
      updateUserProfile('');
    } else {
      di.sl<UploadImageToStorageUseCase>().call(image!, false, 'profileImages').then((profileUrl){
        updateUserProfile(profileUrl);
      });
    }
  }

  updateUserProfile(String profileUrl) {
    setState(() {
      isUpdating = true;
    });
    BlocProvider.of<UserCubit>(context)
        .updateUser(
          user: UserEntity(
            userId: widget.currentUser.userId,
            name: nameController!.text,
            userName: usernameController!.text,
            website: websiteController!.text,
            bio: bioController!.text,
            profileUrl: profileUrl,
          ),
        )
        .then((value) => clear());
  }

  clear() {
    setState(() {
      isUpdating = false;
      nameController!.clear();
      usernameController!.clear();
      websiteController!.clear();
      bioController!.clear();
    });
    
    Navigator.pop(context);
  }
}
