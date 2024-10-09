import 'package:flutter/material.dart';

class Screen {
  static late Size size;
  static void setSize(BuildContext context) =>
      size = MediaQuery.of(context).size;
}

class Fonts {
  static double xs = Screen.size.width * 0.02;
  static double sm = Screen.size.width * 0.03;
  static double md = Screen.size.width * 0.037;
  static double lg = Screen.size.width * 0.047;
  static double xl = Screen.size.width * 0.057;
  static double xxl = Screen.size.width * 0.067;
}

class Width {
  static double xs = Screen.size.width * 0.06;
  static double sm() => Screen.size.width * 0.09;
  static double md() => Screen.size.width * 0.3;
  static double lg() => Screen.size.width * 0.5;
  static double xl = Screen.size.width * 0.7;
  static double xxl = Screen.size.width * 0.9;
  static double bHeight = 62;
}

class Height {
  static double xs = Screen.size.height * 0.06;
  static double sm() => Screen.size.height * 0.09;
  static double md() => Screen.size.height * 0.3;
  static double lg() => Screen.size.height * 0.5;
  static double xl = Screen.size.height * 0.7;
  static double xxl = Screen.size.height * 0.9;
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
  static const Color transparent = Color(0x00000000);
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

  // Border colors
  static const Color border = Color(0xFFE5E5E5);
  static const Color borderDark = Color(0xFFD1D1D1);
  static const Color borderLight = Color(0xFFEDEDED);
  static const Color borderDanger = Color(0xFFF34313);

  // redAccent
  static const Color redAccent = Color(0xFFD32F2F);
  static const Color deepPurple = Color(0xFF673AB7);
  //grey
  static const Color grey = Color(0xFFE0E0E0);
}
