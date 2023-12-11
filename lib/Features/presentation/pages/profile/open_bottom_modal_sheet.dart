import 'package:flutter/material.dart';

import '../../../../consts.dart';

openBottomModalSheet(BuildContext context) {
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
                      child: const Text(
                        'Edit Profile',
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
                      'Logout',
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
