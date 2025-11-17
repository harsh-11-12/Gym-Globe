import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Home extends StatefulWidget {
  //User Data
  String? name;
  String? gender;
  double? height;
  double? weight;
  double? age;

  Home({super.key, this.name, this.age, this.gender, this.height, this.weight});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  String userBio = "Fitness enthusiast working towards a healthier lifestyle!";

  // Progress data
  int progressScore = 0;
  int dailyCaloriesConsumed = 0;
  int dailyCaloriesTarget = 0;
  int workoutsCompleted = 0;
  int workoutsTarget = 0;

  // Challenges
  List<Challenge> challenges = [
    Challenge(
      title: "30-Day Workout Streak",
      description: "Complete workouts for 30 consecutive days",
      progress: 0,
      target: 30,
      points: 100,
      icon: Icons.fitness_center,
      color: Colors.orange,
    ),
    Challenge(
      title: "Drink 8 Glasses of Water",
      description: "Stay hydrated throughout the day",
      progress: 0,
      target: 8,
      points: 20,
      icon: Icons.water_drop,
      color: Colors.blue,
    ),
    Challenge(
      title: "Hit Protein Goal 7 Days",
      description: "Meet your daily protein target for a week",
      progress: 0,
      target: 7,
      points: 50,
      icon: Icons.restaurant,
      color: Colors.red,
    ),
    Challenge(
      title: "10K Steps Daily",
      description: "Walk 10,000 steps every day this week",
      progress: 0,
      target: 10000,
      points: 30,
      icon: Icons.directions_walk,
      color: Colors.green,
    ),
  ];

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  String _getProgressStatus() {
    if (progressScore >= 80) {
      return "Excellent Progress! 🔥";
    } else if (progressScore >= 60) {
      return "Great Work! Keep Going! 💪";
    } else if (progressScore >= 40) {
      return "Good Start! Push Harder! 🌟";
    } else {
      return "Let's Get Moving! 🚀";
    }
  }

  void _editUserProfile() {
    final nameController = TextEditingController(text: widget.name);
    final ageController = TextEditingController(text: widget.age.toString());
    final heightController = TextEditingController(
      text: widget.height.toString(),
    );
    final weightController = TextEditingController(
      text: widget.weight.toString(),
    );
    final bioController = TextEditingController(text: userBio);
    String selectedGender = widget.gender.toString();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Profile'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.cake),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.wc),
                      ),
                      items: ['Male', 'Female', 'Other']
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedGender = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Height (cm)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.height),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.monitor_weight),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: bioController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Bio',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.name = nameController.text;
                      widget.age =
                          double.tryParse(ageController.text) ?? widget.age;
                      widget.gender = selectedGender;
                      widget.height =
                          double.tryParse(heightController.text) ??
                          widget.height;
                      widget.weight =
                          double.tryParse(weightController.text) ??
                          widget.weight;
                      userBio = bioController.text;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile updated successfully!'),
                      ),
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _completeChallenge(int index) {
    setState(() {
      if (challenges[index].progress < challenges[index].target) {
        challenges[index].progress++;
        if (challenges[index].progress == challenges[index].target) {
          progressScore = (progressScore + challenges[index].points).clamp(
            0,
            100,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Challenge completed! +${challenges[index].points} points',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                Text(
                  '${_getGreeting()},',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                Text(
                  widget.name.toString(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),

                // Progress Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Your Progress',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$progressScore%',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _getProgressStatus(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 15),
                      LinearProgressIndicator(
                        value: progressScore / 100,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildProgressStat(
                              'Calories',
                              '$dailyCaloriesConsumed/$dailyCaloriesTarget',
                              Icons.local_fire_department,
                            ),
                          ),
                          Expanded(
                            child: _buildProgressStat(
                              'Workouts',
                              '$workoutsCompleted/$workoutsTarget',
                              Icons.fitness_center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Challenges Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Daily Challenges',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('View All')),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: challenges.length,
                  itemBuilder: (context, index) {
                    return _buildChallengeCard(challenges[index], index);
                  },
                ),
                const SizedBox(height: 30),

                // User Details Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Profile Details',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: _editUserProfile,
                      icon: const Icon(Icons.edit, color: Colors.deepPurple),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildProfileRow(
                        Icons.person,
                        'Name',
                        widget.name.toString(),
                      ),
                      const Divider(),
                      _buildProfileRow(
                        Icons.cake,
                        'Age',
                        '${widget.age} years',
                      ),
                      const Divider(),
                      _buildProfileRow(
                        Icons.wc,
                        'Gender',
                        widget.gender.toString(),
                      ),
                      const Divider(),
                      _buildProfileRow(
                        Icons.height,
                        'Height (cm)',
                        '${widget.height} cm',
                      ),
                      const Divider(),
                      _buildProfileRow(
                        Icons.monitor_weight,
                        'Weight (kg)',
                        '${widget.weight} kg',
                      ),
                      const Divider(),
                      _buildProfileRow(
                        Icons.description,
                        'Bio',
                        userBio,
                        isLong: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeCard(Challenge challenge, int index) {
    final isCompleted = challenge.progress >= challenge.target;
    final progressPercentage = (challenge.progress / challenge.target).clamp(
      0.0,
      1.0,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: challenge.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(challenge.icon, color: challenge.color, size: 28),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      challenge.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '+${challenge.points}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progressPercentage,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(challenge.color),
                  minHeight: 8,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${challenge.progress}/${challenge.target}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (!isCompleted)
            ElevatedButton(
              onPressed: () => _completeChallenge(index),
              style: ElevatedButton.styleFrom(
                backgroundColor: challenge.color,
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Mark Progress'),
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Completed!',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(
    IconData icon,
    String label,
    String value, {
    bool isLong = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: isLong
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.deepPurple, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Challenge {
  final String title;
  final String description;
  int progress;
  final int target;
  final int points;
  final IconData icon;
  final Color color;

  Challenge({
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.points,
    required this.icon,
    required this.color,
  });
}
