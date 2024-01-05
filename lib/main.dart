import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responses/Responssive_layout.dart';
import 'package:instagram_clone/responses/mobile_screen.dart';
import 'package:instagram_clone/responses/web_screen.dart';
import 'package:instagram_clone/screens/login.dart';
import 'package:instagram_clone/screens/signup.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyBj0RLSl4P86Yr6zh6g8ra1Vv9TJLoK-BE',
          appId: '1:486135022572:web:3b69216c55aff7c733f6c9',
          messagingSenderId: '486135022572',
          projectId: 'instagram-clone-c0a6b',
          storageBucket: 'instagram-clone-c0a6b.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const RespossiveLayout(
                      mobilescreenlayout: mobilescreenlayout(),
                      webscreenlayout: webscreenlayout());
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              return const Loginscreen();
            })));
  }
}
