import 'package:flutter/material.dart';
import 'package:instagram_clone/Features/presentation/widgets/form_container_widget.dart';
import 'package:instagram_clone/consts.dart';

import 'comment_section.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  bool isUserReplaying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroundColor,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back,
        //   ),
        //   color: primaryColor,
        // ),
        title: const Text(
          'Comments',
          style: TextStyle(
            color: primaryColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    sizeHor(10),
                    const Text(
                      'Username',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                sizeVer(10),
                const Text(
                  'Description',
                  style: TextStyle(color: primaryColor),
                ),
              ],
            ),
          ),
          sizeVer(10),
          const Divider(
            color: secondaryColor,
          ),
          sizeVer(10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  sizeHor(15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Username',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_outline,
                                size: 20,
                              ),
                              color: darkGreyColor,
                            ),
                          ],
                        ),
                        const Text(
                          'This is comment',
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                        sizeVer(4),
                        Row(
                          children:  [
                            const Text('11/12/2023',style: TextStyle(
                              color: darkGreyColor,
                              fontSize: 12,
                            ),),
                            sizeHor(15),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isUserReplaying = !isUserReplaying;
                                });
                              },
                              child: const Text('Replay',style: TextStyle(
                                color: darkGreyColor,
                                fontSize: 12,
                              ),),
                            ),
                            sizeHor(15),
                            const Text('View Replays',style: TextStyle(
                              color: darkGreyColor,
                              fontSize: 12,
                            ),),
                          ],
                        ),
                        isUserReplaying == true ? sizeVer(10) :sizeVer(0),
                        isUserReplaying == true ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const FormContainerWidget(hintText: 'Post your replay',),
                            sizeVer(10),
                            const Text('Post', style: TextStyle(color: blueColor),),
                          ],
                        ) : const SizedBox(width: 0,height: 0,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          commentSection(),
        ],
      ),
    );
  }
}
