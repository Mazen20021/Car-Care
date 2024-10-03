import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonClass extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double leftPadding;
  final double rightPadding;
  final double topPadding;
  final double bottomPadding;
  final List<Color> gradientColors;
  final bool hasGradient;
  final bool hasImage;
  final Color normalColor;
  final String imagePath;
  final double imageOpacity;
  final Alignment begin;
  final Alignment end;
  final String label;
  final double fontSize;
  final Color textColor;
  final VoidCallback onPressed;

  ButtonClass({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.leftPadding,
    required this.rightPadding,
    required this.topPadding,
    required this.bottomPadding,
    required this.gradientColors,
    required this.normalColor,
    required this.hasGradient,
    required this.hasImage,
    required this.imagePath,
    required this.imageOpacity,
    required this.begin,
    required this.end,
    required this.label,
    required this.fontSize,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onPressed,
      child: Padding(padding:EdgeInsets.fromLTRB(leftPadding,topPadding,rightPadding,bottomPadding),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: width,
          height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: hasImage
              ? DecorationImage(
            image: AssetImage(imagePath),
            opacity: imageOpacity,
            fit: BoxFit.cover,
          )
              : null,
          gradient: hasGradient
              ? LinearGradient(
            colors: gradientColors,
            begin: begin,
            end: end,
          )
              : null,
        ),
        color: hasGradient? null: normalColor,
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.rubik(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
