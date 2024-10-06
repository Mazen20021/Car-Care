import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Config/constants.dart';

class BottomButtonsClass extends StatelessWidget {

  final double width;
  final double height;
  final IconData buttonIcon;
  final String title;
  final Color currentColor;
  final Color currentBorderColor;
  final VoidCallback onPressed;
  const BottomButtonsClass({required this.width , required this.height , required this.buttonIcon, required this.currentColor, required this.currentBorderColor , required this.title,required this.onPressed , super.key});
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
       boxShadow: [BoxShadow(
         color: Colors.black.withOpacity(0.2), // Shadow color
         spreadRadius: 2,
         blurRadius: 6,
         offset: const Offset(0, 2), // Shadow direction: towards the top
       ),],// Assuming you replace MainColors.primary with actual color
     ),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center, // Center the icon and text vertically
       children: [
         Icon(buttonIcon, color: currentColor),
         Text(
           title,
           style: GoogleFonts.rubik(
             fontWeight: FontWeight.bold,
             color: currentColor,
             fontSize: Fonts.x3s(), // Adjust size as per your `Fonts.x2s()`
           ),
         ),
       ],
     ),
   ));
  }

}

