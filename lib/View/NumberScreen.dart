import 'package:daily_price_list/Resources/Constants/Constants.dart';
import 'package:daily_price_list/View/SigninScreen.dart';
import 'package:daily_price_list/ViewModel/NumberScreen_ViewModel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Numberscreen extends StatelessWidget {
  final NumberScreen_Controller numberScreen_Controller =
      Get.put(NumberScreen_Controller());
  Numberscreen({super.key});

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
                    'Enter your mobile number',
                    style: Constants.numberTextStyle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Mobile Number',
                    style: Constants.numberTextStyle2,
                  ),
                  Row(
                    children: [
                      CountryCodeDropdown(),
                      Expanded(
                          child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'Enter your number'),
                        onChanged: numberScreen_Controller.updatePhoneNumber,
                        onTap: () => numberScreen_Controller
                            .keyboardVisible.value = true,
                      ))
                    ],
                  ),
                  Divider(
                    indent: 30,
                    endIndent: 30,
                  ),
                ],
              ),
              // this makes everything to the end to the bottom
              Expanded(child: Container()),
              Obx(() {
                return Visibility(
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
                    ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
