import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/custom_button.dart';
import '../Config/constants.dart';

class RepairClass extends StatelessWidget {
  static final TextEditingController _repairName = TextEditingController();
  static final TextEditingController _repairKM = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          SingleChildScrollView(
              child: Container(
                  width: Screen.size.width,
                  height: Screen.size.height,
                  decoration: BoxDecoration(
                    color: MainColors.primary.withOpacity(0.8),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            "Add a new repair part",
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.bold,
                                color: MainColors.white,
                                fontSize: Fonts.xl(),
                                decoration: TextDecoration.none),
                          ),
                          const Spacer(flex: 5),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CustomButton(
                                width: 40,
                                height: 40,
                                hasGradient: true,
                                gradientColors: const [
                                  MainColors.white,
                                  MainColors.white,
                                ],
                                hasImage: false,
                                imagePath: "",
                                imageOpacity: 0.1,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                normalColor: MainColors.transparent,
                                borderRadius: CustomRadius.sm(),
                                leftPadding: 0,
                                rightPadding: 0,
                                topPadding: 0,
                                bottomPadding: 0,
                                label: "",
                                fontSize: 0,
                                textColor: MainColors.white,
                                hasIcon: true,
                                buttonIcon: Icons.close_rounded,
                                iconColor: MainColors.primary,
                                iconSize: 30,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          )
                        ],
                      ),
                      const SizedBox(height: 80),
                      SizedBox(
                          width: Screen.size.width * 0.85,
                          height: Screen.size.height * 0.6,
                          child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MainColors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Transform.scale(
                                            scale: 0.8,
                                            child: const Image(
                                              image: AssetImage("assets/manWithCar.png"),
                                              fit: BoxFit.cover,
                                            )),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          width: Screen.size.width * 0.8,
                                          child: TextFormField(
                                            textAlign: TextAlign.left,
                                            cursorColor: MainColors.black,
                                            style: GoogleFonts.mada(
                                              color: MainColors.black,
                                              fontSize: Fonts.sm(),
                                            ),
                                            controller: _repairName,
                                            decoration: InputDecoration(
                                              label: const Text("Repair Name"),
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 20),
                                              hintStyle: GoogleFonts.mada(
                                                color: MainColors.black,
                                                fontSize: Fonts.sm(),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.black, width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 13),
                                        SizedBox(
                                          width: Screen.size.width * 0.8,
                                          child: TextFormField(
                                            textAlign: TextAlign.left,
                                            cursorColor: MainColors.black,
                                            style: GoogleFonts.mada(
                                              color: MainColors.black,
                                              fontSize: Fonts.sm(),
                                            ),
                                            controller: _repairKM,
                                            keyboardType:
                                            const TextInputType.numberWithOptions(
                                                decimal: true),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d*\.?\d*')),
                                            ],
                                            decoration: InputDecoration(
                                              label: const Text("Remind you every (KM)"),
                                              contentPadding: const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 20),
                                              hintStyle: GoogleFonts.mada(
                                                color: MainColors.black,
                                                fontSize: Fonts.sm(),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.black, width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.deepPurple,
                                                    width: 2.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: MainColors.redAccent,
                                                    width: 2.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text("The number of km that will make a reminder for you to check",style: GoogleFonts.rubik(
                                            fontSize: Fonts.sm()
                                        ),),
                                        Transform.translate(
                                          offset: const Offset(-15, 17),
                                          child: Center(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: Screen.size.width * 0.43,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 244, 244, 244),
                                                        shape:
                                                        const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(0),
                                                            bottomLeft:
                                                            Radius.circular(20),
                                                          ),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(16),
                                                        child: Text(
                                                          'Cancel',
                                                          style: GoogleFonts.rubik(
                                                            fontWeight: FontWeight.bold,
                                                            color: const Color.fromARGB(
                                                                255, 133, 133, 133),
                                                            fontSize: Fonts.md(),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(0),
                                                  child: Container(
                                                    width: 2,
                                                    color: Colors
                                                        .black, // Color of the divider
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Screen.size.width * 0.413,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      // Add your action for the second button
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 12, 21, 52),
                                                      shape: const RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(0),
                                                          bottomRight:
                                                          Radius.circular(20),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                        padding: const EdgeInsets.all(16),
                                                        child: Row(children: [
                                                          Text(
                                                            'Submit',
                                                            style: GoogleFonts.rubik(
                                                              fontWeight: FontWeight.bold,
                                                              color: MainColors.white,
                                                              fontSize: Fonts.md(),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10),
                                                          const Icon(Icons.add,color: MainColors.white,size: 18)
                                                        ])),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )))
                    ],
                  )))
        ],)
       );
  }
}
