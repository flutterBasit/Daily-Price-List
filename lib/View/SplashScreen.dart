import 'dart:math';

import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteManager.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:daily_price_list/ViewModel/AuthViewModel/AuthViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
//adding delay as its splash scren after few seconds it will move to next screen and this
//screen will not be in stack as we have used Get.offNamed
    Future.delayed(Duration(seconds: 3 + Random().nextInt(2)), () async {
      final initialRoute = await RouteManager.getInitialRoutes();
      // Authviewmodel.to.checkAuthAndNavigate();
      Get.offAllNamed(initialRoute);
    });

    return Scaffold(
      backgroundColor: ColorsConstants.greenColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Icon.png'),
              SizedBox(
                width: 12.w,
              ),
              Column(
                children: [
                  Text(
                    'Daily Price List',
                    style: StringsConstants.splashScreenStyle,
                  ),
                  Text(
                    "Online         Market           Rates",
                    style: StringsConstants.splashScreenStyle2,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
