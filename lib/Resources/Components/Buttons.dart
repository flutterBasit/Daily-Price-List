// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Buttons1 extends StatelessWidget {
//   final String title;
//   final GestureTapCallback? onTap;
//   final Color? color;
//   final TextStyle? titleStyle;
//   final String? assetImagePath;
//   const Buttons1(
//       {super.key,
//       required this.title,
//       this.onTap,
//       this.color,
//       this.titleStyle,
//       this.assetImagePath});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: onTap,
//         child: Ink(
//           child: Container(
//             height: 67.h,
//             width: 320.w,
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.all(Radius.circular(19.r)),
//             ), //border: Border.all(color: Colors.black, width: 1.3.w)
//             child: Row(
//               mainAxisAlignment: assetImagePath != null
//                   ? MainAxisAlignment.start
//                   : MainAxisAlignment.center,
//               children: [
//                 if (assetImagePath != null) ...[
//                   SizedBox(
//                     width: 25.w,
//                   ),
//                   Image(
//                     image: AssetImage(assetImagePath!),
//                     width: 24.w, // Recommended to set dimensions
//                     height: 24.w,
//                   ),
//                   SizedBox(width: 30.w), // Space only added when image Exists,
//                 ],
//                 Text(
//                   title,
//                   style: titleStyle,
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// // class Buttons1 extends StatelessWidget {
// //   final String title;
// //   final GestureTapCallback? onTap;
// //   final Color? color;
// //   final TextStyle? titleStyle;
// //   final String? assetImagePath;

// //   const Buttons1({
// //     super.key,
// //     required this.title,
// //     this.onTap,
// //     this.color,
// //     this.titleStyle,
// //     this.assetImagePath,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Material(
// //       borderRadius: BorderRadius.circular(19.r),
// //       color: Colors.transparent,
// //       child: InkWell(
// //         onTap: onTap,
// //         borderRadius: BorderRadius.circular(19.r),
// //         splashColor: Colors.white.withOpacity(0.5),
// //         highlightColor: Colors.black.withOpacity(0.2),
// //         child: Ink(
// //           width: 320.w,
// //           height: 67.h,
// //           decoration: BoxDecoration(
// //             color: color,
// //             borderRadius: BorderRadius.circular(19.r),
// //           ),
// //           child: Row(
// //             mainAxisAlignment: assetImagePath != null
// //                 ? MainAxisAlignment.start
// //                 : MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               if (assetImagePath != null) ...[
// //                 SizedBox(width: 25.w),
// //                 Container(
// //                   width: 24.w,
// //                   height: 24.w,
// //                   child: Image.asset(
// //                     assetImagePath!,
// //                     fit: BoxFit.contain,
// //                   ),
// //                 ),
// //                 SizedBox(width: 30.w),
// //               ],
// //               Text(
// //                 title,
// //                 style: titleStyle ??
// //                     TextStyle(
// //                       fontSize: 18.sp,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white,
// //                     ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// // class Buttons1 extends StatelessWidget {
// //   final String? title;
// //   final IconData? icon;
// //   final Color? color;
// //   final VoidCallback? onTap;

// //   Buttons1({super.key, this.title, this.icon, this.color, this.onTap});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ElevatedButton(
// //       onPressed: () {
// //         onTap?.call();
// //       },
// //       style: ButtonStyle(
// //           backgroundColor: MaterialStateProperty.all(color),
// //           elevation: MaterialStateProperty.all(12.0)),
// //       child: Row(
// //         children: [
// //           Icon(icon),
// //           SizedBox(
// //             width: 20.w,
// //           ),
// //           Text(title.toString())
// //         ],
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// // class Buttons1 extends StatelessWidget {
// //   final String? title;
// //   final IconData? icon;
// //   final Color? color;
// //   final VoidCallback? onTap;
// //   final TextStyle? titleStyle;

// //   const Buttons1({
// //     super.key,
// //     this.title,
// //     this.icon,
// //     this.color,
// //     this.onTap,
// //     this.titleStyle,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       width: 300.w,
// //       height: 60.h,
// //       child: ElevatedButton(
// //         onPressed: onTap,
// //         style: ButtonStyle(
// //           backgroundColor: MaterialStateProperty.all(color ?? Colors.green),
// //           elevation: MaterialStateProperty.all(12.0),
// //           overlayColor:
// //               MaterialStateProperty.all(Colors.white.withOpacity(0.7)),
// //           shape: MaterialStateProperty.all(
// //             RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(19.r),
// //             ),
// //           ),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             if (icon != null) ...[
// //               Icon(icon),
// //               SizedBox(width: 10.w),
// //             ],
// //             Text(
// //               title ?? '',
// //               style: titleStyle ??
// //                   TextStyle(
// //                     fontSize: 16.sp,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.white,
// //                   ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Buttons1 extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final Color? color;
  final TextStyle? titleStyle;
  final String? assetImagePath;

  const Buttons1({
    super.key,
    required this.title,
    this.onTap,
    this.color,
    this.titleStyle,
    this.assetImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(19.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(19.r),
        splashColor: Colors.white.withOpacity(0.3), // light ripple on dark bg
        highlightColor: Colors.white.withOpacity(0.1),
        child: Ink(
          height: 67.h,
          width: 320.w,
          decoration: BoxDecoration(
            color: color ?? Colors.green, // button background here
            borderRadius: BorderRadius.circular(19.r),
          ),
          child: Row(
            mainAxisAlignment: assetImagePath != null
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              if (assetImagePath != null) ...[
                SizedBox(width: 25.w),
                Image.asset(
                  assetImagePath!,
                  width: 24.w,
                  height: 24.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 30.w),
              ],
              Text(
                title,
                style: titleStyle ??
                    TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
