import 'package:daily_price_list/Resources/Components/Buttons.dart';
import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:daily_price_list/ViewModel/AuthViewModel/AuthViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Accountscreen extends StatelessWidget {
  const Accountscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = Get.find<Authviewmodel>();

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
              title: Text(user.displayName ?? 'Unknown'),
              subtitle: Text(user.email ?? 'No email'),
            ),
            Divider(
              color: ColorsConstants.whiteColor4,
            ),
            Buttons1(
              title: 'Log Out',
              titleStyle: TextStyle(color: ColorsConstants.greenColor),
              assetImagePath: "assets/images/logout.png",
              color: ColorsConstants.whiteColor5,
              onTap: () async {
                // Show loading dialog
                // Get.dialog(
                //   Center(child: CircularProgressIndicator()),
                //   barrierDismissible: false,
                // );

                // try {
                //   await _auth.signOut();
                //   // signOut() should handle navigation internally
                // } catch (e) {
                //   // Close loading dialog on error
                //   if (Get.isDialogOpen!) Get.back();
                //   Get.snackbar(
                //       'Logout Failed', 'Could not sign out: ${e.toString()}');
                // }
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
