import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Cartscreen extends StatelessWidget {
  final controller = Get.find<HomeScreen_ViewController>();
  Cartscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final product = Get.arguments as Map<String, dynamic>;

    return SafeArea(
      child: Obx(() {
        final cart = controller.cartProductDetails;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'My Cart',
                style: StringsConstants.favouriteScreenTitle,
              ),
            ),
            Divider(
              color: ColorsConstants.whiteColor4,
            ),
            Expanded(
                child: cart.isEmpty
                    ? Center(
                        child: Text("No Items Added Yet!"),
                      )
                    : ListView.separated(
                        itemCount: cart.length + 1,
                        separatorBuilder: (_, __) => Divider(
                          endIndent: 10,
                          indent: 10,
                          color: ColorsConstants.whiteColor4,
                        ),
                        itemBuilder: (_, index) {
                          if (index == cart.length) {
                            return Divider(
                              color: ColorsConstants.whiteColor4,
                            );
                          }
                          final product = cart[index];

                          return ListTile(
                            leading: Image.network(product['thumbnail']),
                            title: Text(
                              product['title'],
                              style: StringsConstants.shopExclusiveTitle,
                            ),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['tags'].join(', '),
                                  style: StringsConstants.shopExclusivesubtitle,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 46.h,
                                      width: 46.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(17.r),
                                          border: Border.all(
                                              width: 1.5,
                                              color:
                                                  ColorsConstants.whiteColor4)),
                                      child: IconButton(
                                          onPressed: () {
                                            controller.decrement();
                                          },
                                          icon: Icon(Icons.remove)),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Obx(() {
                                      return Center(
                                          child: Text(
                                        controller.count.value.toString(),
                                        style:
                                            StringsConstants.shopScreen2counter,
                                      ));
                                    }),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Container(
                                      height: 46.h,
                                      width: 46.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(17.r),
                                          border: Border.all(
                                              width: 1.5,
                                              color:
                                                  ColorsConstants.whiteColor4)),
                                      child: IconButton(
                                          onPressed: () {
                                            controller.increment();
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: ColorsConstants.greenColor,
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ))
          ],
        );
      }),
    );
  }
}
