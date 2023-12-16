import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/Features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/Features/presentation/pages/home/widgets/single_post_card_widget.dart';
import '../../../../consts.dart';
import 'package:instagram_clone/injection_container.dart' as di;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void initState() {
  //   di.sl<GetCurrentUserIdUseCase>().call().then((value) {
  //     value
  //   });
  //   super.initState();
  // }

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
      body: BlocProvider<PostCubit>(
        create: (context) =>
        di.sl<PostCubit>()
          ..getPosts(post: PostEntity()),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(child: CircularProgressIndicator(),);
            }
            if (state is PostFailure) {
              toast('Some failure occured while creating the post');
            }
            if (state is PostLoaded) {
              return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return BlocProvider<PostCubit>(
                      create: (context) => di.sl<PostCubit>(),
                      child: SinglePostCardWidget(post: post),
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
