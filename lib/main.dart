import 'package:flutter/material.dart';
import 'package:gym_globe/pages/home_page.dart';
import 'package:gym_globe/pages/login_page.dart';
import 'package:gym_globe/pages/role_selection_page.dart';
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

      routes: {
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.signUpRoute: (context) => const SignupPage(),
        MyRoutes.roleSelectionRoute: (context) => const RoleSelectionPage(),

        //future routes
        MyRoutes.userDashboard: (context) => const UserDashboardPage(),
        MyRoutes.trainerDashboard: (context) => const TrainerDashboardPage(),
        MyRoutes.gymDashboard: (context) => const GymPage(),
      },
      initialRoute: MyRoutes.loginRoute,
    );
  }
}

//future pages (to be made)
class GymPage extends StatelessWidget {
  const GymPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TrainerDashboardPage extends StatelessWidget {
  const TrainerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class UserDashboardPage extends StatelessWidget {
  const UserDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
