import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/screens/main/inventory/inventory.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';

class Filterbutton extends ConsumerWidget {
  const Filterbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              SvgPicture.asset(
                AppImages.filter,
                width: 16.sp,
                height: 16.sp,
              ),
              10.w.sbW,
              AppText(
                ref.watch(sortCriteriaProvider) ?? "Filter",
                size: 12.sp,
              )
            ],
          ),
        ),
      ],
    );
  }
}
