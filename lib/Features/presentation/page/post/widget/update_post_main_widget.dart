import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/page/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/profile_widget.dart';
import 'package:instagram_clone/injection_container.dart' as di;

class UpdatePostMainWidget extends StatefulWidget {
  const UpdatePostMainWidget({Key? key, required this.post}) : super(key: key);
  final PostEntity post;

  @override
  State<UpdatePostMainWidget> createState() => _UpdatePostMainWidgetState();
}

class _UpdatePostMainWidgetState extends State<UpdatePostMainWidget> {
  TextEditingController? descriptionController;

  @override
  void initState() {
    descriptionController =
        TextEditingController(text: widget.post.description);
    super.initState();
  }

  @override
  void dispose() {
    descriptionController!.dispose();
    super.dispose();
  }

  File? image;
  bool? uploading = false;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: const Text("Edit Post"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
                onTap: updatePost,
                child: const Icon(
                  Icons.done,
                  color: blueColor,
                  size: 28,
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: profileWidget(imageUrl: widget.post.userProfileUrl),
                ),
              ),
              sizeVer(10),
              Text(
                "${widget.post.username}",
                style: const TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              sizeVer(10),
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: profileWidget(
                        imageUrl: widget.post.postImageUrl, image: image),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: selectImage,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          Icons.edit,
                          color: blueColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              sizeVer(10),
              ProfileFormWidget(
                controller: descriptionController,
                title: "Description",
              ),
              sizeVer(10),
              uploading == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Updating...",
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

  updatePost() {
    setState(() {
      uploading = true;
    });
    if (image == null) {
      submitUpdatePost(image: widget.post.postImageUrl!);
    } else {
      di
          .sl<UploadImageToStorageUseCase>()
          .call(image!, true, "posts")
          .then((imageUrl) {
        submitUpdatePost(image: imageUrl);
      });
    }
  }

  submitUpdatePost({required String image}) {
    BlocProvider.of<PostCubit>(context)
        .updatePost(
            post: PostEntity(
                creatorUid: widget.post.creatorUid,
                postId: widget.post.postId,
                postImageUrl: image,
                description: descriptionController!.text))
        .then((value) => clear());
  }

  clear() {
    setState(() {
      descriptionController!.clear();
      Navigator.pop(context);
      uploading = false;
    });
  }
}
