import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:flutter/material.dart';

class Internetissue extends StatelessWidget {
  final VoidCallback onRefesh;

  Internetissue({super.key, required this.onRefesh});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: 80,
            color: ColorsConstants.greenColor,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'No Internet Connection',
            style: StringsConstants.shopExclusiveTitle,
          ),
          SizedBox(
            height: 10,
          ),
          Buttons1(
            title: 'Refresh',
            color: ColorsConstants.greenColor,
            onTap: onRefesh,
          )
        ],
      ),
    );
  }
}
