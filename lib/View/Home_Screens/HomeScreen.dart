import 'package:daily_price_list/Resources/Components/BottomNavBar.dart';
import 'package:daily_price_list/View/Home_Screens/AccountScreen.dart';
import 'package:daily_price_list/View/Home_Screens/CartScreen.dart';
import 'package:daily_price_list/View/Home_Screens/ExploreScreen.dart';
import 'package:daily_price_list/View/Home_Screens/FavouriteScreen.dart';
import 'package:daily_price_list/View/Home_Screens/ShopScreen.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreen_ViewController controller =
      Get.put(HomeScreen_ViewController());
  HomeScreen({super.key});

  final List<Widget> _screens = [
    Shopscreen(),
    Explorescreen(),
    Cartscreen(),
    Favouritescreen(),
    Accountscreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _screens[controller.selectedIndex.value];
      }),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
