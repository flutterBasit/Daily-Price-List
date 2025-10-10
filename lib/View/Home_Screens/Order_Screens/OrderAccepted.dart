import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderacceptedScreen extends StatelessWidget {
  const OrderacceptedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80.h,
          ),
          Center(child: Image.asset('assets/images/OrderAccepted.png')),
          SizedBox(
            height: 40.h,
          ),
          Text(
            'Your Order has been\naccepted',
            style: StringsConstants.OrderAcceptedScreenTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "your items has been placed and is on\nit's way to being processed",
            style: StringsConstants.OrderAcceptedScreenTitle2,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 90.h,
          ),
          Buttons1(
            title: 'Track Order',
            color: ColorsConstants.greenColor,
            onTap: () {},
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
    );
  }
}
