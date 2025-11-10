import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool isObsecured = true;
  String name = ' ';
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    // 2️⃣ Listen for text changes
    _namecontroller.addListener(() {
      setState(() {
        name = _namecontroller.text;
      }); // rebuild UI whenever user types
    });
  }

  @override
  void dispose() {
    _namecontroller.dispose(); // cleanup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: 130,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.asset('assets/images/avatar_waving.png'),
                      ),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,

                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome Back',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: '   '),

                        TextSpan(
                          text: name.isEmpty ? ' ' : name.capitalized,
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: '!', style: TextStyle(fontSize: 32)),
                      ],
                    ),
                  ),
                  30.heightBox,
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _namecontroller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.person),
                            label: 'Enter Username'.text.make(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.cyanAccent,
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Username';
                            } else {
                              return null;
                            }
                          },
                        ).p12(),
                        20.heightBox,
                        TextFormField(
                          obscureText: isObsecured,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            label: 'Enter Password'.text.make(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObsecured = !isObsecured;
                                });
                              },
                              icon: isObsecured
                                  ? Icon(Icons.visibility_off_rounded)
                                  : Icon(Icons.visibility),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.cyanAccent,
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            } else {
                              return null;
                            }
                          },
                        ).p12(),
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {}
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                          ),
                          child: "Submit".text.white.bold.make(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
