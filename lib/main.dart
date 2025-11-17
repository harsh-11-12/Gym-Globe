import 'package:flutter/material.dart';
import 'package:gym_globe/pages/home_page.dart';
import 'package:gym_globe/pages/login_page.dart';
import 'package:gym_globe/pages/owner_dashboard.dart';
import 'package:gym_globe/pages/role_selection_page.dart';
import 'package:gym_globe/pages/signup_page.dart';
import 'package:gym_globe/pages/trainer_dashboard.dart';
import 'package:gym_globe/pages/user_dashboard_page.dart';
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

      routes: {
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.signUpRoute: (context) => const SignupPage(),
        MyRoutes.roleSelectionRoute: (context) => const RoleSelectionPage(),
        MyRoutes.userDashBoard: (context) => const UserDashboardPage(),
        MyRoutes.trainerDashBoard: (context) => const TrainerDashboardPage(),
        MyRoutes.ownerDashBoard: (context) => const OwnerDashboardPage(),
      },
      initialRoute: MyRoutes.homeRoute,
    );
  }
}

//future pages (to be made)
