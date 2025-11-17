import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gym_globe/pages/common%20pages/RoleMainPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class TrainerDashboardPage extends StatefulWidget {
  const TrainerDashboardPage({super.key});

  @override
  State<TrainerDashboardPage> createState() => _TrainerDashboardPageState();
}

class _TrainerDashboardPageState extends State<TrainerDashboardPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  // Controllers for text inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _certificationController =
      TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _socialController = TextEditingController();

  // Specialization dropdown
  String? _selectedSpecialization;
  final List<String> _specializations = [
    'Workout',
    'Diet',
    'Both (Workout + Diet)',
  ];

  Future<void> _pickImage() async {
    var status = await Permission.photos.request();
    var cameraStatus = await Permission.camera.request();
    if (status.isGranted || cameraStatus.isGranted) {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => _profileImage = File(picked.path));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gallery permission denied')),
      );
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    // Example: Print data to console or send to backend
    print('Name: ${_nameController.text}');
    print('Specialization: $_selectedSpecialization');
    print('Age: ${_ageController.text}');
    print('Experience: ${_experienceController.text}');
    print('Certification: ${_certificationController.text}');
    print('Bio: ${_bioController.text}');
    print('Email: ${_emailController.text}');
    print('Social: ${_socialController.text}');
    print('Image: ${_profileImage?.path}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Trainer Info Saved Successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Profile Picture
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name
                  _buildInputField(_nameController, 'Full Name', Icons.person),

                  // Specialization Dropdown
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Specialization',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.fitness_center,
                        color: Colors.cyanAccent,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigoAccent),
                      ),
                    ),
                    value: _selectedSpecialization,
                    items: _specializations
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) =>
                        setState(() => _selectedSpecialization = val),
                    validator: (val) =>
                        val == null ? 'Please select specialization' : null,
                  ),
                  const SizedBox(height: 15),

                  // Age
                  _buildInputField(
                    _ageController,
                    'Age',
                    Icons.cake,
                    keyboard: TextInputType.number,
                  ),

                  // Experience
                  _buildInputField(
                    _experienceController,
                    'Experience (years)',
                    Icons.timeline,
                    keyboard: TextInputType.number,
                  ),

                  // Certification
                  _buildInputField(
                    _certificationController,
                    'Certification',
                    Icons.card_membership,
                  ),

                  // Bio / Description
                  _buildInputField(
                    _bioController,
                    'Bio / Description',
                    Icons.info,
                    maxLines: 3,
                  ),

                  // Contact Info (email)
                  _buildInputField(
                    _emailController,
                    'Email',
                    Icons.email,
                    keyboard: TextInputType.emailAddress,
                  ),

                  // Social Media
                  _buildInputField(
                    _socialController,
                    'Social Media Links',
                    Icons.link,
                  ),

                  const SizedBox(height: 25),

                  // Submit button
                  ElevatedButton.icon(
                    onPressed: () {
                      _submitForm;
                      RoleMainPage(
                        userName: _nameController.text,
                        userAge: double.tryParse(_ageController.text),
                        userGender: "",
                        userRole: "trainer",
                        userHeight: null,
                        userWeight: null,
                        userActivityLevel: "",
                      );
                    },
                    icon: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Submit Info',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        keyboardType: keyboard,
        maxLines: maxLines,
        validator: (v) =>
            v == null || v.isEmpty ? 'Please enter your $label' : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(icon, color: Colors.cyanAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigoAccent),
          ),
        ),
      ),
    );
  }
}
