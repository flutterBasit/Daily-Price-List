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

  const Buttons1(
      {super.key,
      required this.title,
      this.onTap,
      this.color = Colors.green, // default color
      this.titleStyle,
      this.assetImagePath,
      this.isLaoding = false,
      this.child,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Material(
          color: Colors.transparent, // transparent wrapper
          borderRadius: BorderRadius.circular(19.r),
          child: Ink(
            width: 320.w,
            height: 67.h,
            decoration: BoxDecoration(
              color: isLaoding
                  ? color.withOpacity(0.7)
                  : color, // Button background
              borderRadius: BorderRadius.circular(19.r),
            ),
            child: InkWell(
                borderRadius: BorderRadius.circular(19.r),
                splashColor: isLaoding
                    ? Colors.transparent
                    : Colors.white.withOpacity(0.3), // visible ripple
                highlightColor: isLaoding
                    ? Colors.transparent
                    : Colors.white.withOpacity(0.1),
                onTap: isLaoding ? null : onTap,
                child: Center(
                  child: isLaoding
                      ? SizedBox(
                          height: 24.h,
                          width: 24.w,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                ColorsConstants.whiteColor),
                            strokeWidth: 2.0,
                          ),
                        )
                      : child ??
                          Row(
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
                              ] else ...[
                                Text(
                                  title,
                                  style: titleStyle ??
                                      TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                              SizedBox(width: 30.w),
                              if (subtitle != null) ...[
                                Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: Text(
                                    subtitle!,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                )),
          ),
        ),
      ),
    );
  }
}
