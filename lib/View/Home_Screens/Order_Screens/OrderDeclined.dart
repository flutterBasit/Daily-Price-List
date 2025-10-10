import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showOrderDeclinedScreen(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true, //tapping outside will close
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close)),
                ),
                Image.asset(
                  "assets/images/orderDeclined.png",
                  height: 190.h,
                  width: 190.w,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'Oops! Order Failed',
                  style: StringsConstants.OrderAcceptedScreenTitle,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Something went terrible wrong',
                  style: StringsConstants.OrderAcceptedScreenTitle2,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Buttons1(
                  title: "Please Try Again",
                  color: ColorsConstants.greenColor,
                ),
                Ink(
                  width: 320.w,
                  height: 67.h,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(19.r),
                  ),
                  child: InkWell(
                    onTap: () {
                      //  Get.back();
                      Get.offAllNamed(Routenames.HomeScreen);
                    },
                    borderRadius: BorderRadius.circular(19.r),
                    splashColor: Colors.green.withOpacity(0.3),
                    highlightColor: Colors.green.withOpacity(0.1),
                    child: Center(
                      child: Text(
                        'Back to home',
                        style: StringsConstants.OrderAcceptedBackhomeButton,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
