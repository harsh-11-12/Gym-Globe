import 'package:flutter/material.dart';
import 'package:gym_globe/pages/home_page.dart';
import 'package:gym_globe/pages/login_page.dart';
import 'package:gym_globe/pages/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,

      home: HomePage(),
      initialRoute: '/signup',
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}
