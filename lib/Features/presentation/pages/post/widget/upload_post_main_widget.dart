import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone/Features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/Features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/profile_widget.dart';
import 'package:uuid/uuid.dart';

import '../../../../../consts.dart';
import '../../../../domain/entities/user/user_entity.dart';
import 'package:instagram_clone/injection_container.dart' as di;

class UploadPostMainWidget extends StatefulWidget {
  const UploadPostMainWidget({super.key, required this.currentUser});
  final UserEntity currentUser;

  @override
  State<UploadPostMainWidget> createState() => _UploadPostMainWidgetState();
}

class _UploadPostMainWidgetState extends State<UploadPostMainWidget> {
  TextEditingController descriptionController = TextEditingController();

  File? image;
  bool uploading = false;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

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
    return image == null
        ? uploadPostWidget()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: backGroundColor,
              leading: IconButton(
                  onPressed: () {
                    setState(() => image = null);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: primaryColor,
                    size: 28,
                  )),
              actions: [
                IconButton(
                    onPressed: submitPost,
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: primaryColor,
                      size: 28,
                    )),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: profileWidget(
                            imageUrl: '${widget.currentUser.profileUrl}')),
                  ),
                  sizeVer(10),
                  Text(
                    '${widget.currentUser.userName}',
                    style: const TextStyle(color: primaryColor),
                  ),
                  sizeVer(10),
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: profileWidget(image: image),
                  ),
                  sizeVer(10),
                  ProfileFormWidget(
                    title: 'Description',
                    controller: descriptionController,
                  ),
                  sizeVer(10),
                  uploading == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Uploading...',
                              style: TextStyle(
                                color: primaryColor,
                              ),
                            ),
                            sizeHor(10),
                            const CircularProgressIndicator(),
                          ],
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        ),
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
        .call(image!, true, 'posts')
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
          creatorUid: widget.currentUser.userId,
          likes: [],
          postId: Uuid().v1(),
          postImageUrl: image,
          totalLikes: 0,
          totalComments: 0,
          username: widget.currentUser.userName,
          userProfileUrl: widget.currentUser.profileUrl,
        ))
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
      body: Center(
        child: GestureDetector(
          onTap: selectImage,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.upload,
                color: primaryColor,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
