import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Checkoutbottomsheet extends StatelessWidget {
  const Checkoutbottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreen_ViewController controller =
        Get.find<HomeScreen_ViewController>();
    return Container(
      // padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: ColorsConstants.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Checkout",
                  style: StringsConstants.ShopScreen2title,
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: ColorsConstants.blackColor2,
                    ))
              ],
            ),
          ),
          Divider(
            color: ColorsConstants.whiteColor4,
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.showDeliveryDetails.toggle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery",
                          style: StringsConstants.shopeScreen2ProductDetails1,
                        ),
                        Row(
                          children: [
                            Text("Select Method"),
                            Icon(
                                controller.showDeliveryDetails.value
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_right,
                                size: 25)
                          ],
                        )
                      ],
                    ),
                  ),
                  if (controller.showDeliveryDetails.value) Center()
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
