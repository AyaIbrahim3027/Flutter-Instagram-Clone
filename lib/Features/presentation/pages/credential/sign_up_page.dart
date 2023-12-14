import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/Features/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone/Features/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_clone/Features/presentation/pages/main_screen/main_screen.dart';
import 'package:instagram_clone/Features/presentation/widgets/button_container_widget.dart';
import 'package:instagram_clone/Features/presentation/widgets/form_container_widget.dart';

import '../../../../consts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    bioController.dispose();
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

  bodyWidget() {
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
          sizeVer(15),
          Center(
            child: Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset('assets/profile_default.png'),
                ),
                Positioned(
                    right: -10,
                    bottom: -15,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: blueColor,
                        size: 30,
                      ),
                    )),
              ],
            ),
          ),
          sizeVer(30),
          FormContainerWidget(
            controller: usernameController,
            hintText: 'Username',
          ),
          sizeVer(15),
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
          FormContainerWidget(
            controller: bioController,
            hintText: 'Bio',
          ),
          sizeVer(15),
          ButtonContainerWidget(
            color: blueColor,
            text: 'Sign Up',
            onTapListener: () {
              signUpUser();
            },
          ),

          sizeVer(10),
          isSigningUp == true ? Row(
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
                "Already have an account? ",
                style: TextStyle(color: primaryColor),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, PageConst.signInPage, (route) => false);

                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const SignInPage(),
                  //     ),
                  //     (route) => false);
                },
                child: const Text(
                  "Sign In.",
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

  void signUpUser() {
    setState(() {
      isSigningUp = true;
    });
    BlocProvider.of<CredentialCubit>(context)
        .signUpUser(
      user: UserEntity(
        email: emailController.text,
        password: passwordController.text,
        userName: usernameController.text,
        bio: bioController.text,
        totalPosts: 0,
        totalFollowing: 0,
        totalFollowers: 0,
        following: [],
        followers: [],
        profileUrl: '',
        website: '',
        name: '',
      ),
    )
        .then((value) => clear());
  }

  clear() {
    setState(() {
      usernameController.clear();
      emailController.clear();
      passwordController.clear();
      bioController.clear();
      isSigningUp = false;
    });
  }
}
