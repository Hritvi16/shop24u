import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

class MyColors
{
  static Color colorMain = Color(0xff909090);
  static Color colorPrimary = Color(0xffFFEB3C);
  static Color colorSecondary = Color(0xffC60102);
  static Color colorTertiary = Color(0xffFFDD00);
  static Color colorCatBg = Color(0xffFFFDE8);
  static Color colorCatBorder = Color(0xffFFB800);
  static Color colorNABg = Color(0xffFFF7B0);
  static Color colorBuyNow = Color(0xff2D2D2D);
  static Color colorAccent1 = Color(0xff00579C);
  static Color colorAccent2 = Color(0xff039400);
  static Color colorAccent3 = Color(0xffFFB950);
  static Color colorBorder = Color(0xff058FBB);
  static Color colorDelete = Color(0xffFF3535);
  static Color colorAddress = Color(0xffF5F9FF);
  static Color colorEdit = Color(0xff007EC5);
  static Color colorSuccessBG = Color(0xffF4F4F4);
  static Color listColor1 = Color(0xffFFF3E0);
  static Color listColor2 = Color(0xffF6F3EE);
  static Color gw = Color(0xff660808);
  static Color info = Color(0xffFFFFF4);
  static Color appBar = Color(0xffFEFEFE);

  // static Color colorSecondary = Color(0xff537596);
  static Color mDarkGreen = Color(0xff3B8F06);
  static Color wishlistPink = Color(0xffF4B3EA);
  static Color mGray2 = Color(0xffEFEFEF);


  static Color grey = Color(0xffBCBCBC);
  static Color grey10 = Color(0xffe6e6e6);
  static Color grey30 = Color(0xff909090);
  static Color grey60 = Color(0xff666666);
  static Color grey80 = Color(0xff37474F);
  static Color grey90 = Color(0xff263238);


  static Color red300 = Color(0xffE57373);
  static Color red500 = Color(0xffF44336);
  static Color red600 = Color(0xffd00808);
  static Color red700 = Color(0xffD32F2F);
  static Color red800 = Color(0xffC62828);


  static Color blue300 = Color(0xff64B5F6);
  static Color blue800 = Color(0xff1565C0);
  static Color blue900 = Color(0xff0D47A1);


  // static Color colorPrimaryLight = Color(0x56832343);


  static Color pink600 = Color(0xffD81B60);
  static Color pink800 = Color(0xffAD1457);


  static Color green300 = Color(0xff81C784);
  static Color green400 = Color(0xff66BB6A);
  static Color green500 = Color(0xff4CAF50);
  static Color green600 = Color(0xff43A047);
  static Color green800 = Color(0xff2E7D32);


  static Color purple500 = Color(0xff673AB7);


  static Color yellow300 = Color(0xffFFF176);
  static Color yellow800 = Color(0xffF9A825);


  static Color white = Color(0xffffffff);
  static Color black = Color(0xff000000);
  static Color black12 = Color(0x1F000000);
  static Color red = Color(0xffFF0F00);
  static Color orange = Color(0xFFFF5722);
  static Color red_d = Color(0xffFF0101);
  static Color grey_1 = Color(0xff545252);
  static Color grey_2 = Color(0xff636060);
  static Color lightGrey = Color(0xffE9E8E8);
  static Color Profile_Grey = Color(0xfffafafa);


  static Color PastelPink = Color(0xfffdd4db);
  static Color PastelOrange = Color(0xffffdfc0);
  static Color PastelGreen = Color(0xffc0eade);
  static Color PastelBlue = Color(0xffb5e2f4);
  static Color PastelPurple = Color(0xffd1d5f9);
  static Color PastelYellow = Color(0xfff9e2af);

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }
  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}