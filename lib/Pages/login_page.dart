import 'package:carcare/Config/constants.dart';
import 'package:carcare/Pages/forget_password_page.dart';
import 'package:carcare/Pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/custom_button.dart';
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
  bool _ispressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      Screen.setSize(context);
      print(Fonts.xxl);
      return Scaffold(
        body: Column(
          children: [
            Expanded(child: SingleChildScrollView(
              physics: !_ispressed?  const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
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
                        offset: const Offset(-30, 0),
                        child: Transform.scale(
                          scale: 1.2,
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
                        fontSize: Fonts.xxl(),
                        color: const Color.fromARGB(255, 42, 87, 208),
                    ),
                ),
                const SizedBox(height: 48),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: Width.xxl(),
                        child: TextFormField(
                          onTap: (){
                            setState(() {
                              _ispressed = true;
                            });
                          },
                          textAlign: TextAlign.left,
                          cursorColor: MainColors.black,
                          style: GoogleFonts.mada(
                            color: MainColors.black,
                            fontSize: Fonts.md(),
                          ),
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            hintStyle: GoogleFonts.mada(
                              color: MainColors.black,
                              fontSize: Fonts.md(),
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
                                  color: MainColors.black, width: 1),
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
                      const SizedBox(height: 15),
                      SizedBox(
                        width: Width.xxl(),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          cursorColor: MainColors.black,
                          style: GoogleFonts.mada(
                            color: MainColors.black,
                            fontSize: Fonts.md(),
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
                              color: MainColors.black,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            hintStyle: GoogleFonts.mada(
                              color: MainColors.black,
                              fontSize: Fonts.md(),
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
                                  color: MainColors.black, width: 1),
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
                      CustomButton(
                          width: Width.xxl(),
                          height: ButtonHeights.md(),
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
                          borderRadius: CustomRadius.sm(),
                          leftPadding: 20,
                          rightPadding: 20,
                          topPadding: 5,
                          bottomPadding: 15,
                          label: "Login",
                          fontSize: Fonts.lg(),
                          textColor: MainColors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPageService(
                                        isCarSelected: false,
                                        userName: "Mazen",
                                        currentIndex: 0,
                                      )),
                            );
                          }),
                    ],
                  ),
                ),
              ]),
            ),
            ),
            Transform.translate(offset: const Offset(0, 10) ,child:
            Column(
              children: [
                SizedBox(
                  height: Height.x2s(),
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
                                      fontSize: Fonts.sm(),
                                      color: MainColors.white,
                                      decoration: TextDecoration.underline,
                                      decorationColor: MainColors.white),
                                )),
                             SizedBox(width: Screen.size.width * 0.2),
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
                                        fontSize: Fonts.sm(),
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
      );
    });
  }
}
