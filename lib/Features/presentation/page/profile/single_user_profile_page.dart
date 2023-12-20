import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/page/profile/widgets/single_user_profile_main_widget.dart';
import 'package:instagram_clone/injection_container.dart' as di;

class SingleUserProfilePage extends StatelessWidget {
  const SingleUserProfilePage({Key? key, required this.otherUserId})
      : super(key: key);
  final String otherUserId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCubit>(
          create: (context) => di.sl<PostCubit>(),
        ),
      ],
      child: SingleUserProfileMainWidget(otherUserId: otherUserId),
    );
  }
}
