import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/Features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/profile_widget.dart';
import 'package:intl/intl.dart';

import '../../../../../consts.dart';
import '../open_bottom_modal_sheet_for_post.dart';

class SinglePostCardWidget extends StatelessWidget {
  const SinglePostCardWidget({super.key, required this.post});
  final PostEntity post;

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
                    child: ClipRRect(borderRadius: BorderRadius.circular(15),child:
                      profileWidget(imageUrl: '${post.userProfileUrl}'),),
                  ),
                  sizeHor(10),
                   Text(
                    '${post.username}',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  openBottomModalSheetForPost(context,post);
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
            child: profileWidget(imageUrl: '${post.postImageUrl}'),
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
            '${post.totalLikes} likes',
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          sizeVer(10),
          Row(
            children: [
               Text(
                '${post.username}',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizeHor(10),
               Text(
                '${post.description}',
                style: const TextStyle(
                  color: primaryColor,
                ),
              ),
            ],
          ),
          sizeVer(10),
          Text(
            'View all ${post.totalComments} comments',
            style: const TextStyle(
              color: darkGreyColor,
            ),
          ),
          sizeVer(10),
           Text(
             DateFormat("dd/MM/yyyy").format(post.createAt!.toDate()),
            style: const TextStyle(
              color: darkGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}

