import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
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
      backgroundColor: ColorsConstants.whiteColor2,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: ColorsConstants.blackColor,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Enter your mobile number',
                    style: StringsConstants.numberTextStyle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Mobile Number',
                    style: StringsConstants.numberTextStyle2,
                  ),
                  Row(
                    children: [
                      CountryCodeDropdown(),
                      Expanded(
                          child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none, // No border
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide.none, // No border when enabled
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide.none, // No border when focused
                            ),
                            hintText: 'Enter your number'),
                        onChanged: numberScreen_Controller.updatePhoneNumber,
                        onTap: () => numberScreen_Controller
                            .keyboardVisible.value = true,
                      ))
                    ],
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
                return Visibility(
                    visible: numberScreen_Controller.showNextButton.value,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            numberScreen_Controller.geerateFakeOtp();
                            Get.toNamed(Routenames.verficationScreen);
                          },
                          child: CircleAvatar(
                            radius: 25.r,
                            backgroundColor: ColorsConstants.greenColor,
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: ColorsConstants.whiteColor3,
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
