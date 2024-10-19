import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/custom_button.dart';
import '../Config/constants.dart';

class RestPassword extends StatefulWidget {
  const RestPassword({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RestPassword();
  }
}

class _RestPassword extends State<RestPassword> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _cpassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _pObscured = false;
  bool _cpObscured = false;

  @override
  Widget build(BuildContext context) {
    Screen.setSize(context);
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
          body: Center(
              child: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Opacity(
                  opacity: 0.6,
                  child: Transform.translate(
                    offset: const Offset(0, -100),
                    child: SizedBox(
                      width: Screen.size.width,
                      height: Screen.size.height * 0.4,
                      child: const Image(
                        image: AssetImage("assets/image/skyLogin.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              Container(
                width: Screen.size.width,
                height: Screen.size.height * 0.5,
                alignment: Alignment.centerLeft,
                child: Transform.translate(
                  offset: const Offset(0, 0),
                  // Move image 50 pixels to the left
                  child: Transform.scale(
                    scale: 0.8, // Zoom in the image by 1.5x
                    child: const Image(
                      image: AssetImage("assets/image/password.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text("Rest your password",
              style: GoogleFonts.rubik(
                  fontSize: 30, color: const Color.fromARGB(255, 42, 87, 208))),
          const SizedBox(height: 48),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: Width.xxl(),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      cursorColor: MainColors.black,
                      style: GoogleFonts.mada(
                        color: MainColors.black,
                        fontSize: Fonts.sm(),
                      ),
                      controller: _passController,
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
                          fontSize: Fonts.sm(),
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
                              color: Color(0xFFF34313), width: 2),
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
                  const SizedBox(height: 15),
                  SizedBox(
                    width: Width.xxl(),
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      cursorColor: MainColors.black,
                      style: GoogleFonts.mada(
                        color: MainColors.black,
                        fontSize: Fonts.sm(),
                      ),
                      controller: _cpassController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _cpObscured = !_cpObscured;
                            });
                          },
                          icon: Icon(_cpObscured
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: MainColors.black,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        hintStyle: GoogleFonts.mada(
                          color: MainColors.black,
                          fontSize: Fonts.sm(),
                        ),
                        hintText: 'Repeat New password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: MainColors.deepPurple, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFFF34313), width: 2),
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
                      obscureText: !_cpObscured,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    width: Width.xxl(),
                    height: ButtonHeights.md(),
                    hasGradient: true,
                    gradientColors: const [
                      MainColors.primary,
                      MainColors.primary
                    ],
                    hasImage: false,
                    imagePath: "",
                    imageOpacity: 0.1,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    normalColor: MainColors.transparent,
                    borderRadius: CustomRadius.sm(),
                    leftPadding: 20,
                    rightPadding: 20,
                    topPadding: 5,
                    bottomPadding: 15,
                    label: "Reset",
                    fontSize: Fonts.sm(),
                    textColor: MainColors.white,
                    onPressed: () {},
                  ),
                ],
              )),
        ]),
      )));
    });
  }
}
