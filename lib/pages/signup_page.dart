// lib/pages/signup_page.dart
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_globe/utils/routes.dart';

/// ---------------------------------------------------------------------------
///  GYM GLOBE – Sign-Up (Step-by-Step)
///  • 3 steps: Name → Email → Password
///  • Avatar changes when user starts typing
///  • White input text, cyan glow button, dark-neon theme
/// ---------------------------------------------------------------------------
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  // --------------------------------------------------------------------- //
  // Controllers & Focus
  // --------------------------------------------------------------------- //
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  // --------------------------------------------------------------------- //
  // UI State
  // --------------------------------------------------------------------- //
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMsg;

  // --------------------------------------------------------------------- //
  // Step Data
  // --------------------------------------------------------------------- //
  int _currentStep = 0;
  final Map<String, String> _userData = {};

  final List<_StepData> _steps = [
    _StepData(
      question: 'What is your name?',
      thinkingImg: 'assets/images/avatar_thinking.png',
      agreeImg: 'assets/images/avatar_agree.png',
      validator: (v) => v?.trim().isEmpty ?? true ? 'Enter your name' : null,
    ),
    _StepData(
      question: 'Enter your email address',
      thinkingImg: 'assets/images/avatar_thinking.png',
      agreeImg: 'assets/images/avatar_agree.png',
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Enter your email';
        if (!RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w]{2,}$').hasMatch(v)) {
          return 'Invalid email';
        }
        return null;
      },
    ),
    _StepData(
      question: 'Create a password',
      thinkingImg: 'assets/images/avatar_thinking.png',
      agreeImg: 'assets/images/avatar_agree.png',
      validator: (v) =>
          v?.length == null || v!.length < 6 ? 'Min 6 characters' : null,
      obscureText: true,
    ),
  ];

  // --------------------------------------------------------------------- //
  // Glow animation (same as Login)
  // --------------------------------------------------------------------- //
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
      begin: 4.0,
      end: 16.0,
    ).animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    // Change avatar when user starts typing
    _controller.addListener(() {
      final hasText = _controller.text.isNotEmpty;
      if (hasText != _steps[_currentStep].isAgree) {
        setState(() => _steps[_currentStep].isAgree = hasText);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _glowCtrl.dispose();
    super.dispose();
  }

  // --------------------------------------------------------------------- //
  // Input Decoration (white text, cyan focus)
  // --------------------------------------------------------------------- //
  InputDecoration _inputDec({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(color: Colors.white54),
      // ← WHITE TYPED TEXT
      labelStyle: GoogleFonts.inter(color: Colors.white),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white54),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.cyanAccent, width: 2),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      errorStyle: GoogleFonts.inter(color: Colors.redAccent),
    );
  }

  // --------------------------------------------------------------------- //
  // Step navigation & validation
  // --------------------------------------------------------------------- //
  Future<void> _nextStep() async {
    if (!_formKey.currentState!.validate()) return;

    final text = _controller.text.trim();
    setState(() => _errorMsg = null);

    // Save data
    switch (_currentStep) {
      case 0:
        _userData['name'] = text;
        break;
      case 1:
        _userData['email'] = text;
        break;
      case 2:
        _userData['password'] = text;
        break;
    }

    // Last step → perform sign-up
    if (_currentStep == _steps.length - 1) {
      setState(() => _isLoading = true);
      try {
        // TODO: Firebase Auth – create user
        // await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //   email: _userData['email']!,
        //   password: _userData['password']!,
        // );
        await Future.delayed(const Duration(seconds: 2)); // simulate
        if (!mounted) return;
        _navigateToRoleSelection();
      } catch (e) {
        setState(() => _errorMsg = 'Sign-up failed. Try again.');
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
      return;
    }

    // Move to next step
    setState(() {
      _currentStep++;
      _controller.clear();
      _focusNode.requestFocus();
    });
  }

  void _navigateToRoleSelection() {
    Navigator.pushReplacementNamed(context, MyRoutes.roleSelectionRoute);
  }

  // --------------------------------------------------------------------- //
  // Build
  // --------------------------------------------------------------------- //
  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];

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
            child: Container(color: Colors.black.withOpacity(0.7)),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Avatar (thinking → agree)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      child: Image.asset(
                        step.isAgree ? step.agreeImg : step.thinkingImg,
                        key: ValueKey<bool>(step.isAgree),
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Animated question
                    AnimatedTextKit(
                      key: ValueKey<int>(_currentStep),
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          step.question,
                          textStyle: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                          speed: const Duration(milliseconds: 40),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Input field (white text)
                    TextFormField(
                      controller: _controller,
                      focusNode: _focusNode,
                      obscureText: step.obscureText,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                      ), // ← WHITE TEXT
                      decoration: _inputDec(hint: 'Type here...'),
                      validator: step.validator,
                    ),

                    // Error message
                    if (_errorMsg != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        _errorMsg!,
                        style: GoogleFonts.inter(
                          color: Colors.redAccent,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 30),

                    // Next / Finish button with glow
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
                            onPressed: _isLoading ? null : _nextStep,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
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
                                    _currentStep == _steps.length - 1
                                        ? 'Finish'
                                        : 'Next',
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------- //
// Helper class – keeps step data tidy
// --------------------------------------------------------------------- //
class _StepData {
  final String question;
  final String thinkingImg;
  final String agreeImg;
  final String? Function(String?) validator;
  final bool obscureText;
  bool isAgree = false;

  _StepData({
    required this.question,
    required this.thinkingImg,
    required this.agreeImg,
    required this.validator,
    this.obscureText = false,
  });
}
