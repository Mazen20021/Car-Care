import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/custom_button.dart';
import '../Components/nav_button.dart';
import '../Config/constants.dart';
import 'login_page.dart';

class Settings extends StatefulWidget {
  final bool isSub;
  final String userName;

  const Settings({required this.isSub, required this.userName, super.key});

  @override
  State<StatefulWidget> createState() {
    return _Settings();
  }
}

class _Settings extends State<Settings> {
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 65),
          Row(
            children: [
              const SizedBox(width: 15),
              Text("Settings",
                  style: GoogleFonts.rubik(
                      fontSize: Fonts.xxl, color: MainColors.black)),
              const SizedBox(width: 170),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Login()));
                },
                child: Container(
                  width: 91,
                  height: 33.43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 108, 113, 132),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.login_outlined,
                            color: MainColors.white, size: 15),
                        const SizedBox(width: 10),
                        Text("Logout",
                            style: GoogleFonts.rubik(
                                fontSize: Fonts.sm, color: MainColors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(color: MainColors.black,blurRadius: 10,offset: Offset(0, 0))],
                    color: const Color.fromARGB(255, 254, 247, 255),
                    border: Border.all(
                      color: MainColors.primary, // Set the border color to blue
                      width: 1, // Adjust the width of the border if needed
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Text("Free trial plan",
                          style: GoogleFonts.rubik(
                              fontSize: Fonts.md, color: MainColors.primary)),
                      const SizedBox(
                        width: 150,
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                        width: 110,
                        height: 35.11,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MainColors.primary,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.keyboard_double_arrow_up_rounded,
                              color: MainColors.white,
                            ),
                            Text("UPGRADE",
                                style: GoogleFonts.rubik(
                                    fontSize: Fonts.md,
                                    color: MainColors.white))
                      ],
                        ),
                      ),
                      )],
                  ))),
          Transform.translate(offset: const Offset(-150, 0),
            child: Text("Information",style: GoogleFonts.rubik(
            fontSize: Fonts.md,
                color: MainColors.black)),
          ),
          Padding(padding: const EdgeInsets.all(16),child:
          Container(
            width: Screen.size.width,
            height: Screen.size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: MainColors.black,blurRadius: 10,offset: Offset(0, 0))],
              color: const Color.fromARGB(255, 254, 247, 255),
            ),
            child: Center(child:
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      SizedBox(
                        width: Width.xxl *0.85,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          cursorColor: MainColors.black,
                          style: GoogleFonts.mada(
                            color: MainColors.black,
                            fontSize: Fonts.md,
                          ),
                          controller: _fName,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            hintStyle: GoogleFonts.mada(
                              color: MainColors.black,
                              fontSize: Fonts.md,
                            ),
                            hintText: 'Enter First Name',
                            label: const Text("First Name"),
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
                              return 'Please Enter Your First Name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: Width.xxl *0.85,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          cursorColor: MainColors.black,
                          style: GoogleFonts.mada(
                            color: MainColors.black,
                            fontSize: Fonts.md,
                          ),
                          controller: _lName,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            hintStyle: GoogleFonts.mada(
                              color: MainColors.black,
                              fontSize: Fonts.md,
                            ),
                            hintText: 'Enter Last Name',
                            label: const Text("Last Name"),
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
                              return 'Please Enter Your Last Name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Transform.translate(
                          offset: const Offset(13, 20),
                          child: Row(
                            children: [
                              CustomButton(
                                  width: 130,
                                  height: 50,
                                  hasGradient: true,
                                  gradientColors: const [
                                    Color.fromARGB(
                                        255, 48, 95, 215),
                                    Color.fromARGB(255, 48, 95, 215)
                                  ],
                                  hasImage: true,
                                  imagePath:
                                  "assets/image/loginBackground.png",
                                  imageOpacity: 0.1,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  normalColor:
                                  MainColors.transparent,
                                  borderRadius: CustomRadius.sm,
                                  leftPadding: 20,
                                  rightPadding: 20,
                                  topPadding: 5,
                                  bottomPadding: 15,
                                  label: "Save",
                                  fontSize: Fonts.sm,
                                  textColor: MainColors.white,
                                  onPressed: () {}),
                              Transform.translate(
                                offset: const Offset(34, 0),
                                child: CustomButton(
                                    width: 130,
                                    height: 50,
                                    hasGradient: true,
                                    gradientColors: const [
                                      Color.fromARGB(
                                          255, 180, 74, 80),
                                      Color.fromARGB(
                                          255, 181, 74, 80)
                                    ],
                                    hasImage: true,
                                    imagePath:
                                    "assets/image/loginBackground.png",
                                    imageOpacity: 0.1,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    normalColor:
                                    MainColors.transparent,
                                    borderRadius: CustomRadius.sm,
                                    leftPadding: 0,
                                    rightPadding: 20,
                                    topPadding: 5,
                                    bottomPadding: 15,
                                    label: "Cancel",
                                    fontSize: Fonts.sm,
                                    textColor: MainColors.white,
                                    onPressed: () {
                                      Navigator.pop(
                                        context
                                      );
                                    }),
                              )
                            ],
                          )),

                    ],
                  ),
                ),
              ),
          ),),
          const SizedBox(height: 30),
          Transform.translate(offset: const Offset(-110, 0),
            child: Text("Repairs Configuration",style: GoogleFonts.rubik(
                fontSize: Fonts.md,
                color: MainColors.black)),
          ),
          const SizedBox(height: 10),
          CustomButton(
              width: Screen.size.width,
              height: 50,
              hasGradient: true,
              gradientColors: const [
                Color.fromARGB(
                    255, 48, 95, 215),
                Color.fromARGB(255, 48, 95, 215)
              ],
              hasImage: true,
              imagePath:
              "assets/image/loginBackground.png",
              imageOpacity: 0.1,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              normalColor:
              MainColors.transparent,
              borderRadius: CustomRadius.xl,
              leftPadding: 20,
              rightPadding: 20,
              topPadding: 5,
              bottomPadding: 15,
              label: "Edit Repairs Configuration",
              fontSize: Fonts.sm,
              textColor: MainColors.white,
              onPressed: () {}),
        ],
      ),
      bottomSheet: Container(
        width: Screen.size.width,
        height: Screen.size.height * 0.1,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 250, 251, 252),
          boxShadow: [
            BoxShadow(
              color: MainColors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, -2), // Shadow direction: towards the top
            ),
          ],
        ),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: MainColors.white,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // Center the content vertically
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: NavButton(
                      hasIcon: true,
                      buttonImage: "",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      title: "Dashboard",
                      width: 65,
                      height: 45,
                      buttonIcon: Icons.directions_car_filled,
                      currentColor: const Color.fromARGB(255, 12, 21, 52),
                      currentBorderColor: MainColors.white,
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: NavButton(
                      hasIcon: false,
                      buttonImage: "assets/customIcons/garage.png",
                      onPressed: () {},
                      title: "Car List",
                      width: 65,
                      height: 45,
                      buttonIcon: Icons.ac_unit_outlined,
                      currentColor: const Color.fromARGB(255, 12, 21, 52),
                      currentBorderColor: MainColors.white,
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: NavButton(
                      buttonImage: "",
                      hasIcon: true,
                      onPressed: () {},
                      title: "Add Gas",
                      width: 65,
                      height: 45,
                      buttonIcon: Icons.local_gas_station_rounded,
                      currentColor: const Color.fromARGB(255, 12, 21, 52),
                      currentBorderColor: MainColors.white,
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: NavButton(
                      buttonImage: "",
                      hasIcon: true,
                      onPressed: () {},
                      title: "Settings",
                      width: 65,
                      height: 45,
                      buttonIcon: Icons.settings,
                      currentColor: const Color.fromARGB(255, 42, 87, 208),
                      currentBorderColor:
                          const Color.fromARGB(255, 42, 87, 208),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}