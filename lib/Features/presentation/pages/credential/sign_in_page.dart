import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Features/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_clone/Features/presentation/pages/credential/sign_up_page.dart';
import 'package:instagram_clone/Features/presentation/widgets/button_container_widget.dart';
import 'package:instagram_clone/Features/presentation/widgets/form_container_widget.dart';

import '../../../../consts.dart';
import '../../cubit/auth/auth_cubit.dart';
import '../main_screen/main_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSigningIn = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backGroundColor,
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, state) {
          if(state is CredentialSuccess){
            BlocProvider.of<AuthCubit>(context).loggedIn();
          } else if (state is CredentialFailure){
            toast('Invalid Email and Password');
          }
        },
        builder: (context, state) {
          if(state is CredentialSuccess){
            return BlocBuilder<AuthCubit,AuthState>(
              builder: (context,state){
                if(state is Authenticated){
                  return MainScreen(userId: state.userId);
                } else {
                  return bodyWidget();
                }
              },
            );
          }
          return bodyWidget();
        },
      ),
    );
  }

  bodyWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Container(),
          ),
          Center(
              child: SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
              )),
          sizeVer(30),
          FormContainerWidget(
            controller: emailController,
            hintText: 'Email',
          ),
          sizeVer(15),
          FormContainerWidget(
            controller: passwordController,
            hintText: 'Password',
            isPasswordField: true,
          ),
          sizeVer(15),
          ButtonContainerWidget(
            color: blueColor,
            text: 'Sign In',
            onTapListener: () {
              signInUser();
            },
          ),

          sizeVer(10),
          isSigningIn == true ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Please wait',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              sizeHor(10),
              const CircularProgressIndicator(),
            ],
          ) : Container(width: 0, height: 0,),

          Flexible(
            flex: 2,
            child: Container(),
          ),
          const Divider(
            color: secondaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(color: primaryColor),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageConst.signUpPage, (route) => false);
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const SignUpPage(),
                  //     ),
                  //     (route) => false);
                },
                child: const Text(
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
    );
  }

  void signInUser() {
    setState(() {
      isSigningIn = true;
    });
    BlocProvider.of<CredentialCubit>(context).signInUser(
      email: emailController.text,
      password: passwordController.text,
    ).then((value) => clear());
  }

  clear() {
    setState(() {
      emailController.clear();
      passwordController.clear();
      isSigningIn = false;
    });
  }
}
