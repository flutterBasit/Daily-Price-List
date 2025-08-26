import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:flutter/material.dart';

class Explorescreen extends StatelessWidget {
  const Explorescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                "Find Products",
                style: StringsConstants.favouriteScreenTitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
