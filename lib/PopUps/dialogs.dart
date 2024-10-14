import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/custom_button.dart';
import '../Config/constants.dart';

class PopUps {
  static final TextEditingController _repairName = TextEditingController();
  static final TextEditingController _repairKM = TextEditingController();

  static void showRepairDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
            width: Screen.size.width,
            height: Screen.size.height,
            decoration: BoxDecoration(
              color: MainColors.primary.withOpacity(0.8),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      "Add a new repair part",
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          color: MainColors.white,
                          fontSize: Fonts.xl,
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
                          borderRadius: CustomRadius.sm,
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
                const SizedBox(height: 100),
                SizedBox(
                    width: Screen.size.width,
                    height: Screen.size.height * 0.6,
                    child: Dialog(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: MainColors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              const Image(
                                image: AssetImage("assets/manWithCar.png"),
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: Screen.size.width * 0.7,
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  cursorColor: MainColors.black,
                                  style: GoogleFonts.mada(
                                    color: MainColors.black,
                                    fontSize: Fonts.sm,
                                  ),
                                  controller: _repairName,
                                  decoration: InputDecoration(
                                    label: const Text("Repair Name"),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    hintStyle: GoogleFonts.mada(
                                      color: MainColors.black,
                                      fontSize: Width.xs,
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
                                width: Screen.size.width * 0.7,
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  cursorColor: MainColors.black,
                                  style: GoogleFonts.mada(
                                    color: MainColors.black,
                                    fontSize: Fonts.sm,
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
                                        vertical: 5, horizontal: 20),
                                    hintStyle: GoogleFonts.mada(
                                      color: MainColors.black,
                                      fontSize: Width.xs,
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
                              Transform.translate(
                                offset: const Offset(-0.37, 50),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: Screen.size.width * 0.4,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              // Add your action for the first button
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 244, 244, 244),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                'Skip',
                                                style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color.fromARGB(
                                                      255, 133, 133, 133),
                                                  fontSize: Fonts.md,
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
                                        width: Screen.size.width * 0.4,
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
                                                topRight: Radius.circular(8),
                                                bottomRight: Radius.circular(8),
                                              ),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Text(
                                              'Save',
                                              style: GoogleFonts.rubik(
                                                fontWeight: FontWeight.bold,
                                                color: MainColors.white,
                                                fontSize: Fonts.md,
                                              ),
                                            ),
                                          ),
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
                    ))
              ],
            ));
      },
    );
  }
}
