import 'package:flutter/material.dart';
import 'package:instagram_clone/consts.dart';

import 'Features/presentation/pages/credential/sign_in_page.dart';
import 'on_generate_route.dart';

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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backGroundColor,
      ),
      onGenerateRoute: OnGenerateRoute.route,
      initialRoute: '/',
      routes: {
        '/' : (context) => const SignInPage(),
      },
      // home: MainScreen(),
    );
  }
}
