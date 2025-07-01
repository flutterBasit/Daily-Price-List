import 'package:daily_price_list/Resources/Components/AnimatedSearch.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/ViewModel/DropDown_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Shopscreen extends StatelessWidget {
  final DropdownController controller = Get.find<DropdownController>();
  Shopscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsConstants.whiteColor,
        body: SafeArea(
          child: Obx(() {
            return Column(
              children: [
                Image.asset(
                  'assets/images/LoginSignup.png',
                  height: 40.h,
                  width: 40.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on),
                    Text("${controller.selectedProvine.value}, "),
                    Text(controller.selectedDistrict.value)
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                AnimatedSearchBar(onChanged: (value) {})
              ],
            );
          }),
        ));
  }
}
