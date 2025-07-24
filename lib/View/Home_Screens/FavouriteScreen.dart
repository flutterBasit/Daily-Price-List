import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/Resources/Routes/RouteNames.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favouritescreen extends StatelessWidget {
  final controller = Get.find<HomeScreen_ViewController>();

  Favouritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Obx(() {
      final favourite = controller.favouriteProductDetails;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Favourite',
              style: StringsConstants.favouriteScreenTitle,
            ),
          ),
          Divider(
            color: ColorsConstants.whiteColor4,
          ),
          Expanded(
            child: favourite.isEmpty
                ? Center(
                    child: Text('No Favourites Added Yet!'),
                  )
                : ListView.separated(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => Divider(
                        endIndent: 20,
                        indent: 20,
                        color: ColorsConstants.whiteColor4),
                    itemCount: favourite.length + 1,
                    itemBuilder: (_, index) {
                      if (index == favourite.length) {
                        return Divider(
                          color: ColorsConstants.whiteColor4,
                        );
                      }
                      final product = favourite[index];
                      return ListTile(
                        leading: Image.network(
                          product['thumbnail'],
                        ),
                        title: Text(
                          product['title'],
                          style: StringsConstants.shopExclusiveTitle,
                        ),
                        subtitle: Text(
                          product['tags'].join(', '),
                          style: StringsConstants.shopExclusivesubtitle,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '\$${product['price'].toString()}',
                              style: StringsConstants.favouriteScreenPrice,
                            ),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                        onTap: () {
                          Get.toNamed(Routenames.ShopScreen2,
                              arguments: product);
                        },
                      );
                    }),
          ),
          // if (favourite.isNotEmpty)
          // Divider(
          //   color: ColorsConstants.whiteColor4,
          // ),
          favourite.isEmpty
              ? SizedBox()
              : Buttons1(
                  title: 'Add All To Cart',
                  color: ColorsConstants.greenColor,
                  onTap: () {
                    controller.addAllFavouriteToCart();
                  },
                )
        ],
      );
    }));
  }
}
