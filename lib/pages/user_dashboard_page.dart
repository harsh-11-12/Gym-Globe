import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:gym_globe/pages/profile_page.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({super.key});

  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  String? gender;

  double age = 20;

  double weight = 70;

  double height = 175;

  String activityLevel = 'Moderate';

  final List<String> _activityOptions = [
    'Sedentary',
    'Lightly Active',
    'Moderate',
    'Active',
    'Very Active',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(child: Container(color: Colors.black.withOpacity(0.5))),

          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 8, 8, 8),
                                  Color(0xFF0072FF), // Dark Blue
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(color: Colors.black),
                            ),
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.asset('assets/images/avatar.png'),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        _buildDropdown(
                          label: 'Gender',
                          icon: Icons.person,
                          value: gender,
                          items: const ['Male', 'Female', 'Other'],
                          onChanged: (val) => setState(() => gender = val),
                        ),
                        const SizedBox(height: 15),
                        _buildSlider(
                          label: 'Age',
                          icon: Icons.cake,
                          value: age,
                          min: 10,
                          max: 80,
                          onChanged: (val) => setState(() => age = val),
                        ),
                        const SizedBox(height: 15),
                        _buildSlider(
                          label: 'Weight (kg)',
                          icon: Icons.monitor_weight,
                          value: weight,
                          min: 30,
                          max: 150,
                          onChanged: (val) => setState(() => weight = val),
                        ),
                        const SizedBox(height: 15),
                        _buildSlider(
                          label: 'Height (cm)',
                          icon: Icons.height,
                          value: height,
                          min: 100,
                          max: 220,
                          onChanged: (val) => setState(() => height = val),
                        ),
                        const SizedBox(height: 15),
                        _buildDropdown(
                          label: 'Activity Level',
                          icon: Icons.local_fire_department,
                          value: activityLevel,
                          items: _activityOptions,
                          onChanged: (val) =>
                              setState(() => activityLevel = val!),
                        ),
                        const SizedBox(height: 25),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyanAccent.withOpacity(0.6),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyanAccent.withOpacity(
                                  0.9,
                                ),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                    gender: gender,
                                    age: age,
                                    weight: weight,
                                    height: height,
                                    activityLevel: activityLevel,
                                  ),
                                ),
                              ),
                              child: Text(
                                " Save Profile",
                                style: GoogleFonts.raleway(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDropdown({
  required String label,
  required IconData icon,
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return _glassTile(
    child: Row(
      children: [
        Icon(icon, color: Colors.cyanAccent),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: value,
            hint: Text(label, style: const TextStyle(color: Colors.white70)),
            dropdownColor: Colors.black87,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(border: InputBorder.none),
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    ),
  );
}

//  Slider builder
Widget _buildSlider({
  required String label,
  required IconData icon,
  required double value,
  required double min,
  required double max,
  required ValueChanged<double> onChanged,
}) {
  return _glassTile(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.cyanAccent),
            const SizedBox(width: 10),
            Text(
              "$label: ${value.toStringAsFixed(0)}",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          label: value.toStringAsFixed(0),
          onChanged: onChanged,
          activeColor: Colors.cyanAccent,
          inactiveColor: Colors.white24,
        ),
      ],
    ),
  );
}

//  Reusable Glass Tile
Widget _glassTile({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white.withOpacity(0.2)),
    ),
    child: child,
  );
}
