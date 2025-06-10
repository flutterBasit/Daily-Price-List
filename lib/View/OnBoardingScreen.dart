import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/onBoarding.png'),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            // top: 100,
            bottom: 50.h,
            left: 30.5.w,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Icon.png',
                  height: 56.36.h,
                  width: 48.47.w,
                ),
                Text(
                  "Welcome\nto our app",
                  style: StringsConstants.onBoardingStyle,
                ),
                Text(
                  'Track Daily Prices, Save Smartly!',
                  style: StringsConstants.onBoardingStyle2,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Buttons(
                  title: 'Get Started',
                  color: ColorsConstants.greenColor,
                  titleStyle: StringsConstants.onBoardingStyleButton,
                  onTap: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
