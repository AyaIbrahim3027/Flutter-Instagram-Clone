import 'package:flutter/material.dart';
import 'package:instagram_clone/Features/presentation/pages/post/update_post_page.dart';

import '../../../../consts.dart';

openBottomModalSheetForPost(BuildContext context) {
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
                      onTap: (){
                        Navigator.pushNamed(context, PageConst.updatePostPage);
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
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Delete Post',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: primaryColor,
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
