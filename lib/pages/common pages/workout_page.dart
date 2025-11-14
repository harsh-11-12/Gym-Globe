import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  // Weekly workout plan
  Map<String, List<Exercise>> weeklyPlan = {
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
    'Saturday': [],
    'Sunday': [],
  };

  // Exercise database
  final List<Exercise> exerciseDatabase = [
    Exercise(
      name: 'Bench Press',
      sets: 4,
      reps: 10,
      bodyPart: 'Chest',
      difficulty: 'Intermediate',
    ),
    Exercise(
      name: 'Push-ups',
      sets: 3,
      reps: 15,
      bodyPart: 'Chest',
      difficulty: 'Beginner',
    ),
    Exercise(
      name: 'Incline Dumbbell Press',
      sets: 4,
      reps: 12,
      bodyPart: 'Chest',
      difficulty: 'Intermediate',
    ),
    Exercise(
      name: 'Squats',
      sets: 4,
      reps: 12,
      bodyPart: 'Legs',
      difficulty: 'Intermediate',
    ),
    Exercise(
      name: 'Deadlift',
      sets: 3,
      reps: 8,
      bodyPart: 'Back',
      difficulty: 'Advanced',
    ),
    Exercise(
      name: 'Pull-ups',
      sets: 3,
      reps: 10,
      bodyPart: 'Back',
      difficulty: 'Intermediate',
    ),
    Exercise(
      name: 'Barbell Row',
      sets: 4,
      reps: 10,
      bodyPart: 'Back',
      difficulty: 'Intermediate',
    ),
    Exercise(
      name: 'Shoulder Press',
      sets: 4,
      reps: 10,
      bodyPart: 'Shoulders',
      difficulty: 'Intermediate',
    ),
    Exercise(
      name: 'Lateral Raises',
      sets: 3,
      reps: 15,
      bodyPart: 'Shoulders',
      difficulty: 'Beginner',
    ),
    Exercise(
      name: 'Bicep Curls',
      sets: 3,
      reps: 12,
      bodyPart: 'Arms',
      difficulty: 'Beginner',
    ),
    Exercise(
      name: 'Tricep Dips',
      sets: 3,
      reps: 12,
      bodyPart: 'Arms',
      difficulty: 'Intermediate',
    ),
    Exercise(
      name: 'Lunges',
      sets: 3,
      reps: 12,
      bodyPart: 'Legs',
      difficulty: 'Beginner',
    ),
    Exercise(
      name: 'Leg Press',
      sets: 4,
      reps: 12,
      bodyPart: 'Legs',
      difficulty: 'Beginner',
    ),
    Exercise(
      name: 'Plank',
      sets: 3,
      reps: 60,
      bodyPart: 'Core',
      difficulty: 'Beginner',
    ),
    Exercise(
      name: 'Crunches',
      sets: 3,
      reps: 20,
      bodyPart: 'Core',
      difficulty: 'Beginner',
    ),
  ];

  String selectedDay = 'Monday';

  void _showDayExercises(String day) {
    setState(() {
      selectedDay = day;
    });
  }

  void _searchAndAddExercise(String day) {
    final searchController = TextEditingController();
    List<Exercise> searchResults = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Add Exercise to $day',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search exercises...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                      onChanged: (query) {
                        setModalState(() {
                          if (query.isEmpty) {
                            searchResults = [];
                          } else {
                            searchResults = exerciseDatabase
                                .where(
                                  (exercise) => exercise.name
                                      .toLowerCase()
                                      .contains(query.toLowerCase()),
                                )
                                .toList();
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: searchResults.isEmpty
                          ? Center(
                              child: Text(
                                searchController.text.isEmpty
                                    ? 'Start typing to search exercises'
                                    : 'No exercises found',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            )
                          : ListView.builder(
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                final exercise = searchResults[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: _getBodyPartColor(
                                        exercise.bodyPart,
                                      ),
                                      child: Icon(
                                        _getBodyPartIcon(exercise.bodyPart),
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(exercise.name),
                                    subtitle: Text(
                                      '${exercise.bodyPart} • ${exercise.sets}x${exercise.reps} • ${exercise.difficulty}',
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: Colors.deepPurple,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          weeklyPlan[day]!.add(
                                            Exercise(
                                              name: exercise.name,
                                              sets: exercise.sets,
                                              reps: exercise.reps,
                                              bodyPart: exercise.bodyPart,
                                              difficulty: exercise.difficulty,
                                            ),
                                          );
                                        });
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${exercise.name} added to $day',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showRecommendations() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RecommendationsPage()),
    );
  }

  void _removeExercise(String day, int index) {
    setState(() {
      weeklyPlan[day]!.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exercise removed'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _editExercise(String day, int index) {
    final exercise = weeklyPlan[day]![index];
    final setsController = TextEditingController(
      text: exercise.sets.toString(),
    );
    final repsController = TextEditingController(
      text: exercise.reps.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ${exercise.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: setsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Sets',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: repsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Reps',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  exercise.sets =
                      int.tryParse(setsController.text) ?? exercise.sets;
                  exercise.reps =
                      int.tryParse(repsController.text) ?? exercise.reps;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Color _getBodyPartColor(String bodyPart) {
    switch (bodyPart.toLowerCase()) {
      case 'chest':
        return Colors.red;
      case 'back':
        return Colors.blue;
      case 'legs':
        return Colors.green;
      case 'shoulders':
        return Colors.orange;
      case 'arms':
        return Colors.purple;
      case 'core':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  IconData _getBodyPartIcon(String bodyPart) {
    switch (bodyPart.toLowerCase()) {
      case 'chest':
        return Icons.accessibility_new;
      case 'back':
        return Icons.fitness_center;
      case 'legs':
        return Icons.directions_run;
      case 'shoulders':
        return Icons.pan_tool;
      case 'arms':
        return Icons.sports_martial_arts;
      case 'core':
        return Icons.radar;
      default:
        return Icons.sports_gymnastics;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          'Workout Planner',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb, color: Colors.yellow),
            onPressed: _showRecommendations,
            tooltip: 'Recommendations',
          ).pOnly(right: 40),
        ],
      ),
      body: Column(
        children: [
          // Days horizontal list
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: weeklyPlan.keys.length,
              itemBuilder: (context, index) {
                final day = weeklyPlan.keys.elementAt(index);
                final isSelected = selectedDay == day;
                final exerciseCount = weeklyPlan[day]!.length;

                return GestureDetector(
                  onTap: () => _showDayExercises(day),
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.deepPurple : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day.substring(0, 3),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withOpacity(0.3)
                                : Colors.deepPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '$exerciseCount',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.deepPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Selected day exercises
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDay,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _searchAndAddExercise(selectedDay),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Add Exercise',
                    style: TextStyle(color: Colors.white),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Exercises list
          Expanded(
            child: weeklyPlan[selectedDay]!.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fitness_center,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No exercises for $selectedDay',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Tap "Add Exercise" to get started',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: weeklyPlan[selectedDay]!.length,
                    itemBuilder: (context, index) {
                      final exercise = weeklyPlan[selectedDay]![index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: _getBodyPartColor(
                                  exercise.bodyPart,
                                ),
                                child: Icon(
                                  _getBodyPartIcon(exercise.bodyPart),
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exercise.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${exercise.bodyPart} • ${exercise.difficulty}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${exercise.sets} sets × ${exercise.reps} reps',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () =>
                                    _editExercise(selectedDay, index),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () =>
                                    _removeExercise(selectedDay, index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Exercise Model
class Exercise {
  final String name;
  int sets;
  int reps;
  final String bodyPart;
  final String difficulty;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.bodyPart,
    required this.difficulty,
  });
}

// Recommendations Page (Trainer Content)
class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recommendations = [
      TrainerRecommendation(
        trainerName: 'John Fitness',
        trainerImage: 'https://via.placeholder.com/150',
        title: 'Complete Chest Workout',
        bodyPart: 'Chest',
        difficulty: 'Intermediate',
        duration: '45 min',
        exercises: [
          'Bench Press - 4x10',
          'Incline Dumbbell Press - 4x12',
          'Cable Flyes - 3x15',
          'Push-ups - 3x20',
        ],
        likes: 0,
        views: 0,
      ),
      TrainerRecommendation(
        trainerName: 'Sarah Strong',
        trainerImage: 'https://via.placeholder.com/150',
        title: 'Leg Day Destroyer',
        bodyPart: 'Legs',
        difficulty: 'Advanced',
        duration: '60 min',
        exercises: [
          'Squats - 5x8',
          'Romanian Deadlifts - 4x10',
          'Leg Press - 4x12',
          'Lunges - 3x12 each',
        ],
        likes: 0,
        views: 0,
      ),
      TrainerRecommendation(
        trainerName: 'Mike Muscles',
        trainerImage: 'https://via.placeholder.com/150',
        title: 'Back & Biceps Builder',
        bodyPart: 'Back',
        difficulty: 'Intermediate',
        duration: '50 min',
        exercises: [
          'Deadlifts - 4x8',
          'Pull-ups - 4x10',
          'Barbell Row - 4x10',
          'Bicep Curls - 3x12',
        ],
        likes: 0,
        views: 0,
      ),
      TrainerRecommendation(
        trainerName: 'Emma Elite',
        trainerImage: 'https://via.placeholder.com/150',
        title: 'Core Strength Essentials',
        bodyPart: 'Core',
        difficulty: 'Beginner',
        duration: '30 min',
        exercises: [
          'Plank - 3x60s',
          'Russian Twists - 3x20',
          'Leg Raises - 3x15',
          'Mountain Climbers - 3x20',
        ],
        likes: 0,
        views: 0,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Trainer Recommendations',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final rec = recommendations[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trainer info header
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(rec.trainerImage),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rec.trainerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Certified Trainer',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '4.8',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // Workout details
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rec.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _buildBadge(
                            rec.bodyPart,
                            Icons.fitness_center,
                            Colors.blue,
                          ),
                          const SizedBox(width: 10),
                          _buildBadge(
                            rec.difficulty,
                            Icons.show_chart,
                            Colors.orange,
                          ),
                          const SizedBox(width: 10),
                          _buildBadge(rec.duration, Icons.timer, Colors.green),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Exercises:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...rec.exercises.map(
                        (exercise) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 8),
                              Text(exercise),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.favorite, size: 16, color: Colors.red),
                          const SizedBox(width: 4),
                          Text('${rec.likes}', style: TextStyle(fontSize: 12)),
                          const SizedBox(width: 15),
                          Icon(Icons.visibility, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('${rec.views}', style: TextStyle(fontSize: 12)),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${rec.title} added to your plan!',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Add to Plan',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBadge(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Trainer Recommendation Model
class TrainerRecommendation {
  final String trainerName;
  final String trainerImage;
  final String title;
  final String bodyPart;
  final String difficulty;
  final String duration;
  final List<String> exercises;
  final int likes;
  final int views;

  TrainerRecommendation({
    required this.trainerName,
    required this.trainerImage,
    required this.title,
    required this.bodyPart,
    required this.difficulty,
    required this.duration,
    required this.exercises,
    required this.likes,
    required this.views,
  });
}
