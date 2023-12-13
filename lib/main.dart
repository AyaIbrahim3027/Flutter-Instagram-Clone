import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Features/presentation/pages/main_screen/main_screen.dart';
import 'package:instagram_clone/consts.dart';
import 'firebase_options.dart';
import 'on_generate_route.dart';
import 'injection_container.dart' as di;

Future <void> main() async {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backGroundColor,
      ),
      onGenerateRoute: OnGenerateRoute.route,
      initialRoute: '/',
      routes: {
        '/' : (context) => const MainScreen(),
      },
      // home: MainScreen(),
    );
  }
}
