

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  String? errorText;

  // Data storage
  Map<String, String> userData = {};
  int currentStep = 0;

  // Questions and corresponding images
  final List<Map<String, String>> steps = [
    {
      'question': 'What is your name?',
      'image': 'assets/images/avatar_thinking.png',
    },
    {
      'question': 'Enter your email address',
      'image': 'assets/images/avatar_thinking.png',
    },
    {
      'question': 'Create a password',
      'image': 'assets/images/avatar_thinking.png',
    },
  ];
  bool _isLoading = false;
  late final Animation<double> _glowAnim;
  late final AnimationController _glowCtrl;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _glowAnim = Tween<double>(
      begin: 4.0,
      end: 16.0,
    ).animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    _controller.addListener(() {
      final text = _controller.text;

      // Example logic: change image once user starts typing
      if (text.isNotEmpty) {
        setState(() {
          steps[currentStep]['image'] = 'assets/images/avatar_agree.png';
        });
      }
    });

    // IMPROVEMENT: No need to listen to controller for live name preview
    // We'll show "Welcome Back, [Name]!" only after successful login
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    super.dispose();
  }

  void nextStep() {
    final text = _controller.text;

    //  Step-based validation
    if (text.isEmpty) {
      setState(() {
        errorText = "This field can't be empty!";
      });
      return;
    }

    if (currentStep == 1 && !text.contains('@')) {
      setState(() {
        errorText = "Please enter a valid email!";
      });
      return;
    }

    if (currentStep == 2 && text.length < 6) {
      setState(() {
        errorText = "Password must be at least 6 characters!";
      });
      return;
    }

    //  If valid, clear error and continue
    setState(() {
      errorText = null;
    });
    // Save user data according to step
    switch (currentStep) {
      case 0:
        userData['name'] = _controller.text;
        break;
      case 1:
        userData['email'] = _controller.text;
        break;
      case 2:
        userData['password'] = _controller.text;
        break;
    }

    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
        _controller.clear();
      });
    } else {
      // Signup complete logic
      print('Signup Data: $userData');
    }
  }

  void _navigateToRoleSelection() {
    Navigator.of(context).pushReplacementNamed('/role_selection');
  }

  @override
  Widget build(BuildContext context) {
    final current = steps[currentStep];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.7)),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated image
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        child: Image.asset(
                          current['image']!,
                          key: ValueKey<String>(current['image']!),
                          height: 300,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Animated question text
                      AnimatedTextKit(
                        key: ValueKey(currentStep),
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(
                            current['question']!,
                            textStyle: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                            speed: const Duration(milliseconds: 50),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Single input box
                      TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Type here...',
                          hintStyle: TextStyle(color: Colors.white54),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyanAccent),
                          ),
                        ),
                      ),
                      if (errorText != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            errorText!,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                      const SizedBox(height: 30),

                      // Next Button
                      AnimatedBuilder(
                        animation: _glowAnim,
                        builder: (context, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyanAccent.withOpacity(0.6),
                                  blurRadius: _glowAnim.value,
                                  spreadRadius: _glowAnim.value / 2,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: currentStep == steps.length
                                  ? _navigateToRoleSelection
                                  : nextStep,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyanAccent,
                                foregroundColor: Colors.black,

                                elevation: 0,
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      currentStep == steps.length - 1
                                          ? 'Finish'
                                          : 'Next',
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ).wh(120, 50),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
