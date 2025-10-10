import 'package:daily_price_list/Resources/Components/Buttons.dart';
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
      height: 800,
      decoration: BoxDecoration(
          color: ColorsConstants.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Checkout",
                    style: StringsConstants.ShopScreen2title,
                  ),
                  IconButton(
                      onPressed: () {
                        controller.Reset_CheckOut();
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
                padding: const EdgeInsets.all(14.0),
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
                padding: const EdgeInsets.all(14.0),
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
                                controller.selectPayment,
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
                    if (controller.showPaymentDetails.value) ...[
                      RadioListTile(
                          title: Text("Cash on Delivery (COD)"),
                          value: PaymentMethod.COD,
                          groupValue: controller.selectedPaymentMethod.value,
                          onChanged: (Value) =>
                              controller.selectedPaymentMethod.value = Value),
                      RadioListTile(
                          title: Text("Debit Card"),
                          value: PaymentMethod.debitCard,
                          groupValue: controller.selectedPaymentMethod.value,
                          onChanged: (Value) =>
                              controller.selectedPaymentMethod.value = Value),
                      RadioListTile(
                          title: Text("EasyPaisa"),
                          value: PaymentMethod.EasyPaisa,
                          groupValue: controller.selectedPaymentMethod.value,
                          onChanged: (Value) =>
                              controller.selectedPaymentMethod.value = Value),
                      RadioListTile(
                          title: Text("JazzCash"),
                          value: PaymentMethod.JazzCash,
                          groupValue: controller.selectedPaymentMethod.value,
                          onChanged: (Value) =>
                              controller.selectedPaymentMethod.value = Value)
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
            //-------------------SHOWING THE PROMOCODE------------------------
            Obx(() {
              return Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.showPromoCodeDetails.toggle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Promo Code",
                            style: StringsConstants.CheckoutScreenDetailsTitle,
                          ),
                          Row(
                            children: [
                              Text(
                                "Pick Discount",
                                style: StringsConstants
                                    .CheckoutScreenDetailsSubtitle,
                              ),
                              Icon(controller.showPromoCodeDetails.value
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_right)
                            ],
                          )
                        ],
                      ),
                    ),
                    if (controller.showPromoCodeDetails.value) ...[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: controller.PromoCodeController,
                            decoration: InputDecoration(
                                hintText: "Enter Promo Code",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: ColorsConstants.greenColor)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8)),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.applyPromoCode();
                            },
                            child: Text("Apply"),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ColorsConstants.greenColor)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 80,
                          ),
                          Text(
                            controller.promoMessage.value,
                            style: TextStyle(
                                color: controller.isPromoValid.value
                                    ? ColorsConstants.greenColor
                                    : Colors.red),
                          )
                        ],
                      )
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
            //----------------------------------SHOWING THE GRAND TOTAL with details---------------------
            Obx(() {
              return Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.showTotalPriceDetails.toggle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Cost",
                            style: StringsConstants.CheckoutScreenDetailsTitle,
                          ),
                          Row(
                            children: [
                              Text(
                                "\$${controller.totalWithDelivery.toStringAsFixed(2)}",
                                style: StringsConstants
                                    .CheckoutScreenDetailsSubtitle,
                              ),
                              Icon(controller.showTotalPriceDetails.value
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_right)
                            ],
                          )
                        ],
                      ),
                    ),
                    if (controller.showTotalPriceDetails.value) ...[
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.cartProductDetails.length,
                          itemBuilder: (context, index) {
                            final item = controller.cartProductDetails[index];
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${item['title']} x ${item['quantity']}"),
                                  Text(
                                    "\$${item['totalprice'].toStringAsFixed(2)}",
                                  )
                                ],
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.selectDeliveryText),
                            Text(
                                "\$${controller.deliveryCost.toStringAsFixed(2)}")
                          ],
                        ),
                      )
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
            //------------------------------Place Order Button----------------------
            Row(
              children: [
                SizedBox(
                  width: 14.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'By placing an order you agree to our ',
                      style: StringsConstants
                          .CheckoutScreenDetailsTermsAndCondition,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'Terms',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: ColorsConstants.blackColor),
                      ),
                      TextSpan(
                        text: ' And',
                        style: StringsConstants
                            .CheckoutScreenDetailsTermsAndCondition,
                      ),
                      TextSpan(
                        text: ' Conditions',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: ColorsConstants.blackColor),
                      ),
                    ])),
                  ],
                ),
              ],
            ),
            Buttons1(
              title: 'Place Order',
              onTap: () {
                controller.proceedToOrder(context);
                //  Get.back();
              },
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
