import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cartscreen extends StatelessWidget {
  const Cartscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Obx(() {
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
            )
          ],
        );
      }),
    );
  }
}
