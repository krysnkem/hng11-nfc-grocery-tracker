import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';

import '../core/constants/constants.dart';
import '../widgets/bottomSheet.dart';
import 'action-pop-up.dart';

Future<T?>appBottomSheet<T>(Widget child, {double? height}) async {
  BuildContext context = navigationService.navigatorKey.currentState!.context;
  return showModalBottomSheet(
    backgroundColor: Colors.grey.withOpacity(0.05),
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    builder: (_) => Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.sp),
                  topRight: Radius.circular(16.sp),
                ),
                child: Container(
                    width: width(context),
                    height: height,
                    padding: 16.0.padA,
                    color: Colors.white,
                    child: IntrinsicHeight(
                        child: child
                    )
                )),
          )
        ],
      ),
    ),
  );
}