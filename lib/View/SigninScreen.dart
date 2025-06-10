import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';

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
            SizedBox(
              height: 20.h,
            ),
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
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                    // maxLength: 10,
                    onTap: () {
                      Get.toNamed(Routenames.splashScreen);
                    },
                  ),
                )
              ],
            ),
            Divider(
              indent: 30,
              endIndent: 30,
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
                child: Text(
              'Or connect with social media',
              style: StringsConstants.signInTextStyle2,
            )),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Buttons(
                  assetImagePath: 'assets/images/Google.png',
                  title: 'Continue with Google',
                  titleStyle: StringsConstants.signInButtonStyle,
                  color: ColorsConstants.blueColor),
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: Buttons(
                assetImagePath: 'assets/images/facebook.png',
                title: 'Continue with Facebook',
                color: ColorsConstants.blueColor2,
                titleStyle: StringsConstants.signInButtonStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CountryCodeDropdown extends StatelessWidget {
  final phoneController phonecontroller = Get.put(phoneController());
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
