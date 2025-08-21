import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_price_list/Resources/Components/InternetIssue.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:daily_price_list/ViewModel/DropDown_ViewModel.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Shopscreen extends StatelessWidget {
  final DropdownController controller = Get.find<DropdownController>();
  final HomeScreen_ViewController controller2 =
      Get.find<HomeScreen_ViewController>();

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
            if (controller2.hasInternetError.value) {
              return Internetissue(
                onRefesh: () async {
                  final futures = [
                    controller2.fetchBestSellingProducts(),
                    controller2.fetchExclusiveProducts(),
                    controller2.fetchGroceriesProducts(),
                    controller2.fetchMeatProducts(),
                    controller2.fetchPromoBanner()
                  ];
                  await Future.wait(futures);
                },
              );
            }
            return Skeletonizer(
              enabled: controller2.isLoading.value,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RefreshIndicator(
                  backgroundColor: ColorsConstants.whiteColor,
                  onRefresh: () async {
                    final futures = [
                      controller2.fetchBestSellingProducts(),
                      controller2.fetchExclusiveProducts(),
                      controller2.fetchGroceriesProducts(),
                      controller2.fetchMeatProducts(),
                      controller2.fetchPromoBanner()
                    ];
                    await Future.wait(futures);
                  },
                  child: SingleChildScrollView(
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
                            controller: TextEditingController(
                                text: controller2.searhQuery.value),
                            decoration: InputDecoration(
                              hintText: 'Search Store',
                              hintStyle: StringsConstants.shopSearchTextField,
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: controller2.searhQuery.isNotEmpty
                                  ? IconButton(
                                      onPressed: () =>
                                          controller2.clearSearch(),
                                      icon: Icon(Icons.clear))
                                  : null,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              controller2.searchProduct(value);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        if (controller2.isSearching.value)
                          _buildSearchResults(),
                        if (!controller2.isSearching.value)
                          _buildNormalContent()
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
//---------------if searchResult is there -------------------------------

  Widget _buildSearchResults() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w),
          child: Text("Search Results for '${controller2.searhQuery.value}'"),
        ),
        SizedBox(
          height: 10.h,
        ),
        if (controller2.searchResult.isEmpty)
          Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w),
              child: Text("No Products Found"))
        else
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7),
              itemCount: controller2.searchResult.length,
              itemBuilder: (context, index) {
                final product = controller2.searchResult[index];
                return _buildProductItem(product);
              })
      ],
    );
  }

  // Reusable product item widget
  Widget _buildProductItem(Map<String, dynamic> product) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routenames.ShopScreen2, arguments: product);
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorsConstants.greyColor4),
          color: ColorsConstants.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product['thumbnail'],
                height: 90.h,
                width: 100.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 90.h,
                    width: 100.w,
                    // color: Colors.grey,
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.grey[400],
                      size: 24.w,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              product['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: StringsConstants.shopExclusiveTitle,
            ),
            SizedBox(height: 4.h),
            Text(
              "\$${product['price']}",
              style: StringsConstants.shopExclusivePrice,
            ),
            Spacer(),
            InkWell(
              onTap: () {
                controller2.addToCart(product['id']);
              },
              child: Container(
                height: 32.h,
                decoration: BoxDecoration(
                  color: ColorsConstants.greenColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//-----------if searchResult is empty -------------------------------------
  Widget _buildNormalContent() {
    return Column(
      children: [
        // promotional banner using the cauresol package
        Stack(
          children: [
            SizedBox(
              width: 368.2.w,
              child: CarouselSlider.builder(
                  itemCount: controller2.isLoading.value
                      ? 3
                      : controller2.banners.length,
                  itemBuilder: (context, index, realIndex) {
                    if (controller2.isLoading.value) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        height: 140.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: ColorsConstants.greyColor3,
                        ),
                      );
                    }

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
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(8.r)),
                                child: Image.network(
                                  product['thumbnail'],
                                  height: double.infinity,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 90.h,
                                      width: 100.w,
                                      //   color: Colors.grey,
                                      child: Icon(
                                        Icons.error_outline,
                                        color: Colors.grey[400],
                                        size: 24.w,
                                      ),
                                    );
                                  },
                                ),
                              )),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.h, vertical: 10.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(product['title'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: StringsConstants
                                              .shopcarouseltitle1),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                        "Get up to ${product['discountPercentage']}% OFF",
                                        style:
                                            StringsConstants.shopcarouseltitle2)
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
                        controller2.currentBannerIndex.value = index;
                      })),
            ),
            Positioned(
                bottom: 4,
                right: 130,
                child: Row(
                  children: List.generate(
                      controller2.isLoading.value
                          ? 3
                          : controller2.banners.length,
                      (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller2.currentBannerIndex.value ==
                                        index
                                    ? ColorsConstants.greenColor
                                    : ColorsConstants.greyColor3),
                          )),
                ))
          ],
        ),

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
        SizedBox(
          height: 250.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(12.0.w),
              itemCount:
                  controller2.isLoading.value ? 4 : controller2.products.length,
              itemBuilder: (context, index) {
                if (controller2.isLoading.value) {
                  return Container(
                    height: 230.h,
                    width: 160.w,
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: ColorsConstants.greyColor4),
                        color: ColorsConstants.whiteColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 90.h,
                          width: 100.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 16.h,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          height: 14.h,
                          width: 120.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          height: 14.h,
                          width: 80.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 20.h,
                              width: 50.w,
                              color: Colors.grey.shade300,
                            ),
                            Container(
                              height: 42.h,
                              width: 42.w,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(17.r)),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }

                final product = controller2.products[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routenames.ShopScreen2, arguments: product);
                  },
                  child: Container(
                    height: 230.h,
                    width: 160.w,
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: ColorsConstants.greyColor4),
                        color: ColorsConstants.whiteColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(
                            product['thumbnail'],
                            height: 90.h,
                            width: 100.w,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 90.h,
                                width: 100.w,
                                //  color: Colors.grey,
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.grey[400],
                                  size: 24.w,
                                ),
                              );
                            },
                          ),
                        ),
                        Text(product['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StringsConstants.shopExclusiveTitle),
                        Text(
                          product['tags'].join(', '),
                          style: StringsConstants.shopExclusivesubtitle,
                        ),
                        Text(product['availabilityStatus'],
                            style: StringsConstants.shopExclusivesubtitle),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("\$${product['price']}",
                                style: StringsConstants.shopExclusivePrice),
                            InkWell(
                              onTap: () {
                                controller2.addToCart(product['id']);
                              },
                              child: Container(
                                height: 42.h,
                                width: 42.w,
                                decoration: BoxDecoration(
                                    color: ColorsConstants.greenColor,
                                    borderRadius: BorderRadius.circular(17.r)),
                                child: Icon(Icons.add,
                                    color: ColorsConstants.whiteColor),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),

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
        SizedBox(
          height: 250.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(12.0.w),
              itemCount: controller2.isLoading.value
                  ? 4
                  : controller2.products2.length,
              itemBuilder: (context, index) {
                if (controller2.isLoading.value) {
                  return Container(
                    height: 230.h,
                    width: 160.w,
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: ColorsConstants.greyColor4),
                        color: ColorsConstants.whiteColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 90.h,
                          width: 100.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 16.h,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          height: 14.h,
                          width: 120.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          height: 14.h,
                          width: 80.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 20.h,
                              width: 50.w,
                              color: Colors.grey.shade300,
                            ),
                            Container(
                              height: 42.h,
                              width: 42.w,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(17.r)),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }

                final product = controller2.products2[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routenames.ShopScreen2, arguments: product);
                  },
                  child: Container(
                    height: 230.h,
                    width: 160.w,
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: ColorsConstants.greyColor4),
                        color: ColorsConstants.whiteColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(
                            product['thumbnail'],
                            height: 90.h,
                            width: 100.w,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 90.h,
                                width: 100.w,
                                //  color: Colors.grey,
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.grey[400],
                                  size: 24.w,
                                ),
                              );
                            },
                          ),
                        ),
                        Text(product['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StringsConstants.shopExclusiveTitle),
                        Text(
                          product['tags'].join(', '),
                          style: StringsConstants.shopExclusivesubtitle,
                        ),
                        Text(product['availabilityStatus'],
                            style: StringsConstants.shopExclusivesubtitle),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("\$${product['price']}",
                                style: StringsConstants.shopExclusivePrice),
                            InkWell(
                              onTap: () {
                                controller2.addToCart(product['id']);
                              },
                              child: Container(
                                height: 42.h,
                                width: 42.w,
                                decoration: BoxDecoration(
                                    color: ColorsConstants.greenColor,
                                    borderRadius: BorderRadius.circular(17.r)),
                                child: Icon(Icons.add,
                                    color: ColorsConstants.whiteColor),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),

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

        SizedBox(
          height: 105,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller2.isLoading.value
                  ? 4
                  : controller2.Groceries.length,
              padding: EdgeInsets.all(12.0.w),
              itemBuilder: (context, index) {
                if (controller2.isLoading.value) {
                  return Container(
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.all(12.w),
                    height: 100.h,
                    width: 248.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 72.h,
                          width: 72.h,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          height: 40.h,
                          width: 100.w,
                          color: Colors.grey.shade400,
                        )
                      ],
                    ),
                  );
                }

                final product = controller2.Groceries[index];
                return Container(
                  margin: EdgeInsets.only(right: 10.w),
                  padding: EdgeInsets.all(12.w),
                  height: 100.h,
                  width: 248.w,
                  decoration: BoxDecoration(
                    color: containerColor[index % containerColor.length],
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
                        style: StringsConstants.shopGroceriesTitle,
                      )
                    ],
                  ),
                );
              }),
        ),

        // Horizontal scroll ------------- After GROCERIES Meat WIDGET-----------------
        SizedBox(
          height: 250.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(12.0.w),
              itemCount:
                  controller2.isLoading.value ? 4 : controller2.Meat.length,
              itemBuilder: (context, index) {
                if (controller2.isLoading.value) {
                  return Container(
                    height: 230.h,
                    width: 160.w,
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: ColorsConstants.greyColor4),
                        color: ColorsConstants.whiteColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 90.h,
                          width: 100.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 16.h,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          height: 14.h,
                          width: 120.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          height: 14.h,
                          width: 80.w,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 20.h,
                              width: 50.w,
                              color: Colors.grey.shade300,
                            ),
                            Container(
                              height: 42.h,
                              width: 42.w,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(17.r)),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }

                final product = controller2.Meat[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(Routenames.ShopScreen2, arguments: product);
                  },
                  child: Container(
                    height: 230.h,
                    width: 160.w,
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: ColorsConstants.greyColor4),
                        color: ColorsConstants.whiteColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(
                            product['thumbnail'],
                            height: 90.h,
                            width: 100.w,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 90.h,
                                width: 100.w,
                                //  color: Colors.grey,
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.grey[400],
                                  size: 24.w,
                                ),
                              );
                            },
                          ),
                        ),
                        Text(product['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StringsConstants.shopExclusiveTitle),
                        Text(
                          product['tags'].join(', '),
                          style: StringsConstants.shopExclusivesubtitle,
                        ),
                        Text(product['availabilityStatus'],
                            style: StringsConstants.shopExclusivesubtitle),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("\$${product['price']}",
                                style: StringsConstants.shopExclusivePrice),
                            InkWell(
                              onTap: () {
                                controller2.addToCart(product['id']);
                              },
                              child: Container(
                                height: 42.h,
                                width: 42.w,
                                decoration: BoxDecoration(
                                    color: ColorsConstants.greenColor,
                                    borderRadius: BorderRadius.circular(17.r)),
                                child: Icon(Icons.add,
                                    color: ColorsConstants.whiteColor),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:daily_price_list/Resources/Components/InternetIssue.dart';
// import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
// import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
// import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
// import 'package:daily_price_list/ViewModel/DropDown_ViewModel.dart';
// import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class Shopscreen extends StatelessWidget {
//   final DropdownController controller = Get.find<DropdownController>();
//   final HomeScreen_ViewController controller2 =
//       Get.find<HomeScreen_ViewController>();

//   //defining the List of colors of containers for groceries
//   final List<Color> containerColor = [
//     Color(0xffF8A44C),
//     Color(0xff53B175),
//     Color(0xffF7A593),
//     Color(0xffD3B0E0),
//     Color(0xffFDE598),
//     Color(0xffB7Dff5)
//   ];

//   Shopscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Load saved location when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final prefs = await SharedPreferences.getInstance();
//       controller.selectedProvine.value = prefs.getString('savedProvince') ?? '';
//       controller.selectedDistrict.value =
//           prefs.getString('savedDistrict') ?? '';
//       controller.selectedZone.value = prefs.getString('savedZone') ?? '';
//       // Print to verify loaded values
//       print(
//           'Loaded location: ${controller.selectedProvine.value}, ${controller.selectedDistrict.value}');
//     });

//     return Scaffold(
//         backgroundColor: ColorsConstants.whiteColor,
//         body: SafeArea(
//           child: Obx(() {
//             if (controller2.hasInternetError.value) {
//               return Internetissue(
//                 onRefesh: () async {
//                   controller2.isLoading.value = true;
//                   final futures = [
//                     controller2.fetchBestSellingProducts(),
//                     controller2.fetchExclusiveProducts(),
//                     controller2.fetchGroceriesProducts(),
//                     controller2.fetchMeatProducts(),
//                     controller2.fetchPromoBanner()
//                   ];
//                   await Future.wait(futures);
//                   controller2.isLoading.value = false;
//                 },
//               );
//             }
//             return Skeletonizer(
//               enabled: controller2.isLoading.value,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: RefreshIndicator(
//                   backgroundColor: ColorsConstants.whiteColor,
//                   onRefresh: () async {
//                     controller2.isLoading.value = true;
//                     final futures = [
//                       controller2.fetchBestSellingProducts(),
//                       controller2.fetchExclusiveProducts(),
//                       controller2.fetchGroceriesProducts(),
//                       controller2.fetchMeatProducts(),
//                       controller2.fetchPromoBanner()
//                     ];
//                     await Future.wait(futures);
//                     controller2.isLoading.value = false;
//                   },
//                   child: SingleChildScrollView(
//                     physics: AlwaysScrollableScrollPhysics(), // Add this
//                     child: Column(
//                       children: [
//                         Image.asset('assets/images/LoginSignup.png',
//                             height: 30.h, width: 30.w),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.location_on,
//                                 color: ColorsConstants.blackColor3),
//                             if (controller.selectedProvine.value.isNotEmpty)
//                               Text(
//                                 "${controller.selectedProvine.value}, ",
//                                 style: StringsConstants.shopScreenTextColor,
//                               ),
//                             if (controller.selectedDistrict.value.isNotEmpty)
//                               Text(
//                                 controller.selectedDistrict.value,
//                                 style: StringsConstants.shopScreenTextColor,
//                               ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: TextField(
//                             controller: TextEditingController(
//                                 text: controller2.searhQuery.value),
//                             decoration: InputDecoration(
//                               hintText: 'Search Store',
//                               hintStyle: StringsConstants.shopSearchTextField,
//                               prefixIcon: Icon(Icons.search),
//                               suffixIcon: controller2.searhQuery.isNotEmpty
//                                   ? IconButton(
//                                       onPressed: () =>
//                                           controller2.clearSearch(),
//                                       icon: Icon(Icons.clear))
//                                   : null,
//                               contentPadding:
//                                   EdgeInsets.symmetric(vertical: 10),
//                               filled: true,
//                               fillColor: Colors.grey.shade200,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                             onChanged: (value) {
//                               controller2.searchProduct(value);
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         if (controller2.isSearching.value)
//                           _buildSearchResults(),
//                         if (!controller2.isSearching.value)
//                           _buildNormalContent()
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ));
//   }

//   //---------------if searchResult is there -------------------------------
//   Widget _buildSearchResults() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: 15
//                   .w), // Fixed: EdgeInsets.symmetric instead of EdgeInsetsGeometry.symmetric
//           child: Text(
//             "Search Results for '${controller2.searhQuery.value}'",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         SizedBox(
//           height: 10.h,
//         ),
//         if (controller2.searchResult
//             .isEmpty) // Fixed: searchResults instead of searchResult
//           Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: 15.w), // Fixed: EdgeInsets.symmetric
//               child: Text("No Products Found", style: TextStyle(fontSize: 16)))
//         else
//           GridView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 0.7),
//               itemCount:
//                   controller2.searchResult.length, // Fixed: searchResults
//               itemBuilder: (context, index) {
//                 final product =
//                     controller2.searchResult[index]; // Fixed: searchResults
//                 return _buildProductItem(product);
//               })
//       ],
//     );
//   }

//   // Reusable product item widget
//   Widget _buildProductItem(Map<String, dynamic> product) {
//     return InkWell(
//       onTap: () {
//         Get.toNamed(Routenames.ShopScreen2, arguments: product);
//       },
//       child: Container(
//         padding: EdgeInsets.all(12.w),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: ColorsConstants.greyColor4),
//           color: ColorsConstants.whiteColor,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Image.network(
//                 product['thumbnail'],
//                 height: 90.h,
//                 width: 100.w,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               product['title'],
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: StringsConstants.shopExclusiveTitle,
//             ),
//             SizedBox(height: 4.h),
//             Text(
//               "\$${product['price']}",
//               style: StringsConstants.shopExclusivePrice,
//             ),
//             Spacer(),
//             InkWell(
//               onTap: () {
//                 controller2.addToCart(product['id']);
//               },
//               child: Container(
//                 height: 32.h,
//                 decoration: BoxDecoration(
//                   color: ColorsConstants.greenColor,
//                   borderRadius: BorderRadius.circular(8.r),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Add to Cart",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   //-----------if searchResult is empty -------------------------------------
//   Widget _buildNormalContent() {
//     return Column(
//       children: [
//         // promotional banner using the cauresol package
//         Stack(
//           children: [
//             SizedBox(
//               width: 368.2.w,
//               child: CarouselSlider.builder(
//                   itemCount: controller2.isLoading.value
//                       ? 3
//                       : controller2.banners.length,
//                   itemBuilder: (context, index, realIndex) {
//                     if (controller2.isLoading.value) {
//                       return Container(
//                         margin: EdgeInsets.symmetric(horizontal: 8.w),
//                         height: 140.h,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.r),
//                           color: ColorsConstants.greyColor3,
//                         ),
//                       );
//                     }

//                     final product = controller2.banners[index];
//                     return Container(
//                       margin: EdgeInsets.symmetric(horizontal: 8.w),
//                       height: 140.h,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.r),
//                         color: ColorsConstants.greyColor3,
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                               flex: 2,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.horizontal(
//                                     left: Radius.circular(8.r)),
//                                 child: Image.network(
//                                   product['thumbnail'],
//                                   height: double.infinity,
//                                   fit: BoxFit.fill,
//                                 ),
//                               )),
//                           Expanded(
//                               flex: 3,
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 12.h, vertical: 10.w),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Flexible(
//                                       child: Text(product['title'],
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: StringsConstants
//                                               .shopcarouseltitle1),
//                                     ),
//                                     SizedBox(
//                                       height: 6,
//                                     ),
//                                     Text(
//                                         "Get up to ${product['discountPercentage']}% OFF",
//                                         style:
//                                             StringsConstants.shopcarouseltitle2)
//                                   ],
//                                 ),
//                               ))
//                         ],
//                       ),
//                     );
//                   },
//                   options: CarouselOptions(
//                       height: 120.h,
//                       autoPlay: true,
//                       enlargeCenterPage: true,
//                       viewportFraction: 0.95,
//                       onPageChanged: (index, reason) {
//                         controller2.currentBannerIndex.value = index;
//                       })),
//             ),
//             Positioned(
//                 bottom: 4,
//                 right: 130,
//                 child: Row(
//                   children: List.generate(
//                       controller2.isLoading.value
//                           ? 3
//                           : controller2.banners.length,
//                       (index) => Container(
//                             margin: EdgeInsets.symmetric(horizontal: 2),
//                             width: 8,
//                             height: 8,
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: controller2.currentBannerIndex.value ==
//                                         index
//                                     ? ColorsConstants.greenColor
//                                     : ColorsConstants.greyColor3),
//                           )),
//                 ))
//           ],
//         ),

//         SizedBox(
//           height: 15.h,
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15.w),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Exclusive Offer ",
//                 style: StringsConstants.shopTitle1a,
//               ),
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(Routenames.ExploreScreen);
//                 },
//                 child: Text(
//                   "See all",
//                   style: StringsConstants.shopTitle1b,
//                 ),
//               ),
//             ],
//           ),
//         ),

//         //Horizontal Scroll ---- EXCLUSIVE OFFER -----------------
//         SizedBox(
//           height: 250.h,
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: EdgeInsets.all(12.0.w),
//               itemCount:
//                   controller2.isLoading.value ? 4 : controller2.products.length,
//               itemBuilder: (context, index) {
//                 if (controller2.isLoading.value) {
//                   return Container(
//                     height: 230.h,
//                     width: 160.w,
//                     margin: EdgeInsets.only(right: 10.w),
//                     padding: EdgeInsets.all(12.w),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12.r),
//                         border: Border.all(color: ColorsConstants.greyColor4),
//                         color: ColorsConstants.whiteColor),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 90.h,
//                           width: 100.w,
//                           color: Colors.grey.shade300,
//                         ),
//                         SizedBox(height: 8.h),
//                         Container(
//                           height: 16.h,
//                           width: double.infinity,
//                           color: Colors.grey.shade300,
//                         ),
//                         SizedBox(height: 4.h),
//                         Container(
//                           height: 14.h,
//                           width: 120.w,
//                           color: Colors.grey.shade300,
//                         ),
//                         SizedBox(height: 4.h),
//                         Container(
//                           height: 14.h,
//                           width: 80.w,
//                           color: Colors.grey.shade300,
//                         ),
//                         SizedBox(height: 8.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               height: 20.h,
//                               width: 50.w,
//                               color: Colors.grey.shade300,
//                             ),
//                             Container(
//                               height: 42.h,
//                               width: 42.w,
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   borderRadius: BorderRadius.circular(17.r)),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 final product = controller2.products[index];
//                 return InkWell(
//                   onTap: () {
//                     Get.toNamed(Routenames.ShopScreen2, arguments: product);
//                   },
//                   child: Container(
//                     height: 230.h,
//                     width: 160.w,
//                     margin: EdgeInsets.only(right: 10.w),
//                     padding: EdgeInsets.all(12.w),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12.r),
//                         border: Border.all(color: ColorsConstants.greyColor4),
//                         color: ColorsConstants.whiteColor),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Image.network(
//                             product['thumbnail'],
//                             height: 90.h,
//                             width: 100.w,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         Text(product['title'],
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: StringsConstants.shopExclusiveTitle),
//                         Text(
//                           product['tags'].join(', '),
//                           style: StringsConstants.shopExclusivesubtitle,
//                         ),
//                         Text(product['availabilityStatus'],
//                             style: StringsConstants.shopExclusivesubtitle),
//                         SizedBox(
//                           height: 5.h,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("\$${product['price']}",
//                                 style: StringsConstants.shopExclusivePrice),
//                             InkWell(
//                               onTap: () {
//                                 controller2.addToCart(product['id']);
//                               },
//                               child: Container(
//                                 height: 42.h,
//                                 width: 42.w,
//                                 decoration: BoxDecoration(
//                                     color: ColorsConstants.greenColor,
//                                     borderRadius: BorderRadius.circular(17.r)),
//                                 child: Icon(Icons.add,
//                                     color: ColorsConstants.whiteColor),
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//         ),

//         // ... rest of your _buildNormalContent method remains the same ...
//         // I've omitted the rest for brevity, but it should work the same
//       ],
//     );
//   }
// }
