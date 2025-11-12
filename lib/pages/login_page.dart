// login_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_globe/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

/// ---------------------------------------------------------------------------
///  GYM GLOBE – Login Page
///  • Dark neon theme (blue/cyan accents)
///  • Email + Password + Google Sign-In
///  • Form validation, loading state, error handling
///  • Navigates to Role Selection after login
/// ---------------------------------------------------------------------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  // Controllers & Focus
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _emailFocus = FocusNode();
  final _pwdFocus = FocusNode();

  // Form & UI state
  final _formKey = GlobalKey<FormState>();
  bool _obscurePwd = true;
  bool _isLoading = false;
  String? _errorMsg;

  // Glow animation for button
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

    // IMPROVEMENT: No need to listen to controller for live name preview
    // We'll show "Welcome Back, [Name]!" only after successful login
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwdCtrl.dispose();
    _emailFocus.dispose();
    _pwdFocus.dispose();
    _glowCtrl.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Input Decoration (Reusable)
  // -------------------------------------------------------------------------
  InputDecoration _inputDec({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(color: Colors.white70),
      labelStyle: GoogleFonts.inter(color: Colors.white),
      prefixIcon: Icon(icon, color: Colors.cyanAccent),
      suffixIcon: suffix,
      filled: true,
      // ignore: deprecated_member_use
      fillColor: Colors.white.withOpacity(0.1),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.cyanAccent, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Sign-In Actions
  // -------------------------------------------------------------------------
  Future<void> _signInWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });

    try {
      // TODO: Replace with Firebase Auth
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: _emailCtrl.text.trim(),
      //   password: _pwdCtrl.text,
      // );

      await Future.delayed(const Duration(seconds: 2)); // Simulate API

      if (!mounted) return;
      _navigateToRoleSelection();
    } catch (e) {
      setState(() {
        _errorMsg = e.toString().contains('wrong-password')
            ? 'Incorrect password.'
            : 'Login failed. Check your credentials.';
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      // TODO: Google Sign-In
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) _navigateToRoleSelection();
    } catch (_) {
      setState(() => _errorMsg = 'Google sign-in failed.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _navigateToRoleSelection() {
    Navigator.of(context).pushReplacementNamed('/role_selection');
  }

  // -------------------------------------------------------------------------
  // Build UI
  // -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Image with Dark Overlay
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.7)),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
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
                    const SizedBox(height: 24),

                    // Welcome Text
                    Text(
                      'Welcome Back!',
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Log in to track your gains and connect globally.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Email Field
                    TextFormField(
                      controller: _emailCtrl,
                      focusNode: _emailFocus,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      style: GoogleFonts.inter(color: Colors.white),
                      decoration: _inputDec(
                        hint: 'Email',
                        icon: Icons.email_outlined,
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Enter your email';
                        if (!RegExp(
                          r'^[\w\-\.]+@([\w\-]+\.)+[\w]{2,}$',
                        ).hasMatch(v)) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_pwdFocus),
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    TextFormField(
                      controller: _pwdCtrl,
                      focusNode: _pwdFocus,
                      obscureText: _obscurePwd,
                      textInputAction: TextInputAction.done,
                      style: GoogleFonts.inter(color: Colors.white),
                      decoration: _inputDec(
                        hint: 'Password',
                        icon: Icons.lock_outline,
                        suffix: IconButton(
                          icon: Icon(
                            _obscurePwd
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.cyanAccent,
                          ),
                          onPressed: () =>
                              setState(() => _obscurePwd = !_obscurePwd),
                        ),
                      ),
                      validator: (v) =>
                          v?.isEmpty ?? true ? 'Enter your password' : null,
                      onFieldSubmitted: (_) => _signInWithEmail(),
                    ),
                    const SizedBox(height: 12),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Navigate to Forgot Password
                        },
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.inter(color: Colors.cyanAccent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Error Message
                    if (_errorMsg != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.redAccent),
                        ),
                        child: Text(
                          _errorMsg!,
                          style: GoogleFonts.inter(color: Colors.redAccent),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (_errorMsg != null) const SizedBox(height: 16),

                    // Login Button with Glow
                    AnimatedBuilder(
                      animation: _glowAnim,
                      builder: (context, child) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.cyanAccent.withOpacity(0.6),
                                blurRadius: _glowAnim.value,
                                spreadRadius: _glowAnim.value / 2,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _signInWithEmail,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyanAccent,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
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
                                    'Login',
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        const Expanded(child: Divider(color: Colors.white30)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: GoogleFonts.inter(color: Colors.white70),
                          ),
                        ),
                        const Expanded(child: Divider(color: Colors.white30)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Google Sign-In
                    OutlinedButton.icon(
                      onPressed: _isLoading ? null : _signInWithGoogle,
                      icon: Image.asset(
                        'assets/icons/google.png', // Add Google logo
                        height: 24,
                      ).p8(),
                      label: Text(
                        'Continue with Google',
                        style: GoogleFonts.inter(color: Colors.white),
                      ).p12(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white30),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: GoogleFonts.inter(color: Colors.white70),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, MyRoutes.signUpRoute);
                          },
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.inter(
                              color: Colors.cyanAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
