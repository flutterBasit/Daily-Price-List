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
      child: SingleChildScrollView(
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
            //---------------SHOWING DELIVERY DETIALS-------------------
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(20.0),
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
                            style: StringsConstants.CheckoutScreenDetailsTitle,
                          ),
                          Row(
                            children: [
                              Text(
                                controller.selectDeliveryText,
                                style: StringsConstants
                                    .CheckoutScreenDetailsSubtitle,
                              ),
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
                    if (controller.showDeliveryDetails.value) ...[
                      RadioListTile(
                          title: Text("Standard Delivery (3-5 days) - \$3.99"),
                          value: DeliveryMethod.standard,
                          groupValue: controller.selectedDeliveryMethod.value,
                          onChanged: (value) =>
                              controller.selectedDeliveryMethod.value = value),
                      RadioListTile(
                          title: Text("Express Delivery (1-2 days) - \$7.99"),
                          value: DeliveryMethod.express,
                          groupValue: controller.selectedDeliveryMethod.value,
                          onChanged: (value) =>
                              controller.selectedDeliveryMethod.value = value),
                      RadioListTile(
                          title: Text("Same-Day Delivery - \$12.99"),
                          value: DeliveryMethod.sameDay,
                          groupValue: controller.selectedDeliveryMethod.value,
                          onChanged: (value) =>
                              controller.selectedDeliveryMethod.value = value),
                      RadioListTile(
                          title: Text("Pickup (free)"),
                          value: DeliveryMethod.pickup,
                          groupValue: controller.selectedDeliveryMethod.value,
                          onChanged: (value) =>
                              controller.selectedDeliveryMethod.value = value),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Delivery Cost: \$${controller.deliveryCost.toStringAsFixed(2)}')
                    ]
                  ],
                ),
              );
            }),
            Divider(
              color: ColorsConstants.whiteColor4,
              indent: 10,
              endIndent: 10,
            ),
            //--------------------SHOWING THE PAYMENT METHOD DETAILS------------------
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.showPaymentDetails.toggle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment',
                            style: StringsConstants.CheckoutScreenDetailsTitle,
                          ),
                          Row(
                            children: [
                              Text(
                                "Select Method",
                                style: StringsConstants
                                    .CheckoutScreenDetailsSubtitle,
                              ),
                              Icon(
                                  controller.showPaymentDetails.value
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_right,
                                  size: 25)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
