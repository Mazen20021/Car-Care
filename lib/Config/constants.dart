import 'package:flutter/material.dart';

class Screen {
  static Size size = const Size(0, 0);

  static void setSize(BuildContext context) {
    size = MediaQuery.of(context).size;
  }
}

class Fonts {
  static double xs() => Screen.size.width * 0.02;
  static double x2_1s() => Screen.size.width * 0.021;
  static double x2_2s() => Screen.size.width * 0.022;
  static double x2s() => Screen.size.width * 0.023;
  static double x3s() => Screen.size.width * 0.026;
  static double sm() => Screen.size.width * 0.03;
  static double s2m() => Screen.size.width * 0.033;
  static double s3m() => Screen.size.width * 0.035;
  static double md() => Screen.size.width * 0.037;
  static double m2d() => Screen.size.width * 0.04;
  static double lg() => Screen.size.width * 0.047;
  static double xl() => Screen.size.width * 0.057;
  static double xxl() => Screen.size.width * 0.067;
}

class Width {
  static double x7s() => Screen.size.width * 0.0009;
  static double x6s() => Screen.size.width * 0.001;
  static double x5s() => Screen.size.width * 0.005;
  static double x4s() => Screen.size.width * 0.01;
  static double x3s() => Screen.size.width * 0.02;
  static double x2s() => Screen.size.width * 0.04;
  static double xs() => Screen.size.width * 0.06;
  static double xs_1() => Screen.size.width * 0.07;
  static double xs_2() => Screen.size.width * 0.08;
  static double sm() => Screen.size.width * 0.09;
  static double s2m() => Screen.size.width * 0.1;
  static double s2_1m() => Screen.size.width * 0.11;
  static double s2_2m() => Screen.size.width * 0.12;
  static double s2_3m() => Screen.size.width * 0.13;
  static double s2_4m() => Screen.size.width * 0.14;
  static double s3m() => Screen.size.width * 0.15;
  static double s4m() => Screen.size.width * 0.16;
  static double s5m() => Screen.size.width * 0.17;
  static double s5_1m() => Screen.size.width * 0.18;
  static double s5_2m() => Screen.size.width * 0.19;
  static double s6m() => Screen.size.width * 0.2;
  static double s7m() => Screen.size.width * 0.25;
  static double s8m() => Screen.size.width * 0.26;
  static double s9m() => Screen.size.width * 0.28;
  static double md() => Screen.size.width * 0.3;
  static double m2d() => Screen.size.width * 0.35;
  static double m3d() => Screen.size.width * 0.4;
  static double m4d() => Screen.size.width * 0.45;
  static double lg() => Screen.size.width * 0.5;
  static double xl() => Screen.size.width * 0.7;
  static double x2l() => Screen.size.width * 0.75;
  static double x3l() => Screen.size.width * 0.8;
  static double x4l() => Screen.size.width * 0.85;
  static double xxl() => Screen.size.width * 0.9;
  static double x2xl() => Screen.size.width * 0.95;
  static double x3xl() => Screen.size.width ;
}

class ButtonWidth {
  static double x3s() => 5;
  static double x2s() => 10;
  static double xs() => 20;
  static double s3m() => 30;
  static double s2m() => 40;
  static double sm() => 50;
  static double md() => 60;
  static double m2d() => 65;
  static double lg() => 70;
  static double l2g() => 80;
  static double l3g() => 90;
  static double l3_1g() => 95;
  static double l4g() => 100;
  static double l5g() => 110;
  static double xl() => 120;
  static double x_1l() => 125;
  static double xxl() => 130;
  static double x2l() => 140;
  static double x3l() => 150;
  static double x3_1l() => 155;
  static double x4l() => 160;
  static double x5l() => 170;
  static double x6l() => 180;
  static double x7l() => 190;
}

class ButtonHeights {
  static double x3s() => 5;
  static double x2s() => 10;
  static double xs() => 20;
  static double s3m() => 30;
  static double s2_5m() => 35;
  static double s2m() => 40;
  static double s3_1m() => 45;
  static double sm() => 50;
  static double md() => 60;
  static double lg() => 70;
  static double l2g() => 80;
  static double l3g() => 90;
  static double l4g() => 100;
}

class Height {
  static double x5s() => Screen.size.height * 0.001;
  static double x4s() => Screen.size.height * 0.005;
  static double x3s() => Screen.size.height * 0.009;
  static double x2s() => Screen.size.height * 0.03;
  static double x2_1s() => Screen.size.height * 0.04;
  static double x2_2s() => Screen.size.height * 0.05;
  static double xs() => Screen.size.height * 0.06;
  static double sm() => Screen.size.height * 0.09;
  static double s2m() => Screen.size.height * 0.1;
  static double s3m() => Screen.size.height * 0.12;
  static double s3_1m() => Screen.size.height * 0.14;
  static double s3_2m() => Screen.size.height * 0.16;
  static double s3_3m() => Screen.size.height * 0.18;
  static double s3_4m() => Screen.size.height * 0.2;
  static double s4m() => Screen.size.height * 0.25;
  static double s5m() => Screen.size.height * 0.26;
  static double s6m() => Screen.size.height * 0.27;
  static double s7m() => Screen.size.height * 0.28;
  static double s8m() => Screen.size.height * 0.29;
  static double s9m() => Screen.size.height * 0.295;
  static double md() => Screen.size.height * 0.3;
  static double m2d() => Screen.size.height * 0.35;
  static double m3d() => Screen.size.height * 0.4;
  static double m3_1d() => Screen.size.height * 0.42;
  static double m3_2d() => Screen.size.height * 0.44;
  static double m4d() => Screen.size.height * 0.45;
  static double lg() => Screen.size.height * 0.5;
  static double xl() => Screen.size.height * 0.7;
  static double xxl() => Screen.size.height * 0.9;
}

class CustomRadius {
  static double xs() => 4;
  static double sm() => 8;
  static double md() => 10;
  static double lg() => 12;
  static double xl() => 16;
  static double xxl() => 25;
}

class MainColors {
  static const Color transparent = Color(0x00000000);
  // Primary colors
  static const Color primary = Color(0xFF2A57D0);
  static const Color primaryDark = Color.fromARGB(255, 48, 70, 131);
  static const Color primarySemiLight = Color.fromARGB(255, 44, 85, 198);
  static const Color primaryLight = Color(0xFF90BFF7);
  static const Color background = Color(0xFFFCFCFC);

  // Secondary colors
  static const Color danger = Color(0xFF9C151D);
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFC9E0F);

  static const Color listBackground = Color.fromARGB(255, 12, 21, 52);
  static const Color navShadow = Color.fromARGB(255, 250, 251, 252);
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
  static const Color borderBrighter = Color.fromARGB(255, 248, 248, 248);
  static const Color borderDanger = Color(0xFFF34313);

  // redAccent
  static const Color redAccent = Color(0xFFD32F2F);
  static const Color deepPurple = Color(0xFF673AB7);
  //grey
  static const Color grey = Color(0xFFE0E0E0);
  static const Color darkGrey = Color(0x0ff2f4f8);
}
