import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gym Globe")),
      body: Center(child: Container(child: Text("Welcome To Gym Globe!"))),
    );
  }
}
