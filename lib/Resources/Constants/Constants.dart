import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static const Color greenColor = Color(0xff53B175);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color whiteColor2 = Color(0xffFCFCFC);
  static const Color whiteColor3 = Color(0xffFFF9FF);
  static const Color blackColor = Color(0xff030303);
  static const Color blackColor2 = Color(0xff181725);
  static const Color blueColor = Color(0xff5383EC);
  static const Color greyColor = Color(0xff828282);
  static const Color greyColor2 = Color(0xff7C7C7C);
  static const Color blueColor2 = Color(0xff4A66AC);

  static const String fontStyle = "Montserrat";

  static TextStyle googleFontStyle(TextStyle baseStyle) {
    return GoogleFonts.getFont(fontStyle, textStyle: baseStyle);
  }

//SPLASH SCREEN CONSTANTS
  static TextStyle splashScreenStyle = googleFontStyle(TextStyle(
      fontSize: 30.sp, fontWeight: FontWeight.bold, color: whiteColor));

  static TextStyle splashScreenStyle2 = googleFontStyle(TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.w500, color: whiteColor));

// ONBOADING SCREEN CONSTANTS
  static TextStyle onBoardingStyle = googleFontStyle(TextStyle(
      fontSize: 48.sp, fontWeight: FontWeight.w600, color: whiteColor));

  static TextStyle onBoardingStyle2 = googleFontStyle(TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w400, color: whiteColor2));

  static TextStyle onBoardingStyleButton = googleFontStyle(TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w600, color: whiteColor));

// SIGNIN SCREEN
  static TextStyle signInTextStyle = googleFontStyle(TextStyle(
      fontSize: 26.sp, fontWeight: FontWeight.w600, color: blackColor));

  static TextStyle signInTextStyle2 = googleFontStyle(TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.w600, color: greyColor));

  static TextStyle signInButtonStyle = googleFontStyle(TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w600, color: whiteColor2));

//NUMBER SCREEN AND VERFICATION SCREEN
  static TextStyle numberTextStyle = googleFontStyle(TextStyle(
      fontSize: 22.sp, fontWeight: FontWeight.w600, color: blackColor2));

  static TextStyle numberTextStyle2 = googleFontStyle(TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w600, color: greyColor2));
}
