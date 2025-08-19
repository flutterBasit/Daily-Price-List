// import 'package:daily_price_list/Resources/Components/Buttons.dart';
// import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
// import 'package:daily_price_list/ViewModel/AuthViewModel/AuthViewModel.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_instance/get_instance.dart';
// import 'package:get/state_manager.dart';

// class Accountscreen extends StatelessWidget {
//   const Accountscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //get the currently loggedin user
//     // final User? user = FirebaseAuth.instance.currentUser;

//     final _auth = Get.find<Authviewmodel>();

//     return SafeArea(child: Obx(() {
//       final user = _auth.user;
//       if (user == null) {
//         return Center(
//           child: Text('No User Logged In!'),
//         );
//       }
//       return Column(
//         children: [
//           ListTile(
//             leading: CircleAvatar(
//               radius: 40.r,
//               backgroundImage: user.photoURL != null
//                   ? NetworkImage(user.photoURL!)
//                   : AssetImage('assetName') as ImageProvider,
//             ),
//             title: Text(user.displayName ?? 'No name'),
//             subtitle: Text(user.email ?? 'No email'),
//           ),
//           Divider(
//             color: ColorsConstants.whiteColor4,
//           ),
//           Buttons1(
//             title: 'Log Out',
//             titleStyle: TextStyle(color: ColorsConstants.greenColor),
//             assetImagePath: "assets/images/logout.png",
//             color: ColorsConstants.whiteColor5,
//             onTap: () async {
//               // await FirebaseAuth.instance.signOut();
//               // await _auth.signOut();

//               showDialog(
//                 context: context,
//                 barrierDismissible: false,
//                 builder: (context) =>
//                     Center(child: CircularProgressIndicator()),
//               );
//               await _auth.signOut();
//               Navigator.of(context).pop();
//             },
//           )
//         ],
//       );
//     }));
//   }
// }

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
                // ElevatedButton(
                //   onPressed: () => Get.offAllNamed('/signin'),
                //   child: Text('Go to Login'),
                // ),
              ],
            ),
          );
        }

        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 40.r,
                backgroundImage: user.photoURL != null
                    ? NetworkImage(user.photoURL!)
                    : const AssetImage('assets/images/default_avatar.png')
                        as ImageProvider,
              ),
              title: Text(user.displayName ?? 'No name'),
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
                Get.dialog(
                  Center(child: CircularProgressIndicator()),
                  barrierDismissible: false,
                );

                try {
                  await _auth.signOut();
                  // signOut() should handle navigation internally
                } catch (e) {
                  // Close loading dialog on error
                  if (Get.isDialogOpen!) Get.back();
                  Get.snackbar(
                      'Logout Failed', 'Could not sign out: ${e.toString()}');
                }
              },
            )
          ],
        );
      }),
    );
  }
}
