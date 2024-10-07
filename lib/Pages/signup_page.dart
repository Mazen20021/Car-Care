import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/buttons.dart';
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
            child: SingleChildScrollView(
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
              height: Screen.size.height * 0.35,
              alignment: Alignment.centerLeft,
              child: Transform.translate(
                offset:
                    const Offset(-30, 0), // Move image 50 pixels to the left
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
      ),
      Text("Create new account",
          style: GoogleFonts.rubik(
              fontSize: 30, color: const Color.fromARGB(255, 42, 87, 208))),
      const SizedBox(height: 48),
      Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(
              width: Width.xxl,
              child: TextFormField(
                textAlign: TextAlign.left,
                cursorColor: Colors.black,
                style: GoogleFonts.mada(
                  color: Colors.black,
                  fontSize: Width.xs,
                ),
                controller: _fNameController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintStyle: GoogleFonts.mada(
                    color: Colors.black,
                    fontSize: Width.xs,
                  ),
                  hintText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFFF34313), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2.0),
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
                cursorColor: Colors.black,
                style: GoogleFonts.mada(
                  color: Colors.black,
                  fontSize: Width.xs,
                ),
                controller: _lNameController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintStyle: GoogleFonts.mada(
                    color: Colors.black,
                    fontSize: Width.xs,
                  ),
                  hintText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFFF34313), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2.0),
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
                cursorColor: Colors.black,
                style: GoogleFonts.mada(
                  color: Colors.black,
                  fontSize: Width.xs,
                ),
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintStyle: GoogleFonts.mada(
                    color: Colors.black,
                    fontSize: Width.xs,
                  ),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFFF34313), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2.0),
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
                cursorColor: Colors.black,
                style: GoogleFonts.mada(
                  color: Colors.black,
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
                    icon: Icon(
                        _pObscured ? Icons.visibility : Icons.visibility_off),
                    color: Colors.black,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintStyle: GoogleFonts.mada(
                    color: Colors.black,
                    fontSize: Fonts.sm,
                  ),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFFF34313), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2.0),
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
                cursorColor: Colors.black,
                style: GoogleFonts.mada(
                  color: Colors.black,
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
                    icon: Icon(
                        _cPObscured ? Icons.visibility : Icons.visibility_off),
                    color: Colors.black,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintStyle: GoogleFonts.mada(
                    color: Colors.black,
                    fontSize: Fonts.sm,
                  ),
                  hintText: 'Repeat Your Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Color(0xFFF34313), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 2.0),
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
              mainAxisSize: MainAxisSize.min,
              children: [
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
                  "I Agree on carcare",
                  style: GoogleFonts.rubik(
                    fontSize: 17,
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Terms and conditions",
                      style: GoogleFonts.rubik(
                          fontSize: 17, color: MainColors.primary),
                    ))
              ],
            ),
            const SizedBox(height: 5),
            ButtonClass(
                width: Width.xxl,
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
                label: "Create My Account",
                fontSize: Fonts.sm,
                textColor: Colors.white,
                onPressed: () {}),
          ]))
    ]))));
  }
}
