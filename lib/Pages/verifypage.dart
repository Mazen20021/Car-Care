import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/Buttons.dart';
import '../Config/constants.dart';
import 'restpassword.dart';

class Verify extends StatefulWidget
{
  const Verify({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Verify();
  }
}

class _Verify extends State<Verify> {

  final TextEditingController _box1Controller = TextEditingController();
  final TextEditingController _box2Controller = TextEditingController();
  final TextEditingController _box3Controller = TextEditingController();
  final TextEditingController _box4Controller = TextEditingController();
  final TextEditingController _box5Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Screen.setSize(context);
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
          body: Center(
              child: SingleChildScrollView(child: Column(children: [
                Stack(
                  children: [Opacity(
                      opacity: 0.6,
                      child:
                      Transform.translate(
                        offset: const Offset(0, -100),
                        child:
                        SizedBox(
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
                Text("Verification code sent", style: GoogleFonts.rubik(
                    fontSize: 30,
                    color: const Color.fromARGB(255, 42, 87, 208)
                )),
                const SizedBox(height: 48),
                Form(
                    key: _formKey,
                    child: Column(children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        SizedBox(
                          width: Screen.size.width * 0.15,
                          child: TextFormField(
                            maxLength: 1,
                            textAlign: TextAlign.left,
                            cursorColor: Colors.black,
                            style: GoogleFonts.mada(
                              color: Colors.black,
                              fontSize: Screen.size.width * 0.05,
                            ),
                            controller: _box1Controller,
                            decoration: InputDecoration(
                                counterText: '',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              hintStyle: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: Screen.size.width * 0.05,
                              ),
                              hintText: '',
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
                        const SizedBox(width: 10),
                        SizedBox(
                          width: Screen.size.width * 0.15,
                          child: TextFormField(
                            maxLength: 1,
                            textAlign: TextAlign.left,
                            cursorColor: Colors.black,
                            style: GoogleFonts.mada(
                              color: Colors.black,
                              fontSize: Screen.size.width * 0.05,
                            ),
                            controller: _box2Controller,
                            decoration: InputDecoration(
                                counterText: '',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              hintStyle: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: Screen.size.width * 0.05,
                              ),
                              hintText: '',
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
                          const SizedBox(width: 10),
                        SizedBox(
                          width: Screen.size.width * 0.15,
                          child: TextFormField(
                            maxLength: 1,
                            textAlign: TextAlign.left,
                            cursorColor: Colors.black,
                            style: GoogleFonts.mada(
                              color: Colors.black,
                              fontSize: Screen.size.width * 0.05,
                            ),
                            controller: _box3Controller,
                            decoration: InputDecoration(
                                counterText: '',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              hintStyle: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: Screen.size.width * 0.05,
                              ),
                              hintText: '',
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
                          const SizedBox(width: 10),
                        SizedBox(
                          width: Screen.size.width * 0.15,
                          child: TextFormField(
                            maxLength: 1,
                            textAlign: TextAlign.left,
                            cursorColor: Colors.black,
                            style: GoogleFonts.mada(
                              color: Colors.black,
                              fontSize: Screen.size.width * 0.05,
                            ),
                            controller: _box4Controller,
                            decoration: InputDecoration(
                                counterText: '',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              hintStyle: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: Screen.size.width * 0.05,
                              ),
                              hintText: '',
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
                          const SizedBox(width: 10),
                        SizedBox(
                          width: Screen.size.width * 0.15,
                          child: TextFormField(
                            maxLength: 1,
                            textAlign: TextAlign.left,
                            cursorColor: Colors.black,
                            style: GoogleFonts.mada(
                              color: Colors.black,
                              fontSize: Screen.size.width * 0.05,
                            ),
                            controller: _box5Controller,
                            decoration: InputDecoration(
                                counterText: '',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              hintStyle: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: Screen.size.width * 0.05,
                              ),
                              hintText: '',
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
                      ],),
                      const SizedBox(height: 35),
                      ButtonClass(
                          width: Sizes.xxl(),
                          height: Sizes.bHeight,
                          hasGradient: true,
                          gradientColors: const [MainColors.primary , MainColors.primary],
                          hasImage: false,
                          imagePath: "",
                          imageOpacity: 0.1,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          normalColor: Colors.transparent,
                          borderRadius: Radius.sm,
                          leftPadding: 20,
                          rightPadding: 20,
                          topPadding: 5,
                          bottomPadding: 15,
                          label: "Verify",
                          fontSize: Fonts.sm(),
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RestPassword()),
                            );
                          },
                      ),
                    ],)
                ),
              ]),
              )
          ));
    });
  }
}
