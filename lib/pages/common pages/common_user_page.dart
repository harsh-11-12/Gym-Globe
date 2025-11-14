import 'package:flutter/material.dart';
import 'package:gym_globe/pages/common%20pages/additonal_trainer_page.dart';
import 'package:gym_globe/pages/common%20pages/addtional_owner_page.dart';

import 'package:gym_globe/pages/common%20pages/chat_page.dart';
import 'package:gym_globe/pages/common%20pages/content_page.dart';
import 'package:gym_globe/pages/common%20pages/diet_page.dart';
import 'package:gym_globe/pages/common%20pages/home_page.dart';
import 'package:gym_globe/pages/common%20pages/search_page.dart';
import 'package:gym_globe/pages/common%20pages/workout_page.dart';

class RoleMainPage extends StatefulWidget {
  final String? role;
  const RoleMainPage({super.key, this.role});

  @override
  State<RoleMainPage> createState() => _RoleMainPageState();
}

class _RoleMainPageState extends State<RoleMainPage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> userPages = [
      const Home(),
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
      body: (widget.role == "trainer")
          ? trainerPages[pageIndex]
          : (widget.role == "owner")
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

    if (widget.role == "trainer") {
      baseItems.add(
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
      );
    } else if (widget.role == "owner") {
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
