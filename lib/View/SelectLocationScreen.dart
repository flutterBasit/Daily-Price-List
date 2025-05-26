import 'package:daily_price_list/Resources/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectlocationScreen extends StatelessWidget {
  const SelectlocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor2,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios,
                color: Constants.blackColor,
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Center(child: Image(image: AssetImage('assets/images/Map.png'))),
            SizedBox(
              height: 30.h,
            ),
            Center(
              child: Text(
                'Select Your Location',
                style: Constants.selectlocationTextStyle,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Text(
                "Switch on your location to stay in tune with what's happening in your area",
                style: Constants.selectlocationTextStyle2,
              ),
            )
          ],
        ),
      )),
    );
  }
}
