import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              //-----------Container for Showing IMAGE of Selected Category---------------------
              Container(
                height: 320.h,
                decoration: BoxDecoration(
                    color: ColorsConstants.whiteColor5,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35.r),
                        bottomRight: Radius.circular(35.r))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.offNamed(Routenames.ShopScreen);
                              controller.showDetails.value = false;
                              controller.showCategoryDetails.value = false;
                              controller.showReviewDetails.value = false;
                            },
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
                        height: 230.h,
                        width: 329.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),

              //-----------------SHOWING PRODUCT NAME TILE AND PRICE
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
                        IconButton(onPressed: () {
                          controller.toggleFavourite(product['id']);
                        }, icon: Obx(() {
                          return Icon(
                            controller.isFavourite(product['id'])
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.isFavourite(product['id'])
                                ? Colors.red
                                : Colors.grey,
                          );
                        }))
                      ],
                    ),
                    Text(
                      product['tags'].join(', '),
                      style: StringsConstants.shopExclusivesubtitle,
                    ),
                    Text(product['availabilityStatus'],
                        style: StringsConstants.shopExclusivesubtitle),
                    SizedBox(
                      height: 15.h,
                    ),

                    //----------------SHOWING INCREMENT DECREMENT AND PRICE----------------
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
                                    child: Text(
                                  controller.count.value.toString(),
                                  style: StringsConstants.shopScreen2counter,
                                ));
                              }),
                            ),
                            IconButton(
                                onPressed: () {
                                  controller.increment();
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: ColorsConstants.greenColor,
                                )),
                          ],
                        ),
                        Text("\$${product['price']}",
                            style: StringsConstants.ShopScreen2title),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Divider(
                      color: ColorsConstants.whiteColor4,
                    ),

                    //---------------------SHOWING PRODUCT DETAILS-----------------------
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.showDetails.toggle();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Product Detail",
                                    style: StringsConstants
                                        .shopeScreen2ProductDetails1,
                                  ),
                                  Icon(
                                    controller.showDetails.value
                                        ? Icons.keyboard_arrow_down
                                        : Icons.keyboard_arrow_right,
                                    size: 25,
                                  )
                                ],
                              ),
                            ),
                            if (controller.showDetails.value)
                              Text(product['description'])
                          ],
                        ),
                      );
                    }),
                    Divider(
                      color: ColorsConstants.whiteColor4,
                    ),
                    //---------------------SHOWING PRODUCT CATEGORY DETAILS------------------------------
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.showCategoryDetails.toggle();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Product Category Detail",
                                    style: StringsConstants
                                        .shopeScreen2ProductDetails1,
                                  ),
                                  Row(
                                    children: [
                                      Text(product['tags'].join(', ')),
                                      Icon(
                                        controller.showCategoryDetails.value
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_right,
                                        size: 25,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            if (controller.showCategoryDetails.value)
                              Row(
                                children: [
                                  Text("${product['category']} "),
                                  Text(product['shippingInformation'])
                                ],
                              )
                          ],
                        ),
                      );
                    }),
                    //---------------------SHOWING PRODUCT REVIEW DETAILS------------------------------
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
                                controller.showReviewDetails.toggle();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Review",
                                    style: StringsConstants
                                        .shopeScreen2ProductDetails1,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: List.generate(
                                            5,
                                            (i) => Icon(
                                                  Icons.star,
                                                  color: ColorsConstants
                                                      .AmberColor,
                                                  size: 18,
                                                )),
                                      ),
                                      Icon(
                                        controller.showReviewDetails.value
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_right,
                                        size: 25,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            if (controller.showReviewDetails.value)
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: product['reviews'].length,
                                  itemBuilder: (context, index) {
                                    final review = product['reviews'][index];

                                    return ListTile(
                                      title: Text(review['reviewerName']),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(review['comment']),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Row(
                                            children: List.generate(
                                                5,
                                                (i) => Icon(
                                                      i < review['rating']
                                                          ? Icons.star
                                                          : Icons.star_border,
                                                      color: ColorsConstants
                                                          .AmberColor,
                                                      size: 18,
                                                    )),
                                          )
                                        ],
                                      ),
                                    );
                                  })
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.w),
        child: Buttons1(
          title: 'Add To Basket',
          titleStyle: StringsConstants.shopScreen2Button,
          color: ColorsConstants.greenColor,
        ),
      ),
    );
  }
}
