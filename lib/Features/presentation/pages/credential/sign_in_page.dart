import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Features/presentation/widgets/button_container_widget.dart';
import 'package:instagram_clone/Features/presentation/widgets/form_container_widget.dart';

import '../../../../consts.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Center(
                child: SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
            )),
            sizeVer(30),
            const FormContainerWidget(
              hintText: 'Email',
            ),
            sizeVer(15),
            const FormContainerWidget(
              hintText: 'Password',
              isPasswordField: true,
            ),
            sizeVer(15),
            ButtonContainerWidget(
              color: blueColor,
              text: 'Sign In',
              onTapListener: () {},
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Divider(
              color: secondaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have and account? ",
                  style: TextStyle(color: primaryColor),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Sign Up.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
