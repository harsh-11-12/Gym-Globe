import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';

class OwnerDashboardPage extends StatefulWidget {
  const OwnerDashboardPage({super.key});

  @override
  State<OwnerDashboardPage> createState() => _OwnerDashboardPageState();
}

class _OwnerDashboardPageState extends State<OwnerDashboardPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  List<File> _gymImages = [];

  // Controllers
  final TextEditingController _gymNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _facilitiesController = TextEditingController();
  final TextEditingController _membershipController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _openingHoursController = TextEditingController();

  // Dropdowns
  String? _selectedGymType;
  final List<String> _gymTypes = [
    'General Fitness',
    'Powerlifting',
    'CrossFit',
    'Yoga Studio',
    'Women-Only',
    'Luxury Gym',
  ];

  Future<void> _pickGymImages() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        setState(() {
          _gymImages = pickedFiles.map((x) => File(x.path)).toList();
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gallery permission denied')),
      );
    }
  }

  void _submitGymDetails() {
    if (!_formKey.currentState!.validate()) return;
    if (_gymImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one gym image')),
      );
      return;
    }

    // Simulate save
    print('Gym Name: ${_gymNameController.text}');
    print('Type: $_selectedGymType');
    print('Address: ${_addressController.text}, ${_cityController.text}');
    print('Description: ${_descriptionController.text}');
    print('Facilities: ${_facilitiesController.text}');
    print('Membership: ${_membershipController.text}');
    print('Contact: ${_contactController.text}');
    print('Hours: ${_openingHoursController.text}');
    print('Images: ${_gymImages.length} selected');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gym Posted Successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Optional: Clear form
    // _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.75)),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    "Post Your Gym".text.cyan400.xl3.bold.make().pOnly(
                      bottom: 20,
                    ),

                    // Gym Images
                    Center(
                      child: GestureDetector(
                        onTap: _pickGymImages,
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.cyanAccent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[900]!.withOpacity(0.5),
                          ),
                          child: _gymImages.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_a_photo,
                                      size: 50,
                                      color: Colors.cyanAccent,
                                    ),
                                    const HeightBox(8),
                                    "Tap to Add Gym Photos".text.white.lg
                                        .make(),
                                  ],
                                )
                              : _buildImageGrid(),
                        ),
                      ),
                    ),
                    const HeightBox(20),

                    // Gym Name
                    _buildTextField(
                      _gymNameController,
                      'Gym Name',
                      Icons.fitness_center,
                    ),

                    // Gym Type Dropdown
                    DropdownButtonFormField<String>(
                      dropdownColor: Colors.grey[900],
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Gym Type',
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.category,
                          color: Colors.cyanAccent,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.indigoAccent,
                          ),
                        ),
                      ),
                      value: _selectedGymType,
                      items: _gymTypes
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedGymType = val),
                      validator: (val) =>
                          val == null ? 'Select gym type' : null,
                    ),
                    const HeightBox(15),

                    // Address & City
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildTextField(
                            _addressController,
                            'Street Address',
                            Icons.location_on,
                          ),
                        ),
                        const WidthBox(10),
                        Expanded(
                          flex: 2,
                          child: _buildTextField(
                            _cityController,
                            'City',
                            Icons.location_city,
                          ),
                        ),
                      ],
                    ),

                    // Description
                    _buildTextField(
                      _descriptionController,
                      'Description',
                      Icons.description,
                      maxLines: 4,
                    ),

                    // Facilities (comma-separated)
                    _buildTextField(
                      _facilitiesController,
                      'Facilities (e.g., AC, Shower, Locker)',
                      Icons.checklist,
                    ),

                    // Membership Plans
                    _buildTextField(
                      _membershipController,
                      'Membership Plans (e.g., ₹999/month)',
                      Icons.monetization_on,
                    ),

                    // Contact
                    _buildTextField(
                      _contactController,
                      'Contact Number',
                      Icons.phone,
                      keyboard: TextInputType.phone,
                    ),

                    // Opening Hours
                    _buildTextField(
                      _openingHoursController,
                      'Opening Hours (e.g., 5 AM - 11 PM)',
                      Icons.access_time,
                    ),

                    const HeightBox(30),

                    // Submit Button
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _submitGymDetails,
                        icon: const Icon(Icons.send, color: Colors.white),
                        label: "Post Gym".text.xl.bold.white.make(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            61,
                            83,
                            83,
                          ),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 8,
                          shadowColor: Colors.cyanAccent.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const HeightBox(40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: _gymImages.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(_gymImages[index], fit: BoxFit.cover),
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        validator: (v) => v == null || v.trim().isEmpty ? 'Enter $label' : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: Icon(icon, color: Colors.cyanAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.indigoAccent),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
        ),
      ),
    );
  }
}
