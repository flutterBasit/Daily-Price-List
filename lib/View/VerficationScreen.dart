import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';

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
                    'Enter your 4-digit code',
                    style: StringsConstants.numberTextStyle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Code',
                    style: StringsConstants.numberTextStyle2,
                  ),
                  //  CountryCodeDropdown(),
                  TextField(
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
                          hintText: ' - - - -'),
                      onChanged: numberScreen_Controller.updateEnteredOTP,
                      onTap: () {
                        numberScreen_Controller.keyboardVisible.value = true;
                      }),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                  ),
                ],
              ),
              // this makes everything to the end to the bottom
              Expanded(child: Container()),
              Obx(() {
                return Visibility(
                    visible:
                        numberScreen_Controller.enteredOpt.value.length == 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Resend Code',
                              style: TextStyle(
                                color: ColorsConstants.greenColor,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                if (numberScreen_Controller.verfitynumber()) {
                                  Get.snackbar(
                                    'Success',
                                    'OTP verified ✅',
                                    backgroundColor: ColorsConstants.greenColor,
                                    colorText: Colors.white,
                                  );
                                  Get.offNamed(Routenames.selectlocationScreen);
                                } else {
                                  Get.snackbar(
                                    'Error',
                                    'Invalid OTP or network issue ❌',
                                    backgroundColor: Colors.redAccent,
                                    colorText: Colors.white,
                                  );
                                }
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
                        )
                      ],
                    ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
