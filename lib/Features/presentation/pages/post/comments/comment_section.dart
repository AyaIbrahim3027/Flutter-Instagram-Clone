import 'package:flutter/material.dart';

import '../../../../../consts.dart';

commentSection() {
  return Container(
    width: double.infinity,
    height: 55,
    color: Colors.grey[800],
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal:10),
      child: Row(
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
          Expanded(child: TextFormField(
            style: const TextStyle(color: primaryColor,),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Post your comment...',
              hintStyle: TextStyle(color: secondaryColor),
            ),
          ),),
          const Text('Post', style: TextStyle(fontSize: 15,color: blueColor),),
        ],
      ),
    ),
  );
}
