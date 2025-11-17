import 'package:flutter/material.dart';
import 'package:gym_globe/pages/common%20pages/additonalTrainerPage.dart';
import 'package:gym_globe/pages/common%20pages/addtionalOwnerPage.dart';

import 'package:gym_globe/pages/common%20pages/chatPage.dart';
import 'package:gym_globe/pages/common%20pages/contentPage.dart';
import 'package:gym_globe/pages/common%20pages/dietPage.dart';
import 'package:gym_globe/pages/common%20pages/homePage.dart';
import 'package:gym_globe/pages/common%20pages/searchPage.dart';
import 'package:gym_globe/pages/common%20pages/workoutPage.dart';

class RoleMainPage extends StatefulWidget {
  final String? userRole;
  final String? userName;
  final String? userGender;
  final double? userAge;
  final double? userWeight;
  final double? userHeight;
  final String? userActivityLevel;
  RoleMainPage({
    super.key,
    this.userGender,
    this.userAge,
    this.userWeight,
    this.userHeight,
    this.userActivityLevel,
    this.userName,
    this.userRole,
  });

  @override
  State<RoleMainPage> createState() => _RoleMainPageState();
}

class _RoleMainPageState extends State<RoleMainPage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> userPages = [
      Home(
        name: widget.userName,
        gender: widget.userGender,
        age: widget.userAge,
        weight: widget.userWeight,
        height: widget.userHeight,
      ),
      DietPage(),
      const WorkoutPage(),
      const SearchPage(),
      const ChatPage(),
      const ContentPage(),
    ];

    List<Widget> trainerPages = [
      Home(),
      DietPage(),
      const WorkoutPage(),
      const SearchPage(),
      const ChatPage(),
      const ContentPage(),
      const TrainerPage(),
    ];

    List<Widget> ownerPages = [
      Home(),
      DietPage(),
      const WorkoutPage(),
      const SearchPage(),
      const ChatPage(),
      const ContentPage(),
      const OwnerPage(),
    ];

    return Scaffold(
      body: (widget.userRole == "trainer")
          ? trainerPages[pageIndex]
          : (widget.userRole == "owner")
          ? ownerPages[pageIndex]
          : userPages[pageIndex],
      bottomNavigationBar: buildBottomNav(),
    );
  }

  BottomNavigationBar buildBottomNav() {
    List<BottomNavigationBarItem> baseItems = const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: "Diet"),
      BottomNavigationBarItem(
        icon: Icon(Icons.fitness_center),
        label: "Workout",
      ),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
      BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
      BottomNavigationBarItem(
        icon: Icon(Icons.video_collection),
        label: "Content",
      ),
    ];

    if (widget.userRole == "trainer") {
      baseItems.add(
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
      );
    } else if (widget.userRole == "owner") {
      baseItems.add(
        const BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: "Gym Dashboard",
        ),
      );
    }

    return BottomNavigationBar(
      currentIndex: pageIndex,
      onTap: (i) => setState(() => pageIndex = i),
      backgroundColor: Colors.white.withOpacity(0.7),
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.blueGrey,
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      items: baseItems,
    );
  }
}
