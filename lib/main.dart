import 'package:flutter/material.dart';
import 'package:instagram_clone/Features/presentation/pages/credential/sign_up_page.dart';
import 'package:instagram_clone/Features/presentation/pages/main_screen/main_screen.dart';

import 'Features/presentation/pages/credential/sign_in_page.dart';

void main() {
  runApp(const InstagramApp());
}

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

