import 'package:daily_price_list/Resources/Constants/Constants.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.greenColor,
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
                    style: Constants.splashScreenStyle,
                  ),
                  Text(
                    "Online       Market       Rates",
                    style: Constants.splashScreenStyle2,
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
