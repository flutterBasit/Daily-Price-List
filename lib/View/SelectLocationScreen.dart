import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Components/CustomDropDown.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:daily_price_list/ViewModel/DropDown_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectlocationScreen extends StatefulWidget {
  SelectlocationScreen({super.key});

  @override
  State<SelectlocationScreen> createState() => _SelectlocationScreenState();
}

class _SelectlocationScreenState extends State<SelectlocationScreen> {
  final DropdownController controller = Get.put(DropdownController());

  @override
  void initState() {
    super.initState();
    controller.detectAndSetLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.whiteColor2,
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
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
                    height: 15.h,
                  ),
                  Center(
                      child: Image(
                    image: AssetImage('assets/images/Map.png'),
                    height: 170.h,
                    width: 210.h,
                  )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Text(
                      'Select Your Location',
                      style: StringsConstants.selectlocationTextStyle,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Text(
                      "Switch on your location to stay in tune with \nwhat's happening in your area",
                      style: StringsConstants.selectlocationTextStyle2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Province'),
                          Customdropdown(
                              items: controller.provines,
                              selectedValue: controller.selectedProvine.value,
                              hint: 'Select Province',
                              onChanged: controller.selectProvince),
                          Text('Your District'),
                          Customdropdown(
                              items: controller.districts,
                              selectedValue: controller.selectedDistrict.value,
                              hint: 'Select District',
                              onChanged: controller.selectDistrict),
                          Text('Your Zone'),
                          Customdropdown(
                              items: controller.zones,
                              hint: 'Select zone',
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
                    color: ColorsConstants.greenColor,
                    titleStyle: StringsConstants.signInButtonStyle,
                    onTap: () {
                      if (controller.selectedProvine.value.isNotEmpty &&
                          controller.selectedDistrict.value.isNotEmpty &&
                          controller.selectedDistrict.value.isNotEmpty) {
                        Get.snackbar(
                          'Success',
                          'Moving to Log In Screen',
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        // Get.offNamed(Routenames.logInScreen);
                        Get.offNamed(Routenames.HomeScreen);
                      } else {
                        Get.snackbar(
                          'Incomplete Selection',
                          'Please select Province, District, and Zone before submitting.',
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                      }
                    },
                  ))
                ],
              ),
            ),
          ),
          //Showing loading

          Obx(() {
            return controller.isloading.value
                ? Container(
                    color: Colors.black.withOpacity(0.4),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox.shrink();
          })
        ],
      )),
    );
  }
}
