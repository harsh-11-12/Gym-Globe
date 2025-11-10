import 'package:flutter/material.dart';
import 'package:gym_globe/pages/home_page.dart';
import 'package:gym_globe/pages/login_page.dart';
import 'package:gym_globe/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Container(child: Text("lets get staretd with gym globe")),
      ),
      initialRoute: MyRoutes.homeRoute,
      routes: {
        "/": (context) => HomePage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
      },
    );
  }
}
