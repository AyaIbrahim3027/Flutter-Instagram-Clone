import 'package:flutter/material.dart';
import 'package:instagram_clone/Features/presentation/pages/credential/sign_in_page.dart';
import 'package:instagram_clone/Features/presentation/pages/credential/sign_up_page.dart';
import 'package:instagram_clone/Features/presentation/pages/post/update_post_page.dart';
import 'package:instagram_clone/Features/presentation/pages/profile/edit_profile_page.dart';
import 'package:instagram_clone/consts.dart';

import 'Features/presentation/pages/post/comments/comment_page.dart';
class OnGenerateRoute{
  static Route<dynamic>? route(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case PageConst.editProfilePage:
        return routeBuilder(const EditProfilePage());

      case PageConst.updatePostPage:
        return routeBuilder(const UpdatePostPage());

      case PageConst.commentPage:
        return routeBuilder(const CommentPage());

      case PageConst.signInPage:
        return routeBuilder(const SignInPage());

      case PageConst.signUpPage:
        return routeBuilder(const SignUpPage());

      default :
        const NoPageFound();
    }

  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page not found'),
      ),
      body: const Center(child: Text('Page not found')),
    );
  }
}
