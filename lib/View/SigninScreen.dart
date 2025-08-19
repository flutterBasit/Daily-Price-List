import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:daily_price_list/ViewModel/AuthViewModel/AuthViewModel.dart';
import 'package:daily_price_list/ViewModel/NumberScreen_ViewModel.dart';

import 'package:daily_price_list/ViewModel/phone_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Signinscreen extends StatefulWidget {
  const Signinscreen({super.key});

  @override
  State<Signinscreen> createState() => _SigninscreenState();
}

class _SigninscreenState extends State<Signinscreen> {
  final Authviewmodel auth = Get.put(Authviewmodel());

  final phoneAuthController PhoneAuthController =
      Get.put(phoneAuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.whiteColor2,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage('assets/images/Signin.png')),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Dive into Daily Price \nof K.P.K',
                style: StringsConstants.signInTextStyle,
              ),
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
                        borderSide: BorderSide.none, // No border when enabled
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none, // No border when focused
                      ),
                      hintText: 'Enter your phone number'),
                  onChanged: PhoneAuthController.updatePhoneNumber,
                ))
              ],
            ),
            Divider(
              indent: 30,
              endIndent: 30,
            ),
            Obx(() {
              return Visibility(
                  visible: PhoneAuthController.showNextButton.value,
                  child: InkWell(
                      onTap: () {
                        //  numberScreen_Controller.geerateFakeOtp();
                        auth.startPhoneAuth(
                            PhoneAuthController.fullPhoneNumber);
                        Get.toNamed(Routenames.verficationScreen);
                      },
                      child: Center(
                        child: Buttons1(
                          title: "Submit",
                          color: ColorsConstants.greenColor,
                        ),
                      )));
            }),
            Center(
                child: Text(
              'Or connect with social media',
              style: StringsConstants.signInTextStyle2,
            )),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Buttons1(
                assetImagePath: 'assets/images/Google.png',
                title: 'Continue with Google',
                titleStyle: StringsConstants.signInButtonStyle,
                color: ColorsConstants.blueColor,
                onTap: () {
                  auth.signInWithGoogle();
                },
              ),
            ),
            Center(
              child: Buttons1(
                assetImagePath: 'assets/images/facebook.png',
                title: 'Continue with Facebook',
                color: ColorsConstants.blueColor2,
                titleStyle: StringsConstants.signInButtonStyle,
                onTap: () {
                  auth.signInWIthFacebook();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CountryCodeDropdown extends StatelessWidget {
  final phoneAuthController phonecontroller = Get.put(phoneAuthController());
  CountryCodeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CountryPickerDropdown(
          initialValue: phonecontroller.selectedCountry.value.isoCode,
          itemBuilder: _buildDropDown,
          itemFilter: (c) => ['AR', 'DE', 'PK', 'GB', 'CN'].contains(c.isoCode),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('PK'),
            CountryPickerUtils.getCountryByIsoCode('AG'),
            CountryPickerUtils.getCountryByIsoCode('IN')
          ],
          sortComparator: (a, b) => a.isoCode.compareTo(b.isoCode),
          onValuePicked: phonecontroller.updateCountry);
    });
  }
}

Widget _buildDropDown(Country country) => Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 5.w,
          ),
          Text(' +${country.phoneCode}'),
        ],
      ),
    );
