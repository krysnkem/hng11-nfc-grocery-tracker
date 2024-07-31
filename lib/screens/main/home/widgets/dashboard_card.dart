import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/pallete.dart';
import '../../../../widgets/app-card.dart';
import '../../../../widgets/apptext.dart';

class DashBoardCard extends StatelessWidget {
  final int count;
  final String title;
  final String svgImage;
  final VoidCallback? onTap;
  const DashBoardCard({
    super.key, required this.count, required this.title, required this.svgImage, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppCard(
        onTap: onTap,
        heights: 92.sp,
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(count.toString(), size: 22.sp, weight: FontWeight.w600,),
                SvgPicture.asset(
                  svgImage, color: primaryColor,
                  height: 24.sp, width: 24.sp,
                )
              ],
            ),
            AppText(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16.sp),
            )
          ],
        ),
      ),
    );
  }
}

class DashNavigateCard extends StatelessWidget {
  final VoidCallback onTap;
  const DashNavigateCard({
    super.key, required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppCard(
        onTap: onTap,
        heights: 92.sp,
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              "View inventory",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16.sp),
            ),
            Icon(Icons.arrow_forward_ios, size: 24.sp, color: primaryColor.withOpacity(0.8))
          ],
        ),
      ),
    );
  }
}