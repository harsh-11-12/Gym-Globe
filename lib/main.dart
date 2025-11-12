import 'package:flutter/material.dart';
import 'package:gym_globe/pages/home_page.dart';
import 'package:gym_globe/pages/login_page.dart';
import 'package:gym_globe/pages/signup_page.dart';
import 'package:gym_globe/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,

      // home: HomePage(),
      initialRoute: MyRoutes.homeRoute,
      routes: {
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.signUpRoute: (context) => SignupPage(),
      },
    );
  }
}
