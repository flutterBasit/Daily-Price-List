import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Shopscreen2 extends StatelessWidget {
  const Shopscreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreen_ViewController controller =
        Get.put(HomeScreen_ViewController());
    final product = Get.arguments as Map<String, dynamic>;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 372.h,
              decoration: BoxDecoration(
                  color: ColorsConstants.whiteColor5,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35.r),
                      bottomRight: Radius.circular(35.r))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: ColorsConstants.blackColor,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.ios_share,
                              color: ColorsConstants.blackColor,
                            ))
                      ],
                    ),
                  ),
                  Center(
                    child: Image.network(
                      product['images'][0],
                      height: 250.h,
                      width: 329.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(22.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product['title'],
                        style: StringsConstants.ShopScreen2title,
                      ),
                      Icon(Icons.favorite)
                    ],
                  ),
                  Text(
                    product['tags'].join(', '),
                    style: StringsConstants.shopExclusivesubtitle,
                  ),
                  Text(product['availabilityStatus'],
                      style: StringsConstants.shopExclusivesubtitle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                controller.decrement();
                              },
                              icon: Icon(Icons.remove)),
                          Container(
                            height: 46.h,
                            width: 46.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17.r),
                                border: Border.all(
                                    width: 1.5,
                                    color: ColorsConstants.whiteColor4)),
                            child: Obx(() {
                              return Center(
                                  child:
                                      Text(controller.count.value.toString()));
                            }),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.increment();
                              },
                              icon: Icon(Icons.add)),
                        ],
                      ),
                      Text("\$${product['price']}",
                          style: StringsConstants.shopExclusivePrice),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
