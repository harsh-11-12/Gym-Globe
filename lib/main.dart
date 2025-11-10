import 'package:flutter/material.dart';
import 'package:gym_globe/pages/home_page.dart';
import 'package:gym_globe/pages/login_page.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';

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
      initialRoute: '/login',
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
