import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Config/constants.dart';

class NavButton extends StatelessWidget {
  final double width;
  final double height;
  final String buttonImage;
  final String title;
  final Color currentColor;
  final Color currentBorderColor;
  final VoidCallback onPressed;
  final bool hasIcon;
  final IconData buttonIcon;
  const NavButton(
      {required this.width,
      required this.height,
      required this.buttonIcon,
      required this.currentColor,
      required this.currentBorderColor,
      required this.title,
      required this.onPressed,
      required this.hasIcon,
      required this.buttonImage,
      super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: MainColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: currentBorderColor),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 228, 228, 228), // Shadow color
                spreadRadius: 2,
                blurRadius:5,
                offset: Offset(0, 0), // Shadow direction: towards the top
              ),
            ], // Assuming you replace MainColors.primary with actual color
          ),
          child: !hasIcon
              ? Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Center the icon and text vertically
                  children: [
                    hasIcon
                        ? Icon(buttonIcon, color: currentColor)
                        : Transform.translate(
                            offset: const Offset(0, -14),
                            child: Transform.scale(
                              scale: 0.35,
                              child: Image(
                                  image: AssetImage(buttonImage),
                                  fit: BoxFit.cover,
                                  color: currentColor),
                            )),
                    Transform.translate(
                        offset: const Offset(0, -35),
                        child: Text(
                          title,
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            color: currentColor,
                            fontSize:
                                Fonts.xs(), // Adjust size as per your `Fonts.xs`
                          ),
                        )),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Center the icon and text vertically
                  children: [
                    hasIcon
                        ? Icon(buttonIcon, color: currentColor)
                        : Transform.translate(
                            offset: const Offset(0, -14),
                            child: Transform.scale(
                              scale: 0.43,
                              child: Image(
                                  image: AssetImage(buttonImage),
                                  fit: BoxFit.cover,
                                  color: currentColor),
                            )),
                    Text(
                      title,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        color: currentColor,
                        fontSize:
                            Fonts.xs(), // Adjust size as per your `Fonts.xs`
                      ),
                    ),
                  ],
                ),
        ));
  }
}
