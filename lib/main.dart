import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/Features/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone/Features/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_clone/Features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/Features/presentation/cubit/user/user_cubit.dart';
import 'package:instagram_clone/Features/presentation/pages/credential/sign_in_page.dart';
import 'package:instagram_clone/Features/presentation/pages/main_screen/main_screen.dart';
import 'package:instagram_clone/consts.dart';
import 'firebase_options.dart';
import 'on_generate_route.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const InstagramApp());
}

class InstagramApp extends StatelessWidget {
  const InstagramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (create) => di.sl<CredentialCubit>()),
        BlocProvider(create: (create) => di.sl<UserCubit>()),
        BlocProvider(create: (create) => di.sl<GetSingleUserCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backGroundColor,
        ),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: '/',
        routes: {
          '/': (context) => BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return MainScreen(
                      userId: state.userId,
                    );
                  } else {
                    return const SignInPage();
                  }
                },
              ),
        },
        // home: MainScreen(),
      ),
    );
  }
}
