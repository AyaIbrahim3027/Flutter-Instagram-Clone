import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/Features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/profile_widget.dart';
import 'package:intl/intl.dart';

import '../../../../../consts.dart';
import '../../../cubit/post/post_cubit.dart';

class SinglePostCardWidget extends StatefulWidget {
  const SinglePostCardWidget({super.key, required this.post});
  final PostEntity post;

  @override
  State<SinglePostCardWidget> createState() => _SinglePostCardWidgetState();
}

class _SinglePostCardWidgetState extends State<SinglePostCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    // decoration: const BoxDecoration(
                    //   color: secondaryColor,
                    //   shape: BoxShape.circle,
                    // ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: profileWidget(
                          imageUrl: '${widget.post.userProfileUrl}'),
                    ),
                  ),
                  sizeHor(10),
                  Text(
                    '${widget.post.username}',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  openBottomModalSheetForPost(context, widget.post);
                },
                child: const Icon(
                  Icons.more_vert,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          sizeVer(10),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            // color: secondaryColor,
            child: profileWidget(imageUrl: '${widget.post.postImageUrl}'),
          ),
          sizeVer(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: primaryColor,
                  ),
                  sizeHor(10),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.commentPage);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const CommentPage(),
                        //   ),
                        // );
                      },
                      child: const Icon(
                        Feather.message_circle,
                        color: primaryColor,
                      )),
                  sizeHor(10),
                  const Icon(
                    Feather.send,
                    color: primaryColor,
                  ),
                ],
              ),
              const Icon(
                Icons.bookmark_border,
                color: primaryColor,
              ),
            ],
          ),
          sizeVer(10),
          Text(
            '${widget.post.totalLikes} likes',
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          sizeVer(10),
          Row(
            children: [
              Text(
                '${widget.post.username}',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizeHor(10),
              Text(
                '${widget.post.description}',
                style: const TextStyle(
                  color: primaryColor,
                ),
              ),
            ],
          ),
          sizeVer(10),
          Text(
            'View all ${widget.post.totalComments} comments',
            style: const TextStyle(
              color: darkGreyColor,
            ),
          ),
          sizeVer(10),
          Text(
            DateFormat("dd/MM/yyyy").format(widget.post.createAt!.toDate()),
            style: const TextStyle(
              color: darkGreyColor,
            ),
          ),
        ],
      ),
    );
  }

  openBottomModalSheetForPost(BuildContext context, PostEntity post) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(
              color: backGroundColor.withOpacity(0.1),
            ),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'More Options',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    sizeVer(8),
                    const Divider(
                      thickness: 1,
                      color: secondaryColor,
                    ),
                    sizeVer(8),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, PageConst.updatePostPage,
                              arguments: post);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> const UpdatePostPage() , ),);
                        },
                        child: const Text(
                          'Update Post ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: primaryColor),
                        ),
                      ),
                    ),
                    sizeVer(7),
                    const Divider(
                      thickness: 1,
                      color: secondaryColor,
                    ),
                    sizeVer(7),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: deletePost,
                        child: const Text(
                          'Delete Post',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    sizeVer(7),
                  ],
                ),
              ),
            ),
          );
        });
  }

  deletePost() {
    BlocProvider.of<PostCubit>(context).deletePost(
        post: PostEntity(
      postId: widget.post.postId,
    ));
  }
}
