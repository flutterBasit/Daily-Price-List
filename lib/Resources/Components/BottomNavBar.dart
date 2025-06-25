import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Bottomnavbar extends StatelessWidget {
  final HomeScreen_ViewController controller =
      Get.put(HomeScreen_ViewController());

  //list of the compomnets in Nav Bar
  final List<NavItem> items = [
    NavItem(
        icon: Image.asset(
          'assets/icons/store.png',
          height: 24.h,
          width: 24.h,
        ),
        label: 'Shop'),
    NavItem(
        icon: Image.asset(
          'assets/icons/explore.png',
          height: 24.h,
          width: 24.h,
        ),
        label: 'Explore'),
    NavItem(
        icon: Image.asset(
          'assets/icons/cart.png',
          height: 24.h,
          width: 24.h,
        ),
        label: 'Cart'),
    NavItem(
        icon: Image.asset(
          'assets/icons/favourite.png',
          height: 24.h,
          width: 24.h,
        ),
        label: 'Favourite'),
    NavItem(
        icon: Image.asset(
          'assets/icons/account.png',
          height: 24.h,
          width: 24.h,
        ),
        label: 'Account')
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   items[index].icon,
                    //   color: selected ? Colors.green : Colors.grey,
                    //   size: selected ? 28 : 24,
                    // ),

                    Builder(builder: (_) {
                      Color iconColor = selected ? Colors.green : Colors.black;
                      ColorFilter? colorfilter =
                          ColorFilter.mode(iconColor, BlendMode.srcATop);

                      return SizedBox(
                        height: 24.h,
                        width: 24.h,
                        child: ColorFiltered(
                          colorFilter: colorfilter,
                          child: items[index].icon,
                        ),
                      );
                    }),
                    AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: selected
                            ? Text(
                                items[index].label,
                                key: ValueKey(items[index].label),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.sp,
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
  final Image icon;
  final String label;

  const NavItem({required this.icon, required this.label});
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import '../../ViewModel/HomeScreen_ViewModel.dart';
// import '../Constants/Colors_Constants.dart';

// // NavItem model is declared here for simplicity
// class NavItem {
//   final String iconPath;
//   final String label;

//   const NavItem({required this.iconPath, required this.label});
// }

// class Bottomnavbar extends StatelessWidget {
//   final HomeScreen_ViewController controller =
//       Get.put(HomeScreen_ViewController());

//   final List<NavItem> items = const [
//     NavItem(iconPath: 'assets/icons/store.svg', label: 'Shop'),
//     NavItem(iconPath: 'assets/icons/explore.svg', label: 'Explore'),
//     NavItem(iconPath: 'assets/icons/cart.svg', label: 'Cart'),
//     NavItem(iconPath: 'assets/icons/favourite.svg', label: 'Favourite'),
//     NavItem(iconPath: 'assets/icons/account.svg', label: 'Account'),
//   ];

//   Bottomnavbar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Container(
//         height: 70.h,
//         padding: EdgeInsets.symmetric(horizontal: 10.w),
//         decoration: BoxDecoration(
//           color: ColorsConstants.whiteColor,
//           boxShadow: [
//             BoxShadow(blurRadius: 10.r, color: Colors.black12),
//           ],
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16.r),
//             topRight: Radius.circular(16.r),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: List.generate(items.length, (index) {
//             final selected = controller.selectedIndex.value == index;
//             return Expanded(
//               child: GestureDetector(
//                 onTap: () => controller.updateIndex(index),
//                 child: AnimatedContainer(
//                   duration: Duration(milliseconds: 300),
//                   padding:
//                       EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
//                   decoration: BoxDecoration(
//                     color: selected
//                         ? Colors.green.withOpacity(0.15)
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(20.r),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         items[index].iconPath,
//                         height: 24.h,
//                         width: 24.h,
//                         color: selected ? Colors.green : Colors.grey,
//                       ),
//                       AnimatedSwitcher(
//                         duration: Duration(milliseconds: 200),
//                         child: selected
//                             ? Text(
//                                 items[index].label,
//                                 key: ValueKey(items[index].label),
//                                 style: TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 11.sp,
//                                 ),
//                               )
//                             : const SizedBox.shrink(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       );
//     });
//   }
// }
