import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_price_list/Resources/Components/AnimatedSearch.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/ViewModel/DropDown_ViewModel.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Shopscreen extends StatelessWidget {
  final DropdownController controller = Get.find<DropdownController>();
  final HomeScreen_ViewController controller2 =
      Get.put(HomeScreen_ViewController());
  Shopscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsConstants.whiteColor,
        body: SafeArea(
          child: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset('assets/images/LoginSignup.png',
                      height: 30.h, width: 30.w),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: ColorsConstants.blackColor3,
                      ),
                      Text(
                        "${controller.selectedProvine.value}, ",
                        style: StringsConstants.shopScreenTextColor,
                      ),
                      Text(controller.selectedDistrict.value,
                          style: StringsConstants.shopScreenTextColor)
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
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
                    height: 20.h,
                  ),

                  // promotional banner using the cauresol package
                  Obx(() {
                    if (controller2.isLoading.value) {
                      return SizedBox(
                          height: 150.h,
                          child:
                              const Center(child: CircularProgressIndicator()));
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
                                  margin: EdgeInsets.symmetric(horizontal: 8.w),
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
                                                    left: Radius.circular(8.r)),
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
                                                  child: Text(product['title'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 2),
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
                    height: 20.h,
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
                        Text(
                          "See all",
                          style: StringsConstants.shopTitle1b,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}
