import 'package:carcare/Config/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double leftPadding;
  final double rightPadding;
  final double topPadding;
  final double bottomPadding;
  final List<Color>? gradientColors;
  final bool hasGradient;
  final bool hasImage;
  final Color normalColor;
  final String imagePath;
  final double imageOpacity;
  final Alignment begin;
  final Alignment end;
  final String label;
  final double? fontSize;
  final Color textColor;
  final VoidCallback? onPressed;
  final bool hasIcon;
  final IconData buttonIcon;
  final double iconSize;
  final Color iconColor;
  const CustomButton({
    super.key,
    this.width = 0,
    this.height = 0,
    this.borderRadius = 0,
    this.leftPadding = 0,
    this.rightPadding = 0,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.gradientColors,
    this.normalColor = MainColors.transparent,
    this.hasGradient = false,
    this.hasImage = false,
    this.imagePath = "",
    this.imageOpacity = 1,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    this.label = "",
    this.fontSize,
    this.textColor = MainColors.textWhite,
    this.hasIcon = false,
    this.buttonIcon = Icons.close_rounded,
    this.iconColor = Colors.white,
    this.iconSize = 0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              leftPadding, topPadding, rightPadding, bottomPadding),
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
                      colors: gradientColors?.toList() ?? [],
                      begin: begin,
                      end: end,
                    )
                  : null,
            ),
            color: hasGradient ? null : normalColor,
            alignment: Alignment.center,
            child:
            !hasIcon?
            Text(
              label,
              style: GoogleFonts.rubik(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              )):
              Transform.translate(offset: const Offset(-11, -10),child: Icon(buttonIcon,size: iconSize,color: iconColor)),
            ),
          ),
        );
  }
}
