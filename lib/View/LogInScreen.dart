import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image(
                      image: AssetImage('assets/images/LoginSignup.png'))),
              SizedBox(
                height: 55.h,
              ),
              Text(
                'Loging',
                style: Stringsconstants.loginScreenTextColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
