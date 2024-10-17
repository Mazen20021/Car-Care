import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/custom_button.dart';
import '../Config/constants.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  late bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  bool _pObscured = false;
  bool _cPObscured = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(children: [
            Expanded(child:
          SingleChildScrollView(
              child: Column(children: [
              Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Stack(
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
                height: Screen.size.height * 0.45,
                alignment: Alignment.centerLeft,
                child: Transform.translate(
                  offset: const Offset(-25, 20),
                  // Move image 50 pixels to the left
                  child: Transform.scale(
                    scale: 1.1, // Zoom in the image by 1.5x
                    child: const Image(
                      image: AssetImage("assets/image/carLogin.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -35),
          child: Text("Create new account",
              style: GoogleFonts.rubik(
                  fontSize: Fonts.xl,
                  color: const Color.fromARGB(255, 42, 87, 208))),
        ),
        Transform.translate(
          offset: const Offset(0, -23),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: Width.xxl,
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    cursorColor: MainColors.black,
                    style: GoogleFonts.mada(
                      color: MainColors.black,
                      fontSize: Fonts.sm,
                    ),
                    controller: _fNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      hintStyle: GoogleFonts.mada(
                        color: MainColors.black,
                        fontSize: Fonts.sm,
                      ),
                      hintText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.deepPurple, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.black, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.deepPurple, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.redAccent, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.redAccent, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your First Name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: Width.xxl,
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    cursorColor: MainColors.black,
                    style: GoogleFonts.mada(
                      color: MainColors.black,
                      fontSize: Fonts.sm,
                    ),
                    controller: _lNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      hintStyle: GoogleFonts.mada(
                        color: MainColors.black,
                        fontSize: Fonts.sm,
                      ),
                      hintText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.deepPurple, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.black, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.deepPurple, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.redAccent, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.redAccent, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Last Name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: Width.xxl,
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    cursorColor: MainColors.black,
                    style: GoogleFonts.mada(
                      color: MainColors.black,
                      fontSize: Fonts.sm,
                    ),
                    controller: _emailController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      hintStyle: GoogleFonts.mada(
                        color: MainColors.black,
                        fontSize: Fonts.sm,
                      ),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.deepPurple, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.black, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.deepPurple, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.redAccent, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.redAccent, width: 2.0),
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
                const SizedBox(height: 10),
                SizedBox(
                  width: Width.xxl,
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    cursorColor: MainColors.black,
                    style: GoogleFonts.mada(
                      color: MainColors.black,
                      fontSize: Fonts.sm,
                    ),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _pObscured = !_pObscured;
                          });
                        },
                        icon: Icon(_pObscured
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: MainColors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      hintStyle: GoogleFonts.mada(
                        color: MainColors.black,
                        fontSize: Fonts.sm,
                      ),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.deepPurple, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.black, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.deepPurple, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.redAccent, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.redAccent, width: 2.0),
                      ),
                    ),
                    obscureText: !_pObscured,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: Width.xxl,
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    cursorColor: MainColors.black,
                    style: GoogleFonts.mada(
                      color: MainColors.black,
                      fontSize: Fonts.sm,
                    ),
                    controller: _rePasswordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _cPObscured = !_cPObscured;
                          });
                        },
                        icon: Icon(_cPObscured
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: MainColors.black,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      hintStyle: GoogleFonts.mada(
                        color: MainColors.black,
                        fontSize: Fonts.sm,
                      ),
                      hintText: 'Repeat Your Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.deepPurple, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.black, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.deepPurple, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.redAccent, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: MainColors.redAccent, width: 2.0),
                      ),
                    ),
                    obscureText: !_cPObscured,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(width: 7),
                    Checkbox(
                      activeColor: MainColors.primary,
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                    Text(
                      "I Agree On Carcare",
                      style: GoogleFonts.rubik(
                          fontSize: Fonts.sm,
                          fontWeight: FontWeight.bold),
                    ),
                    Transform.translate(
                        offset: const Offset(-10, 0),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Terms and conditions",
                              style: GoogleFonts.rubik(
                                  decoration: TextDecoration.underline,
                                  decorationColor: MainColors.primary,
                                  fontSize: Fonts.sm,
                                  color: MainColors.primary),
                            )))
                  ],
                ),
                CustomButton(
                    width: Width.xxl,
                    height: 50,
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
                    normalColor: MainColors.transparent,
                    borderRadius: CustomRadius.sm,
                    leftPadding: 20,
                    rightPadding: 20,
                    topPadding: 5,
                    bottomPadding: 15,
                    label: "Create My Account",
                    fontSize: Fonts.sm,
                    textColor: MainColors.white,
                    onPressed: () {}),

              ],
            ),
          ),
        ),
          ],)),),
                Transform.translate(offset: const Offset(0, 10) ,child:
                Column(
                  children: [
                    SizedBox(
                      height: Height.x3s,
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
                                      Navigator.pop(
                                        context,
                                      );
                                    },
                                    child: Text(
                                      "Already has an account",
                                      style: GoogleFonts.rubik(
                                          fontSize: Fonts.sm,
                                          color: MainColors.white,
                                          decoration: TextDecoration.underline,
                                          decorationColor: MainColors.white),
                                    )),
                                SizedBox(width: Screen.size.width * 0.2),
                                TextButton(
                                    onPressed: () {},
                                    child: Text("Forgot your password?",
                                        style: GoogleFonts.rubik(
                                            fontSize: Fonts.sm,
                                            color: MainColors.white,
                                            decoration: TextDecoration.underline,
                                            decorationColor: MainColors.white))),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                )
            ],
    ),
    )
    );
  }
}
