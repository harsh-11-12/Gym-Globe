import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_globe/utils/routes.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage>
    with TickerProviderStateMixin {
  // Glow animation (same as Login/Sign-Up)
  late final AnimationController _glowCtrl;
  late final Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _glowAnim = Tween<double>(
      begin: 6.0,
      end: 20.0,
    ).animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    super.dispose();
  }

  // Navigate to role-specific dashboard
  void _selectRole(String role) async {
    // TODO: Save role to Firebase (user profile)
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .update({'role': role});

    // Simulate delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Replace with your actual dashboard routes
    switch (role) {
      case 'user':
        Navigator.pushReplacementNamed(context, MyRoutes.userDashBoard);
        break;
      case 'gym':
        Navigator.pushReplacementNamed(context, '/gym_dashboard');
        break;
      case 'trainer':
        Navigator.pushReplacementNamed(context, '/trainer_dashboard');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
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

          // SCROLLABLE CONTENT
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Hero(
                    tag: 'gym_globe_logo',
                    child: Image.asset(
                      'assets/images/avatar_waving.png',
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Title
                  Text(
                    'Choose Your Role',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Join the fitness revolution as...',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // Role Cards — NOW SCROLLABLE
                  GridView.count(
                    shrinkWrap:
                        true, // Critical: lets GridView take only needed height
                    physics: const ClampingScrollPhysics(), // Smooth iOS bounce
                    crossAxisCount: 1,
                    mainAxisSpacing: 20,
                    childAspectRatio: 2.8,
                    children: [
                      _buildRoleCard(
                        title: 'Fitness Enthusiast',
                        subtitle:
                            'Track workouts, join challenges, grow stronger',
                        icon: Icons.fitness_center,
                        color: Colors.cyanAccent,
                        onTap: () => _selectRole('user'),
                      ),
                      _buildRoleCard(
                        title: 'Gym Owner',
                        subtitle: 'Manage members, post offers, grow your gym',
                        icon: Icons.business,
                        color: Colors.greenAccent,
                        onTap: () => _selectRole('gym'),
                      ),
                      _buildRoleCard(
                        title: 'Trainer',
                        subtitle:
                            'Upload tutorials, coach clients, earn followers',
                        icon: Icons.school,
                        color: Colors.purpleAccent,
                        onTap: () => _selectRole('trainer'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Back to Login
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Back to Login',
                      style: GoogleFonts.inter(color: Colors.white60),
                    ),
                  ),
                  const SizedBox(height: 20), // Extra space at bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable glowing role card
  Widget _buildRoleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return AnimatedBuilder(
      animation: _glowAnim,
      builder: (context, child) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.2), color.withOpacity(0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withOpacity(0.4), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: _glowAnim.value,
                  spreadRadius: _glowAnim.value / 3,
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 36, color: Colors.white),
                ),
                const SizedBox(width: 16),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrow
                Icon(Icons.arrow_forward_ios, color: Colors.white60, size: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
