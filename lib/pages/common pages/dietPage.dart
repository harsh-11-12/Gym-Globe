import 'package:flutter/material.dart';

class DietPage extends StatefulWidget {
  const DietPage({Key? key}) : super(key: key);

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<FoodItem> _dietList = [];

  // Sample food database
  final List<FoodItem> _foodDatabase = [
    FoodItem(
      name: 'Chicken Breast',
      protein: 31,
      carbs: 0,
      fats: 3.6,
      calories: 165,
    ),
    FoodItem(
      name: 'Brown Rice',
      protein: 2.6,
      carbs: 23,
      fats: 0.9,
      calories: 111,
    ),
    FoodItem(name: 'Broccoli', protein: 2.8, carbs: 7, fats: 0.4, calories: 34),
    FoodItem(name: 'Salmon', protein: 25, carbs: 0, fats: 13, calories: 208),
    FoodItem(name: 'Eggs', protein: 6, carbs: 0.6, fats: 5, calories: 78),
    FoodItem(name: 'Oats', protein: 2.4, carbs: 12, fats: 1.4, calories: 71),
    FoodItem(name: 'Banana', protein: 1.3, carbs: 27, fats: 0.4, calories: 105),
    FoodItem(name: 'Almonds', protein: 6, carbs: 6, fats: 14, calories: 164),
    FoodItem(
      name: 'Sweet Potato',
      protein: 2,
      carbs: 20,
      fats: 0.1,
      calories: 86,
    ),
    FoodItem(
      name: 'Greek Yogurt',
      protein: 10,
      carbs: 3.6,
      fats: 0.4,
      calories: 59,
    ),
  ];

  List<FoodItem> _searchResults = [];

  // Calculate total macros
  double get totalProtein =>
      _dietList.fold(0, (sum, item) => sum + (item.protein * item.servings));
  double get totalCarbs =>
      _dietList.fold(0, (sum, item) => sum + (item.carbs * item.servings));
  double get totalFats =>
      _dietList.fold(0, (sum, item) => sum + (item.fats * item.servings));
  double get totalCalories =>
      _dietList.fold(0, (sum, item) => sum + (item.calories * item.servings));

  void _searchFood(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _searchResults = _foodDatabase
          .where(
            (food) => food.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  void _addFoodItem(FoodItem food) {
    showDialog(
      context: context,
      builder: (context) {
        double servings = 1.0;
        return AlertDialog(
          title: Text('Add ${food.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter serving size (100g per serving):'),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Servings',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  servings = double.tryParse(value) ?? 1.0;
                },
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
                  _dietList.add(
                    FoodItem(
                      name: food.name,
                      protein: food.protein,
                      carbs: food.carbs,
                      fats: food.fats,
                      calories: food.calories,
                      servings: servings,
                    ),
                  );
                  _searchController.clear();
                  _searchResults = [];
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _removeFoodItem(int index) {
    setState(() {
      _dietList.removeAt(index);
    });
  }

  void _updateServings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        double newServings = _dietList[index].servings;
        return AlertDialog(
          title: Text('Update ${_dietList[index].name}'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Servings',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: newServings.toString()),
            onChanged: (value) {
              newServings = double.tryParse(value) ?? newServings;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _dietList[index].servings = newServings;
                });
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet Tracker'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Total Macros Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              children: [
                const Text(
                  'Total Macros',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMacroColumn('Protein', totalProtein, Colors.red),
                    _buildMacroColumn('Carbs', totalCarbs, Colors.orange),
                    _buildMacroColumn('Fats', totalFats, Colors.blue),
                    _buildMacroColumn('Calories', totalCalories, Colors.purple),
                  ],
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search food items...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                  ),
                  onChanged: _searchFood,
                ),
                if (_searchResults.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final food = _searchResults[index];
                        return ListTile(
                          title: Text(food.name),
                          subtitle: Text(
                            'P: ${food.protein}g | C: ${food.carbs}g | F: ${food.fats}g | Cal: ${food.calories}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                            onPressed: () => _addFoodItem(food),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Diet List
          Expanded(
            child: _dietList.isEmpty
                ? const Center(
                    child: Text(
                      'No items added yet.\nSearch and add food items!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _dietList.length,
                    itemBuilder: (context, index) {
                      final food = _dietList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      food.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _removeFoodItem(index),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Servings: ${food.servings}x',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () => _updateServings(index),
                                    icon: const Icon(Icons.edit, size: 16),
                                    label: const Text('Edit'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildSmallMacro(
                                    'P',
                                    food.protein * food.servings,
                                    Colors.red,
                                  ),
                                  _buildSmallMacro(
                                    'C',
                                    food.carbs * food.servings,
                                    Colors.orange,
                                  ),
                                  _buildSmallMacro(
                                    'F',
                                    food.fats * food.servings,
                                    Colors.blue,
                                  ),
                                  _buildSmallMacro(
                                    'Cal',
                                    food.calories * food.servings,
                                    Colors.purple,
                                  ),
                                ],
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

  Widget _buildMacroColumn(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          value.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label == 'Calories' ? '' : 'g',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildSmallMacro(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        Text(
          value.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class FoodItem {
  final String name;
  final double protein;
  final double carbs;
  final double fats;
  final double calories;
  double servings;

  FoodItem({
    required this.name,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.calories,
    this.servings = 1.0,
  });
}
