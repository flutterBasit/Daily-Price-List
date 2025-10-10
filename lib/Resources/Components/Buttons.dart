import 'package:daily_price_list/Resources/Constants/Colors_Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Buttons1 extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;
  final Color color;
  final TextStyle? titleStyle;
  final String? assetImagePath;
  final Widget? child;
  final bool isLaoding;
  final String? subtitle;

  const Buttons1({
    super.key,
    required this.title,
    this.onTap,
    this.color = Colors.green, // default color
    this.titleStyle,
    this.assetImagePath,
    this.isLaoding = false,
    this.child,
    this.subtitle,
  });

  // //function  to determine  text color
  // Color getTextColor(Color BackgroundColor) {
  //   return ThemeData.estimateBrightnessForColor(BackgroundColor) ==
  //           Brightness.light
  //       ? Colors.black
  //       : Colors.white;
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(19.r),
          child: Ink(
            width: 320.w,
            height: 67.h,
            decoration: BoxDecoration(
              color: isLaoding ? color.withOpacity(0.7) : color,
              borderRadius: BorderRadius.circular(19.r),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(19.r),
              splashColor: isLaoding
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.3),
              highlightColor: isLaoding
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.1),
              onTap: isLaoding ? null : onTap,
              child: isLaoding
                  ? Center(
                      child: SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ColorsConstants.whiteColor,
                          ),
                          strokeWidth: 2.0,
                        ),
                      ),
                    )
                  : child ??
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Center title
                          Text(
                            title,
                            style: titleStyle ??
                                TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),

                          // Image (left)
                          if (assetImagePath != null)
                            Positioned(
                              left: 15.w,
                              child: Image.asset(
                                assetImagePath!,
                                width: 24.w,
                                height: 24.h,
                                fit: BoxFit.contain,
                              ),
                            ),

                          // Subtitle (right)
                          if (subtitle != null)
                            Positioned(
                              right: 7.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF489E67),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  subtitle!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
