import 'package:flutter/material.dart';

class Screen {
  static var size;
  static void setSize(BuildContext context) =>
      size = MediaQuery.of(context).size;
}

class Fonts {
  static double xs() => Screen.size.width * 0.02;
  static double cmd() => Screen.size.width * 0.08;
  static double sm() => Screen.size.width * 0.05;
  static double md() => Screen.size.width * 0.07;
  static double lg() => Screen.size.width * 0.1;
  static double xl() => Screen.size.width * 0.12;
  static double xxl() => Screen.size.width * 0.15;
}

class Sizes {
  static double xs() => Screen.size.width * 0.06;
  static double sm() => Screen.size.width * 0.09;
  static double md() => Screen.size.width * 0.3;
  static double lg() => Screen.size.width * 0.5;
  static double xl() => Screen.size.width * 0.7;
  static double xxl() => Screen.size.width * 0.9;
  static double bHeight = 62;
}

class Height {
  static double xs() => Screen.size.height * 0.06;
  static double sm() => Screen.size.height * 0.09;
  static double md() => Screen.size.height * 0.3;
  static double lg() => Screen.size.height * 0.5;
  static double xl() => Screen.size.height * 0.7;
  static double xxl() => Screen.size.height * 0.9;
}

class CustomRadius {
  static double xs = 4;
  static double sm = 8;
  static double md = 10;
  static double lg = 12;
  static double xl = 16;
  static double xxl = 25;
}

class MainColors {
  // Primary colors
  static const Color primary = Color(0xFF2A57D0);
  static const Color primaryLight = Color(0xFF90BFF7);
  static const Color background = Color(0xFFFCFCFC);

  // Secondary colors
  static const Color danger = Color(0xFF9C151D);
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFC9E0F);

  // Neutral colors
  static const Color black = Color(0xFF0C1534);
  static const Color white = Color(0xFFFCFCFC);

  // Text colors
  static const Color textBlack = Color(0xFF000000);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF2A57D0);
}
