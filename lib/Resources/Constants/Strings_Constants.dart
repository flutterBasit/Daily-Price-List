// import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Stringsconstants {
//   static const String fontStyle = "Gilroy";

//   static TextStyle googleFontStyle(TextStyle baseStyle) {
//     return GoogleFonts.getFont(fontStyle, textStyle: baseStyle);
//   }

//   static TextStyle customFontStyle(TextStyle baseStyle) {
//     return baseStyle.copyWith(fontFamily: 'Gilroy');
//   }

// //SPLASH SCREEN CONSTANTS
//   static TextStyle splashScreenStyle = TextStyle(
//       fontFamily: fontStyle,
//       fontSize: 30.sp,
//       fontWeight: FontWeight.bold,
//       color: ColorsConstants.whiteColor);

//   static TextStyle splashScreenStyle2 = googleFontStyle(TextStyle(
//       fontSize: 12.sp,
//       fontWeight: FontWeight.w500,
//       color: ColorsConstants.whiteColor));

// // ONBOADING SCREEN CONSTANTS
//   static TextStyle onBoardingStyle = googleFontStyle(TextStyle(
//       fontSize: 48.sp,
//       fontWeight: FontWeight.w600,
//       color: ColorsConstants.whiteColor));

//   static TextStyle onBoardingStyle2 = googleFontStyle(TextStyle(
//       fontSize: 16.sp,
//       fontWeight: FontWeight.w400,
//       color: ColorsConstants.whiteColor2));

//   static TextStyle onBoardingStyleButton = googleFontStyle(TextStyle(
//       fontSize: 18.sp,
//       fontWeight: FontWeight.w600,
//       color: ColorsConstants.whiteColor));

// // SIGNIN SCREEN
//   static TextStyle signInTextStyle = googleFontStyle(TextStyle(
//       fontSize: 26.sp,
//       fontWeight: FontWeight.w600,
//       color: ColorsConstants.blackColor));

//   static TextStyle signInTextStyle2 = googleFontStyle(TextStyle(
//       fontSize: 12.sp,
//       fontWeight: FontWeight.w600,
//       color: ColorsConstants.greyColor));

//   static TextStyle signInButtonStyle = googleFontStyle(TextStyle(
//       fontSize: 16.sp,
//       fontWeight: FontWeight.w600,
//       color: ColorsConstants.whiteColor2));

// //NUMBER SCREEN AND VERFICATION SCREEN
//   static TextStyle numberTextStyle = googleFontStyle(TextStyle(
//       fontSize: 22.sp,
//       fontWeight: FontWeight.w600,
//       color: ColorsConstants.blackColor2));

//   static TextStyle numberTextStyle2 = googleFontStyle(TextStyle(
//       fontSize: 16.sp,
//       fontWeight: FontWeight.w600,
//       color: ColorsConstants.greyColor2));

// // SELECT LOCATION SCREEN
//   static TextStyle selectlocationTextStyle = googleFontStyle(TextStyle(
//       fontSize: 23.sp,
//       fontWeight: FontWeight.w600,
//       color: ColorsConstants.blackColor2));

//   static TextStyle selectlocationTextStyle2 = googleFontStyle(TextStyle(
//       fontSize: 14.sp,
//       fontWeight: FontWeight.w400,
//       color: ColorsConstants.greyColor2));

// //LOGING SCREEN
//   static TextStyle loginScreenTextColor = googleFontStyle(TextStyle(
//       fontSize: 23.sp,
//       fontWeight: FontWeight.w600,
//       color: ColorsConstants.blackColor2));
// }

import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StringsConstants {
  static const String fontStyle = "Gilroy";

  static TextStyle customFontStyle(
      {double fontSize = 14,
      FontWeight fontWeight = FontWeight.w400,
      Color color = Colors.black,
      double letterSpacing = 0}) {
    return TextStyle(
      letterSpacing: letterSpacing,
      fontFamily: fontStyle,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // SPLASH SCREEN
  static TextStyle splashScreenStyle = customFontStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    color: ColorsConstants.whiteColor,
  );

  static TextStyle splashScreenStyle2 = customFontStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: ColorsConstants.whiteColor,
  );

  // ONBOARDING SCREEN
  static TextStyle onBoardingStyle = customFontStyle(
    fontSize: 46.sp,
    fontWeight: FontWeight.w600,
    color: ColorsConstants.whiteColor,
  );

  static TextStyle onBoardingStyle2 = customFontStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorsConstants.whiteColor2,
  );

  static TextStyle onBoardingStyleButton = customFontStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: ColorsConstants.whiteColor,
  );

  // SIGN IN SCREEN
  static TextStyle signInTextStyle = customFontStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: ColorsConstants.blackColor,
  );

  static TextStyle signInTextStyle2 = customFontStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: ColorsConstants.greyColor,
  );

  static TextStyle signInButtonStyle = customFontStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: ColorsConstants.whiteColor2,
  );

  // NUMBER SCREEN
  static TextStyle numberTextStyle = customFontStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: ColorsConstants.blackColor2,
  );

  static TextStyle numberTextStyle2 = customFontStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: ColorsConstants.greyColor2,
  );

  // LOCATION SCREEN
  static TextStyle selectlocationTextStyle = customFontStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: ColorsConstants.blackColor2,
  );

  static TextStyle selectlocationTextStyle2 = customFontStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorsConstants.greyColor2,
  );

  // LOGIN SCREEN and SIGNUP SCREEN
  static TextStyle loginScreenTextStyle = customFontStyle(
    fontSize: 23.sp,
    fontWeight: FontWeight.w600,
    color: ColorsConstants.blackColor2,
  );

  static TextStyle loginScreenTextStyle2 = customFontStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ColorsConstants.greyColor2);

  static TextStyle customTextFieldLabelStyle = customFontStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.greyColor2);

  static TextStyle customTextFieldHintStyle = customFontStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: ColorsConstants.blackColor);

  static TextStyle loginScreenTextStyle3 = customFontStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.blackColor2);

  static TextStyle loginScreenTextStyle4 = customFontStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.greenColor);

  static TextStyle signupScreenTextStyle = customFontStyle(
      letterSpacing: 1.sp,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: ColorsConstants.blackColor);

  static TextStyle signupScreenTextStyle2 = customFontStyle(
      fontSize: 12.sp,
      letterSpacing: 1.sp,
      fontWeight: FontWeight.w400,
      color: ColorsConstants.greenColor);

  // HOME SCREEN ---- SHOP SCREEN
  static TextStyle shopScreenTextColor = customFontStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.blackColor3);

  static TextStyle shopSearchTextField = customFontStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.greyColor2);

  static TextStyle shopcarouseltitle1 = customFontStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: ColorsConstants.blackColor);

  static TextStyle shopcarouseltitle2 = customFontStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      color: ColorsConstants.greenColor);

  static TextStyle shopTitle1a = customFontStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.blackColor2);

  static TextStyle shopTitle1b = customFontStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.greenColor);

  static TextStyle shopExclusiveTitle = customFontStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      color: ColorsConstants.blackColor2);

  static TextStyle shopExclusivesubtitle = customFontStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: ColorsConstants.greyColor2);

  static TextStyle shopExclusivePrice = customFontStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.blackColor2);

  static TextStyle shopGroceriesTitle = customFontStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.blackColor4);

  // HOME SCREEN ---- SHOP SCREEN2

  static TextStyle ShopScreen2title = customFontStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: ColorsConstants.blackColor2);
}
