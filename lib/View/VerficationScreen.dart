import 'package:daily_price_list/Resources/Constants/Constants.dart';
import 'package:daily_price_list/View/SigninScreen.dart';
import 'package:daily_price_list/ViewModel/NumberScreen_ViewModel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerficationScreen extends StatelessWidget {
  final NumberScreen_Controller numberScreen_Controller =
      Get.put(NumberScreen_Controller());
  VerficationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteColor2,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            children: [
              Column(
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
                  Text(
                    'Enter your 4-digit code',
                    style: Constants.numberTextStyle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Code',
                    style: Constants.numberTextStyle2,
                  ),
                  //  CountryCodeDropdown(),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: '- - - -'),
                    onChanged: numberScreen_Controller.updatePhoneNumber,
                    onTap: () =>
                        numberScreen_Controller.keyboardVisible.value = true,
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              ),
              // this makes everything to the end to the bottom
              Expanded(child: Container()),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Resend Code',
                        style: TextStyle(
                          color: Constants.greenColor,
                        )),
                    Visibility(
                        visible: numberScreen_Controller.showNextButton.value,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 25.r,
                                backgroundColor: Constants.greenColor,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Constants.whiteColor3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
