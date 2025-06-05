import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Stringsconstants {
  static const String fontStyle = "Gilroy";

  static TextStyle googleFontStyle(TextStyle baseStyle) {
    return GoogleFonts.getFont(fontStyle, textStyle: baseStyle);
  }

  static TextStyle customFontStyle(TextStyle baseStyle) {
    return baseStyle.copyWith(fontFamily: fontStyle);
  }

//SPLASH SCREEN CONSTANTS
  static TextStyle splashScreenStyle = TextStyle(
      fontFamily: fontStyle,
      fontSize: 30.sp,
      fontWeight: FontWeight.bold,
      color: ColorsConstants.whiteColor);

  static TextStyle splashScreenStyle2 = googleFontStyle(TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: ColorsConstants.whiteColor));

// ONBOADING SCREEN CONSTANTS
  static TextStyle onBoardingStyle = googleFontStyle(TextStyle(
      fontSize: 48.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.whiteColor));

  static TextStyle onBoardingStyle2 = googleFontStyle(TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: ColorsConstants.whiteColor2));

  static TextStyle onBoardingStyleButton = googleFontStyle(TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.whiteColor));

// SIGNIN SCREEN
  static TextStyle signInTextStyle = googleFontStyle(TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.blackColor));

  static TextStyle signInTextStyle2 = googleFontStyle(TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.greyColor));

  static TextStyle signInButtonStyle = googleFontStyle(TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.whiteColor2));

//NUMBER SCREEN AND VERFICATION SCREEN
  static TextStyle numberTextStyle = googleFontStyle(TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.blackColor2));

  static TextStyle numberTextStyle2 = googleFontStyle(TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.greyColor2));

// SELECT LOCATION SCREEN
  static TextStyle selectlocationTextStyle = googleFontStyle(TextStyle(
      fontSize: 23.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.blackColor2));

  static TextStyle selectlocationTextStyle2 = googleFontStyle(TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ColorsConstants.greyColor2));

//LOGING SCREEN
  static TextStyle loginScreenTextColor = googleFontStyle(TextStyle(
      fontSize: 23.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.blackColor2));
}
