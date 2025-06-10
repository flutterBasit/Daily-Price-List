import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.greenColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Icon.png'),
              Column(
                children: [
                  Text(
                    'Daily Price List',
                    style: StringsConstants.splashScreenStyle,
                  ),
                  Text(
                    "Online       Market       Rates",
                    style: StringsConstants.splashScreenStyle2,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
