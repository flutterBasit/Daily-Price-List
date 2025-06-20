import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Bottomnavbar extends StatelessWidget {
  final HomeScreen_ViewController controller =
      Get.put(HomeScreen_ViewController());

  //list of the compomnets in Nav Bar
  final List<NavItem> items = const [
    NavItem(icon: Icons.shop, label: 'Shop'),
    NavItem(icon: Icons.explore, label: 'Explore'),
    NavItem(icon: Icons.shopping_cart, label: 'Cart'),
    NavItem(icon: Icons.favorite, label: 'Favourite'),
    NavItem(icon: Icons.account_circle, label: 'Account')
  ];
  Bottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            color: ColorsConstants.whiteColor,
            boxShadow: [
              BoxShadow(blurRadius: 10.r, color: Colors.black12),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final selected = controller.selectedIndex.value == index;
            return Expanded(
                child: GestureDetector(
              onTap: () => controller.updateIndex(index),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                decoration: BoxDecoration(
                    color: selected
                        ? Colors.green.withOpacity(
                            0.15,
                          )
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      items[index].icon,
                      color: selected ? Colors.green : Colors.grey,
                      size: selected ? 28 : 24,
                    ),
                    AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: selected
                            ? Text(
                                items[index].label,
                                key: ValueKey(items[index].label),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              )
                            : const SizedBox.shrink())
                  ],
                ),
              ),
            ));
          }),
        ),
      );
    });
  }
}

class NavItem {
  final IconData icon;
  final String label;

  const NavItem({required this.icon, required this.label});
}
