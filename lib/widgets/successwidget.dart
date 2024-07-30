import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';

import '../core/constants/app_images.dart';
import 'app_button.dart';

class succeswidget extends StatelessWidget {
  const succeswidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390.sp,
      height: 462.sp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            "Changes Saved",
            size: 20.sp,
            weight: FontWeight.w600,
          ),
          20.h.sbH,
          AppText(
            "The Item has been restocked",
            size: 14.sp,
            weight: FontWeight.w400,
          ),
          50.h.sbH,
          SvgPicture.asset(AppImages.checkit, width: 127.sp, height: 127.sp),
          60.h.sbH,
          SizedBox(
            width: 358.sp,
            height: 46.sp,
            child: AppButton(
              onTap: () {
                Navigator.pop(context);
              },
              text: "Restock Item",
            ),
          ),
        ],
      ),
    );
  }
}
