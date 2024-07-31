import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

import '../core/constants/pallete.dart';
import '../utils/widget_extensions.dart';
import '../widgets/apptext.dart';

Widget toast(String message, {bool success = true, String? title}) {
  return Align(
    alignment: Alignment.topCenter,
    child: SafeArea(
      top: true,
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: 16.sp.padH,
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 14.sp),
            width: double.infinity,
            decoration: BoxDecoration(
                color: !success ? Colors.red : primaryColor,
                borderRadius: BorderRadius.circular(12.sp)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      title != null
                          ? AppText(
                              title ?? "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700),
                            )
                          : 0.0.sbW,
                      title != null ? 2.sp.sbH : 0.0.sbW,
                      AppText(
                        message,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// styled! ?:

showCustomToast(String message,
    {bool success = false, num? time, String? title, int? seconds}) {
  // toast message
  showToastWidget(
    toast(message, success: success, title: title),
    duration: Duration(seconds: seconds ?? 4),
    onDismiss: () {},
  );
}
