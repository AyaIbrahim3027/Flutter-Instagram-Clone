import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../consts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backGroundColor,
          title: SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 32,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                  MaterialCommunityIcons.facebook_messenger,
                  color: primaryColor,
              ),
            ),
          ],
        ),
        body: Padding(
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                      Icons.more_vert,
                      color: primaryColor,
                  ),
                ],
              ),
              sizeVer(10),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.30,
                color: secondaryColor,
              ),
              sizeVer(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.favorite,color: primaryColor,),
                      sizeHor(10),
                      const Icon(Feather.message_circle,color: primaryColor,),
                      sizeHor(10),
                      const Icon(Feather.send,color: primaryColor,),
                    ],
                  ),
                  const Icon(Icons.bookmark_border,color: primaryColor,),
                ],
              ),
              sizeVer(10),
              const Text(
                '34 likes',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizeVer(10),
              Row(
                children: [
                  const Text(
                    'Username',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  sizeHor(10),
                  const Text(
                    'some description',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ],
              ),

              sizeVer(10),
              const Text(
                'View all 10 comments',
                style: TextStyle(
                  color: darkGreyColor,
                ),
              ),
              sizeVer(10),
              const Text(
                '11/12/2023',
                style: TextStyle(
                  color: darkGreyColor,
                ),
              ),
            ],
          ),
        ));
  }
}