import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Components/CustomDropDown.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/ViewModel/DropDown_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectlocationScreen extends StatelessWidget {
  final DropdownController controller = Get.put(DropdownController());

  SelectlocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.whiteColor2,
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
                color: ColorsConstants.blackColor,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Center(child: Image(image: AssetImage('assets/images/Map.png'))),
            SizedBox(
              height: 25.h,
            ),
            Center(
              child: Text(
                'Select Your Location',
                style: StringsConstants.selectlocationTextStyle,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Center(
              child: Text(
                "Switch on your location to stay in tune with \nwhat's happening in your area",
                style: StringsConstants.selectlocationTextStyle2,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Province'),
                    Customdropdown(
                        items: controller.provines,
                        selectedValue: controller.selectedProvine.value,
                        hint: 'Select Province',
                        onChanged: controller.selectProvince),
                    Text('Districts'),
                    Customdropdown(
                        items: controller.districts,
                        selectedValue: controller.selectedDistrict.value,
                        hint: 'Select Districts',
                        onChanged: controller.selectDistrict),
                    Text('Zones'),
                    Customdropdown(
                        items: controller.zones,
                        hint: 'Select zones',
                        selectedValue: controller.selectedZone.value,
                        onChanged: controller.selectedZone),
                  ],
                ),
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            Center(
                child: Buttons1(
              title: 'Submit',
              // color: ColorsConstants.greenColor,
              // titleStyle: StringsConstants.signInButtonStyle,
            ))
          ],
        ),
      )),
    );
  }
}
