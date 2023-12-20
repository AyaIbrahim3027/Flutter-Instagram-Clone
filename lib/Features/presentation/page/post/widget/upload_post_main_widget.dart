import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/page/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/profile_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:instagram_clone/injection_container.dart' as di;

class UploadPostMainWidget extends StatefulWidget {
  const UploadPostMainWidget({Key? key, required this.currentUser})
      : super(key: key);
  final UserEntity currentUser;

  @override
  State<UploadPostMainWidget> createState() => _UploadPostMainWidgetState();
}

class _UploadPostMainWidgetState extends State<UploadPostMainWidget> {
  File? image;
  TextEditingController descriptionController = TextEditingController();
  bool uploading = false;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform
          .getImageFromSource(source: ImageSource.gallery);

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
    return image == null
        ? uploadPostWidget()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: backGroundColor,
              leading: GestureDetector(
                  onTap: () => setState(() => image = null),
                  child: const Icon(
                    Icons.close,
                    size: 28,
                  )),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: submitPost,
                      child: const Icon(Icons.arrow_forward)),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: profileWidget(
                            imageUrl: "${widget.currentUser.profileUrl}")),
                  ),
                  sizeVer(10),
                  Text(
                    "${widget.currentUser.username}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  sizeVer(10),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: profileWidget(image: image),
                  ),
                  sizeVer(10),
                  ProfileFormWidget(
                    title: "Description",
                    controller: descriptionController,
                  ),
                  sizeVer(10),
                  uploading == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Uploading...",
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
          );
  }

  submitPost() {
    setState(() {
      uploading = true;
    });
    di
        .sl<UploadImageToStorageUseCase>()
        .call(image!, true, "posts")
        .then((imageUrl) {
      createSubmitPost(image: imageUrl);
    });
  }

  createSubmitPost({required String image}) {
    BlocProvider.of<PostCubit>(context)
        .createPost(
            post: PostEntity(
                description: descriptionController.text,
                createAt: Timestamp.now(),
                creatorUid: widget.currentUser.uid,
                likes: const [],
                postId: const Uuid().v1(),
                postImageUrl: image,
                totalComments: 0,
                totalLikes: 0,
                username: widget.currentUser.username,
                userProfileUrl: widget.currentUser.profileUrl))
        .then((value) => clear());
  }

  clear() {
    setState(() {
      uploading = false;
      descriptionController.clear();
      image = null;
    });
  }

  uploadPostWidget() {
    return Scaffold(
        backgroundColor: backGroundColor,
        body: Center(
          child: GestureDetector(
            onTap: selectImage,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(.3),
                  shape: BoxShape.circle),
              child: const Center(
                child: Icon(
                  Icons.upload,
                  color: primaryColor,
                  size: 40,
                ),
              ),
            ),
          ),
        ));
  }
}
