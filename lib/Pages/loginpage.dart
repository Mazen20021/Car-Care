import 'package:carcare/Config/constants.dart';
import 'package:carcare/Pages/forgetpasswordpage.dart';
import 'package:carcare/Pages/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/Buttons.dart';
import 'carselectedpage.dart';
import '../Services/mainpageservice.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Screen.setSize(context);
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        body: Column(
          children: [
            SingleChildScrollView(
              child: Column(children: [
                Stack(
                  children: [
                    Opacity(
                      opacity: 0.6,
                      child: SizedBox(
                        width: Screen.size.width,
                        height: Screen.size.height * 0.25,
                        child: const Image(
                          image: AssetImage("assets/image/skyLogin.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: Screen.size.width,
                      height: Screen.size.height * 0.5,
                      alignment: Alignment.centerLeft,
                      child: Transform.translate(
                        offset: const Offset(
                            -30, 0), // Move image 50 pixels to the left
                        child: Transform.scale(
                          scale: 1.2, // Zoom in the image by 1.5x
                          child: const Image(
                            image: AssetImage("assets/image/carLogin.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text("Login to your account",
                    style: GoogleFonts.rubik(
                        fontSize: 30,
                        color: const Color.fromARGB(255, 42, 87, 208))),
                const SizedBox(height: 48),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: Screen.size.width * 0.9,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          cursorColor: Colors.black,
                          style: GoogleFonts.mada(
                            color: Colors.black,
                            fontSize: Screen.size.width * 0.05,
                          ),
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            hintStyle: GoogleFonts.mada(
                              color: Colors.black,
                              fontSize: Screen.size.width * 0.05,
                            ),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.deepPurple, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xfff343131), width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.deepPurple, width: 2.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.redAccent, width: 2.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.redAccent, width: 2.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: Screen.size.width * 0.9,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          cursorColor: Colors.black,
                          style: GoogleFonts.mada(
                            color: Colors.black,
                            fontSize: Fonts.sm(),
                          ),
                          controller: _passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                              icon: Icon(_isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: Colors.black,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            hintStyle: GoogleFonts.mada(
                              color: Colors.black,
                              fontSize: Fonts.sm(),
                            ),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.deepPurple, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Color(0xfff343131), width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.deepPurple, width: 2.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.redAccent, width: 2.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.redAccent, width: 2.0),
                            ),
                          ),
                          obscureText: !_isObscured,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      ButtonClass(
                          width: Width.xxl(),
                          height: Width.bHeight,
                          hasGradient: true,
                          gradientColors: const [
                            Color.fromARGB(255, 53, 145, 249),
                            Color.fromARGB(255, 119, 182, 252)
                          ],
                          hasImage: true,
                          imagePath: "assets/image/loginBackground.png",
                          imageOpacity: 0.1,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          normalColor: Colors.transparent,
                          borderRadius: CustomRadius.sm,
                          leftPadding: 20,
                          rightPadding: 20,
                          topPadding: 5,
                          bottomPadding: 15,
                          label: "Login",
                          fontSize: Fonts.sm(),
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPageService(isCarSelected: false,userName: "Mazen",currentIndex: 0,)),
                            );
                          }),
                    ],
                  ),
                ),
              ]),
            ),
            Column(
              children: [
                SizedBox(
                  height: Height.sm(),
                ),
                Transform.rotate(
                  angle: -3 * (3.14 / 180),
                  child: Container(
                      width: Screen.size.width,
                      height: Screen.size.height * 0.09,
                      decoration: BoxDecoration(
                          boxShadow: List.filled(
                              20,
                              growable: true,
                              const BoxShadow(
                                color: Color.fromARGB(255, 214, 232, 253),
                                blurRadius: 8,
                              )),
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 53, 145, 249),
                                Color.fromARGB(255, 119, 182, 252)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)),
                      child: Transform.rotate(
                        angle: 3 * (3.14 / 180),
                        child: Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Signup()),
                                  );
                                },
                                child: Text(
                                  "Create a new account",
                                  style: GoogleFonts.rubik(
                                      fontSize: 15,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white),
                                )),
                            const SizedBox(width: 40),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPass()),
                                  );
                                },
                                child: Text("Forgot your password?",
                                    style: GoogleFonts.rubik(
                                        fontSize: 15,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white))),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
