import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone/Features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/Features/presentation/pages/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/profile_widget.dart';
import 'package:instagram_clone/injection_container.dart' as di;

class UpdatePostMainWidget extends StatefulWidget {
  const UpdatePostMainWidget({super.key, required this.post});
  final PostEntity post;

  @override
  State<UpdatePostMainWidget> createState() => _UpdatePostMainWidgetState();
}

class _UpdatePostMainWidgetState extends State<UpdatePostMainWidget> {
  TextEditingController? descriptionController;
  bool uploading = false;

  @override
  void initState() {
    descriptionController = TextEditingController(
      text: widget.post.description,
    );
    super.initState();
  }

  @override
  void dispose() {
    descriptionController!.dispose();
    super.dispose();
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
        title: const Text('Edit Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: updatePost,
              icon: const Icon(
                Icons.done,
                color: blueColor,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                // decoration: const BoxDecoration(
                //   color: secondaryColor,
                //   shape: BoxShape.circle,
                // ),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizeVer(10),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    // decoration: const BoxDecoration(
                    //   color: secondaryColor,
                    // ),
                    child: profileWidget(imageUrl: widget.post.postImageUrl,
                        image: image),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: selectImage,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black54.withOpacity(0.3),
                        ),
                        child : const Icon(
                          Icons.edit,
                          color: blueColor,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
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
                    'Updating...',
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
      ),
    );
  }

  updatePost(){
    setState(() {
      uploading = true;
    });
    if(image == null){
      submitUpdatePost(image: widget.post.postImageUrl!);
    } else {
      di.sl<UploadImageToStorageUseCase>().call(image!, true, 'posts').then((imageUrl){
        submitUpdatePost(image: imageUrl);
      });
    }
  }

  submitUpdatePost({required String image}){
    BlocProvider.of<PostCubit>(context).updatePost(post: PostEntity(
      postImageUrl: image,
      description: descriptionController!.text,
      creatorUid: widget.post.creatorUid,
      postId: widget.post.postId,
    )).then((value) => clear());
  }

  clear() {
    setState(() {
      descriptionController!.clear();
      Navigator.pop(context);
      uploading = false;
    });
  }
}
