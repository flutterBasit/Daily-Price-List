import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Shopscreen2 extends StatelessWidget {
  const Shopscreen2({super.key});

  @override
  Widget build(BuildContext context) {
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
                        bottomLeft: Radius.circular(45.r),
                        bottomRight: Radius.circular(45.r))),
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
                ))
          ],
        ),
      ),
    );
  }
}
