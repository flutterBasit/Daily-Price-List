import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:daily_price_list/ViewModel/DropDown_ViewModel.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shopscreen extends StatelessWidget {
  // final DropdownController controller = Get.put(DropdownController());
  final DropdownController controller = Get.find<DropdownController>();
  final HomeScreen_ViewController controller2 =
      Get.put(HomeScreen_ViewController());

  //defining the List of colors of containers for groceries
  final List<Color> containerColor = [
    Color(0xffF8A44C),
    Color(0xff53B175),
    Color(0xffF7A593),
    Color(0xffD3B0E0),
    Color(0xffFDE598),
    Color(0xffB7Dff5)
  ];
  Shopscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load saved location when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      controller.selectedProvine.value = prefs.getString('savedProvince') ?? '';
      controller.selectedDistrict.value =
          prefs.getString('savedDistrict') ?? '';
      controller.selectedZone.value = prefs.getString('savedZone') ?? '';
      // Print to verify loaded values
      print(
          'Loaded location: ${controller.selectedProvine.value}, ${controller.selectedDistrict.value}');
    });
    return Scaffold(
        backgroundColor: ColorsConstants.whiteColor,
        body: SafeArea(
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset('assets/images/LoginSignup.png',
                        height: 30.h, width: 30.w),
                    SizedBox(
                      height: 10.h,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Icon(
                    //       Icons.location_on,
                    //       color: ColorsConstants.blackColor3,
                    //     ),
                    //     Text(
                    //       "${controller.selectedProvine.value}, ",
                    //       style: StringsConstants.shopScreenTextColor,
                    //     ),
                    //     Text(controller.selectedDistrict.value,
                    //         style: StringsConstants.shopScreenTextColor)
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on,
                            color: ColorsConstants.blackColor3),
                        if (controller.selectedProvine.value.isNotEmpty)
                          Text(
                            "${controller.selectedProvine.value}, ",
                            style: StringsConstants.shopScreenTextColor,
                          ),
                        if (controller.selectedDistrict.value.isNotEmpty)
                          Text(
                            controller.selectedDistrict.value,
                            style: StringsConstants.shopScreenTextColor,
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Store',
                          hintStyle: StringsConstants.shopSearchTextField,
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    // promotional banner using the cauresol package
                    Obx(() {
                      if (controller2.isLoading.value) {
                        return SizedBox(
                            height: 150.h,
                            child: const Center(
                                child: CircularProgressIndicator()));
                      }

                      return Stack(
                        children: [
                          SizedBox(
                            width: 368.2.w,
                            child: CarouselSlider.builder(
                                itemCount: controller2.banners.length,
                                itemBuilder: (context, index, realIndex) {
                                  final product = controller2.banners[index];
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    height: 140.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: ColorsConstants.greyColor3,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left:
                                                          Radius.circular(8.r)),
                                              child: Image.network(
                                                product['thumbnail'],
                                                height: double.infinity,
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.h,
                                                  vertical: 10.w),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                        product['title'],
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: StringsConstants
                                                            .shopcarouseltitle1),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                      "Get up to ${product['discountPercentage']}% OFF",
                                                      style: StringsConstants
                                                          .shopcarouseltitle2)
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                    height: 120.h,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.95,
                                    onPageChanged: (index, reason) {
                                      controller2.currentBannerIndex.value =
                                          index;
                                    })),
                          ),
                          Positioned(
                              bottom: 4,
                              right: 130,
                              child: Row(
                                children: List.generate(
                                    controller2.banners.length,
                                    (index) => Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2),
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: controller2
                                                          .currentBannerIndex
                                                          .value ==
                                                      index
                                                  ? ColorsConstants.greenColor
                                                  : ColorsConstants.greyColor3),
                                        )),
                              ))
                        ],
                      );
                    }),

                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Exclusive Offer ",
                            style: StringsConstants.shopTitle1a,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routenames.ExploreScreen);
                            },
                            child: Text(
                              "See all",
                              style: StringsConstants.shopTitle1b,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Horizontal Scroll ---- EXCLUSIVE OFFER -----------------
                    Obx(() {
                      if (controller2.isLoading.value) {
                        return SizedBox(
                            height: 150.h, child: CircularProgressIndicator());
                      }
                      return SizedBox(
                        height: 250.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(12.0.w),
                            itemCount: controller2.products.length,
                            itemBuilder: (context, index) {
                              final product = controller2.products[index];

                              return InkWell(
                                onTap: () {
                                  Get.toNamed(Routenames.ShopScreen2,
                                      arguments: product);
                                },
                                child: Container(
                                  height: 230.h,
                                  width: 160.w,
                                  margin: EdgeInsets.only(right: 10.w),
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                          color: ColorsConstants.greyColor4),
                                      color: ColorsConstants.whiteColor),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.network(
                                          product['thumbnail'],
                                          height: 90.h,
                                          width: 100.w,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Text(product['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: StringsConstants
                                              .shopExclusiveTitle),
                                      Text(
                                        product['tags'].join(', '),
                                        style: StringsConstants
                                            .shopExclusivesubtitle,
                                      ),
                                      Text(product['availabilityStatus'],
                                          style: StringsConstants
                                              .shopExclusivesubtitle),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("\$${product['price']}",
                                              style: StringsConstants
                                                  .shopExclusivePrice),
                                          InkWell(
                                            onTap: () {
                                              controller2
                                                  .addToCart(product['id']);
                                            },
                                            child: Container(
                                              height: 42.h,
                                              width: 42.w,
                                              decoration: BoxDecoration(
                                                  color: ColorsConstants
                                                      .greenColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          17.r)),
                                              child: Icon(Icons.add,
                                                  color: ColorsConstants
                                                      .whiteColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Best Selling ",
                            style: StringsConstants.shopTitle1a,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routenames.ExploreScreen);
                            },
                            child: Text(
                              "See all",
                              style: StringsConstants.shopTitle1b,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // vertical scroll ------------- BEST SELLING WIDGET-----------------
                    Obx(() {
                      if (controller2.isLoading.value) {
                        return SizedBox(
                            height: 50.h, child: CircularProgressIndicator());
                      }
                      return SizedBox(
                        height: 250.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(12.0.w),
                            itemCount: controller2.products2.length,
                            itemBuilder: (context, index) {
                              final product = controller2.products2[index];

                              return InkWell(
                                onTap: () {
                                  Get.toNamed(Routenames.ShopScreen2,
                                      arguments: product);
                                },
                                child: Container(
                                  height: 230.h,
                                  width: 160.w,
                                  margin: EdgeInsets.only(right: 10.w),
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                          color: ColorsConstants.greyColor4),
                                      color: ColorsConstants.whiteColor),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.network(
                                          product['thumbnail'],
                                          height: 90.h,
                                          width: 100.w,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Text(product['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: StringsConstants
                                              .shopExclusiveTitle),
                                      Text(
                                        product['tags'].join(', '),
                                        style: StringsConstants
                                            .shopExclusivesubtitle,
                                      ),
                                      Text(product['availabilityStatus'],
                                          style: StringsConstants
                                              .shopExclusivesubtitle),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("\$${product['price']}",
                                              style: StringsConstants
                                                  .shopExclusivePrice),
                                          InkWell(
                                            onTap: () {
                                              controller2
                                                  .addToCart(product['id']);
                                            },
                                            child: Container(
                                              height: 42.h,
                                              width: 42.w,
                                              decoration: BoxDecoration(
                                                  color: ColorsConstants
                                                      .greenColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          17.r)),
                                              child: Icon(Icons.add,
                                                  color: ColorsConstants
                                                      .whiteColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Groceries",
                            style: StringsConstants.shopTitle1a,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routenames.ExploreScreen);
                            },
                            child: Text(
                              "See all",
                              style: StringsConstants.shopTitle1b,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Obx(() {
                      if (controller2.isLoading.value) {
                        return SizedBox(
                          height: 50.h,
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox(
                        height: 105,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller2.Groceries.length,
                            padding: EdgeInsets.all(12.0.w),
                            itemBuilder: (context, index) {
                              final product = controller2.Groceries[index];
                              return Container(
                                margin: EdgeInsets.only(right: 10.w),
                                padding: EdgeInsets.all(12.w),
                                height: 100.h,
                                width: 248.w,
                                decoration: BoxDecoration(
                                  color: containerColor[
                                      index % containerColor.length],
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: Row(
                                  children: [
                                    Image.network(
                                      product['images'][0],
                                      height: 72.h,
                                      width: 72.h,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Text(
                                      product['tags']
                                          .map((tag) => tag.contains(' ')
                                              ? tag.replaceFirst(' ', '\n')
                                              : tag)
                                          .join(
                                              '\n'), // if the tag contains a space has 2 words then make the \n between them
                                      style:
                                          StringsConstants.shopGroceriesTitle,
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                    }),

                    // Horizontal scroll ------------- After GROCERIES Meat WIDGET-----------------
                    Obx(() {
                      if (controller2.isLoading.value) {
                        return SizedBox(
                            height: 50.h, child: CircularProgressIndicator());
                      }
                      return SizedBox(
                        height: 250.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(12.0.w),
                            itemCount: controller2.Meat.length,
                            itemBuilder: (context, index) {
                              final product = controller2.Meat[index];

                              return InkWell(
                                onTap: () {
                                  Get.toNamed(Routenames.ShopScreen2,
                                      arguments: product);
                                },
                                child: Container(
                                  height: 230.h,
                                  width: 160.w,
                                  margin: EdgeInsets.only(right: 10.w),
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                          color: ColorsConstants.greyColor4),
                                      color: ColorsConstants.whiteColor),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.network(
                                          product['thumbnail'],
                                          height: 90.h,
                                          width: 100.w,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Text(product['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: StringsConstants
                                              .shopExclusiveTitle),
                                      Text(
                                        product['tags'].join(', '),
                                        style: StringsConstants
                                            .shopExclusivesubtitle,
                                      ),
                                      Text(product['availabilityStatus'],
                                          style: StringsConstants
                                              .shopExclusivesubtitle),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("\$${product['price']}",
                                              style: StringsConstants
                                                  .shopExclusivePrice),
                                          InkWell(
                                            onTap: () {
                                              controller2
                                                  .addToCart(product['id']);
                                            },
                                            child: Container(
                                              height: 42.h,
                                              width: 42.w,
                                              decoration: BoxDecoration(
                                                  color: ColorsConstants
                                                      .greenColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          17.r)),
                                              child: Icon(Icons.add,
                                                  color: ColorsConstants
                                                      .whiteColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
