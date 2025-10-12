import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/Resources/Constants/Strings_Constants.dart';
import 'package:daily_price_list/ViewModel/AuthViewModel/AuthViewModel.dart';
import 'package:daily_price_list/ViewModel/DropDown_ViewModel.dart';
import 'package:daily_price_list/ViewModel/HomeScreen_ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Accountscreen extends StatelessWidget {
  const Accountscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = Get.find<Authviewmodel>();
    final controller = Get.put(HomeScreen_ViewController());
    final DropdownController controller2 = Get.find<DropdownController>();
    return SafeArea(
      child: Obx(() {
        final user = _auth.user;
        if (user == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No User Logged In!'),
                SizedBox(height: 20.h),
              ],
            ),
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 40.r,
                backgroundImage:
                    user.photoURL != null ? NetworkImage(user.photoURL!) : null,
                backgroundColor: ColorsConstants.whiteColor5,
                child: user.photoURL == null
                    ? Icon(
                        Icons.person,
                        color: ColorsConstants.greenColor,
                      )
                    : null,
              ),
              title: Text(
                user.displayName ?? 'Unknown',
                style: StringsConstants.AccountScreenDetailsTitle,
              ),
              subtitle: Text(user.email ?? 'No email'),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(
              color: ColorsConstants.whiteColor4,
            ),
            //----------------------ORDERS-------------------------
            Obx(() {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.ShowOrderDetails.toggle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              //Icon(Icons.shopping_bag),
                              Image.asset("assets/icons/orderIcon.png"),
                              SizedBox(
                                width: 15.w,
                              ),
                              Text(
                                "Orders",
                                style: StringsConstants
                                    .AccountScreenDetailsSubtitle,
                              ),
                            ],
                          ),
                          Icon(controller.ShowOrderDetails.value
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    if (controller.ShowOrderDetails.value) ...[
                      Text(
                        'Your Orders',
                        style: StringsConstants.CheckoutScreenDetailsSubtitle,
                      ),
                      Obx(() {
                        if (controller.orderHistory.isEmpty) {
                          return Text("No Orders yet.");
                        }
                        return Column(
                            children: List.generate(
                                controller.orderHistory.length, (index) {
                          final order = controller.orderHistory[index];
                          final isExpanded = controller.orderExpanded[index];

                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 3,
                            child: ExpansionTile(
                              initiallyExpanded: isExpanded,
                              onExpansionChanged: (value) {
                                controller.orderExpanded[index] = value;
                              },
                              title: Text(
                                "Order ${index + 1}",
                                style:
                                    StringsConstants.CheckoutScreenDetailsTitle,
                              ),
                              subtitle: Text("Date: ${order['date']}"),
                              childrenPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Delivery Method: ${order['deliveryMethod']}"),
                                    Text(
                                        "Payment Method: ${order['paymentMethod']}"),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text('Items: '),
                                    ...List.generate(order['items'].length,
                                        (i) {
                                      final item = order['items'][i];
                                      return Row(
                                        children: [
                                          Expanded(
                                              child:
                                                  Text(". ${item['title']}")),
                                          Text("X${item['quantity']}")
                                        ],
                                      );
                                    }),
                                    const Divider(
                                      color: ColorsConstants.whiteColor4,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "Total: \$${order['total'].toStringAsFixed(2)}"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }));
                      })
                    ]
                  ],
                ),
              );
            }),
            const Divider(
              color: ColorsConstants.whiteColor4,
            ),
            //------------------------MY DETAILS-------------------------------------
            Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.showMyDetails.toggle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/icons/myDetailsIcon.png"),
                              SizedBox(
                                width: 15.w,
                              ),
                              Text(
                                "My Details",
                                style: StringsConstants
                                    .AccountScreenDetailsSubtitle,
                              )
                            ],
                          ),
                          Icon(controller.showMyDetails.value
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    if (controller.showMyDetails.value) ...[
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Name : ${user.displayName}",
                        style: StringsConstants.CheckoutScreenDetailsSubtitle,
                      ),
                      Text(
                        "Email Adress : ${user.email}",
                        style: StringsConstants.CheckoutScreenDetailsSubtitle,
                      ),
                      Text(
                        "      LOCATION",
                        style: StringsConstants.CheckoutScreenDetailsTitle,
                      ),
                      Text(
                        "Province : ${controller2.selectedProvine.value.toString()}",
                        style: StringsConstants.CheckoutScreenDetailsSubtitle,
                      ),
                      Text(
                        "District : ${controller2.selectedDistrict.value.toString()}",
                        style: StringsConstants.CheckoutScreenDetailsSubtitle,
                      ),
                      Text(
                        "Zone : ${controller2.selectedZone.value.toString()}",
                        style: StringsConstants.CheckoutScreenDetailsSubtitle,
                      )
                    ]
                  ],
                ),
              );
            }),
            const Divider(
              color: ColorsConstants.whiteColor4,
            ),
            //-------------------DELIVERY ADRESS---------------------
            Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.showDeliveryAddress.toggle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                  "assets/icons/deliveryAdressIcon.png"),
                              SizedBox(
                                width: 15.w,
                              ),
                              Text(
                                "Delivery Address",
                                style: StringsConstants
                                    .AccountScreenDetailsSubtitle,
                              ),
                            ],
                          ),
                          Icon(controller.showDeliveryAddress.value
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    if (controller.showDeliveryAddress.value) ...[
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Selected Location : \n${controller2.selectedZone.value.toString()}, ${controller2.selectedDistrict.value.toString()}, ${controller2.selectedProvine.value.toString()}",
                        style: StringsConstants.CheckoutScreenDetailsSubtitle,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Add Delivery Address : ",
                        style: StringsConstants.CheckoutScreenDetailsSubtitle,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Add Secondary Delivery Address...',
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorsConstants.greenColor),
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.send_and_archive_rounded,
                                color: ColorsConstants.greenColor,
                                size: 40,
                              ))
                        ],
                      )
                    ]
                  ],
                ),
              );
            }),
            //---------------LOGOUT BUTTON-----------------------
            Buttons1(
              title: 'Log Out',
              titleStyle: TextStyle(color: ColorsConstants.greenColor),
              assetImagePath: "assets/images/logout.png",
              color: ColorsConstants.whiteColor5,
              onTap: () async {
                _showDilogueforLogOut(context, _auth);
              },
            )
          ],
        );
      }),
    );
  }
}

void _showDilogueforLogOut(BuildContext context, Authviewmodel auth) {
  Get.dialog(
      AlertDialog(
        title: Text('Confirm Logout'),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text("Close")),
          TextButton(
              onPressed: () async {
                Get.back();
                Get.dialog(
                  Center(child: CircularProgressIndicator()),
                  barrierDismissible: false,
                );

                try {
                  await auth.signOut();
                  // signOut() should handle navigation internally
                } catch (e) {
                  // Close loading dialog on error
                  if (Get.isDialogOpen!) Get.back();
                  Get.snackbar(
                      'Logout Failed', 'Could not sign out: ${e.toString()}');
                }
              },
              child: Text("Log out"))
        ],
        shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(16.r)),
      ),
      barrierDismissible: true);
}
