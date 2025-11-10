import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            "Brock".text.white
                .textStyle(
                  GoogleFonts.poppins(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .make(),
            "Your Digital Gymbro!".text
                .textStyle(
                  GoogleFonts.poppins(
                    fontSize: 22,
                    color: Vx.white,
                    fontWeight: FontWeight.w600,
                  ),
                )
                .make(),
            10.heightBox,
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
                  border: BoxBorder.all(color: Colors.black),
                ),
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.asset('assets/images/avatar_waving.png'),
                  ),
                ),
              ),
            ),
            20.heightBox,
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: "Sign up".text.bold
                  .textStyle(GoogleFonts.poppins())
                  .make(),
            ).wh(120, 40),
            20.heightBox,
            "Already have an account ?".text.white.make(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 40, 163, 16),
                foregroundColor: Colors.white,
              ),
              child: "Login".text.textStyle(GoogleFonts.poppins()).bold.make(),
            ),
          ],
        ),
      ),
    );
  }
}