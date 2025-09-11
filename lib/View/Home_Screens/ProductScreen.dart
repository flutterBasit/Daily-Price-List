// import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
// import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
// import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
// import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class Productscreen extends StatefulWidget {
//   final String CategoryName;
//   Productscreen({super.key, required this.CategoryName});

//   @override
//   State<Productscreen> createState() => _ProductscreenState();
// }

// class _ProductscreenState extends State<Productscreen> {
//   final HomeScreen_ViewController controller =
//       Get.find<HomeScreen_ViewController>();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final normalizrCategory = widget.CategoryName.toLowerCase().trim();
//       controller.fetchProductsByCategory(normalizrCategory);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorsConstants.whiteColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             //mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(14.0),
//                 child: Center(
//                     child: Text(
//                   widget.CategoryName,
//                   style: StringsConstants.favouriteScreenTitle,
//                 )),
//               ),
//               Expanded(child: Obx(() {
//                 if (controller.productByCategory.isEmpty &&
//                     controller.isLoading.value == false) {
//                   return Center(
//                     child: Text('No Product Found!'),
//                   );
//                 }

//                 return Skeletonizer(
//                   enabled: controller.isLoading.value,
//                   child: GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: 9,
//                           crossAxisSpacing: 7,
//                           childAspectRatio: 0.68),
//                       padding: EdgeInsets.all(8),
//                       shrinkWrap: true,
//                       itemCount: controller.isLoading.value
//                           ? 5
//                           : controller.productByCategory.length,
//                       itemBuilder: (context, index) {
//                         // final product = controller.productByCategory[index];
//                         final product = controller.isLoading.value
//                             ? {
//                                 'thumbnail': '',
//                                 'title': '',
//                                 'tags': [''],
//                                 'availabilityStatus': '',
//                                 'price': '',
//                                 'id': -1,
//                               }
//                             : controller.productByCategory[index];
//                         return InkWell(
//                           onTap: () {
//                             if (!controller.isLoading.value) {
//                               Get.toNamed(Routenames.ShopScreen2,
//                                   arguments: product);
//                             }
//                           },
//                           child: Container(
//                             height: 230.h,
//                             width: 160.w,
//                             margin: EdgeInsets.only(right: 10.w),
//                             padding: EdgeInsets.all(12.w),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12.r),
//                                 border: Border.all(
//                                     color: ColorsConstants.greyColor4),
//                                 color: ColorsConstants.whiteColor),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Center(
//                                   child: Image.network(
//                                     product['thumbnail'],
//                                     height: 90.h,
//                                     width: 100.w,
//                                     fit: BoxFit.fill,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         height: 90.h,
//                                         width: 100.w,
//                                         //  color: Colors.grey,
//                                         child: Icon(
//                                           Icons.error_outline,
//                                           color: Colors.grey[400],
//                                           size: 24.w,
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 Text(product['title'],
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: StringsConstants.shopExclusiveTitle),
//                                 Text(
//                                   product['tags'].join(', '),
//                                   style: StringsConstants.shopExclusivesubtitle,
//                                 ),
//                                 Text(product['availabilityStatus'],
//                                     style:
//                                         StringsConstants.shopExclusivesubtitle),
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("\$${product['price']}",
//                                         style: StringsConstants
//                                             .shopExclusivePrice),
//                                     InkWell(
//                                       onTap: () {
//                                         // controller.addToCart(product['id']);
//                                         if (!controller.isLoading.value) {
//                                           controller.addToCart(product['id']);
//                                         }
//                                       },
//                                       child: Container(
//                                         height: 42.h,
//                                         width: 42.w,
//                                         decoration: BoxDecoration(
//                                             color: ColorsConstants.greenColor,
//                                             borderRadius:
//                                                 BorderRadius.circular(17.r)),
//                                         child: Icon(Icons.add,
//                                             color: ColorsConstants.whiteColor),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                 );
//               }))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Productscreen extends StatefulWidget {
  final String CategoryName;
  const Productscreen({super.key, required this.CategoryName});

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  final HomeScreen_ViewController controller =
      Get.find<HomeScreen_ViewController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final normalizedCategory = widget.CategoryName.toLowerCase().trim();
      controller.fetchProductsByCategory(normalizedCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Center(
                  child: Text(
                    widget.CategoryName,
                    style: StringsConstants.favouriteScreenTitle,
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  // No products found case
                  if (controller.productByCategory.isEmpty &&
                      controller.isLoading.value == false) {
                    return const Center(child: Text("No Product Found!"));
                  }

                  // Skeletonizer wraps the grid
                  return Skeletonizer(
                    enabled: controller.isLoading.value,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 9,
                        crossAxisSpacing: 7,
                        childAspectRatio: 0.68,
                      ),
                      itemCount: controller.isLoading.value
                          ? 6 // fixed count for shimmer placeholders
                          : controller.productByCategory.length,
                      itemBuilder: (context, index) {
                        final product = controller.isLoading.value
                            ? {
                                'thumbnail':
                                    'https://via.placeholder.com/150', // dummy image
                                'title': 'Loading......',
                                'tags': ['...Loading......'],
                                'availabilityStatus': '...Loading...',
                                'price': '...Loading',
                                'id': -1,
                              }
                            : controller.productByCategory[index];

                        return InkWell(
                          onTap: () {
                            if (!controller.isLoading.value) {
                              Get.toNamed(
                                Routenames.ShopScreen2,
                                arguments: product,
                              );
                            }
                          },
                          child: Container(
                            height: 230.h,
                            width: 160.w,
                            margin: EdgeInsets.only(right: 10.w),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border:
                                  Border.all(color: ColorsConstants.greyColor4),
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
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 90.h,
                                        width: 100.w,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey[400],
                                          size: 28.w,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  product['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: StringsConstants.shopExclusiveTitle,
                                ),
                                Text(
                                  (product['tags'] as List).join(', '),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: StringsConstants.shopExclusivesubtitle,
                                ),
                                Text(
                                  product['availabilityStatus'],
                                  style: StringsConstants.shopExclusivesubtitle,
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${product['price']}",
                                      style:
                                          StringsConstants.shopExclusivePrice,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (!controller.isLoading.value) {
                                          controller.addToCart(product['id']);
                                        }
                                      },
                                      child: Container(
                                        height: 42.h,
                                        width: 42.w,
                                        decoration: BoxDecoration(
                                          color: ColorsConstants.greenColor,
                                          borderRadius:
                                              BorderRadius.circular(17.r),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: ColorsConstants.whiteColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
