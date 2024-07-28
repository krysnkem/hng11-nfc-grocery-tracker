import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';

import '../../../../widgets/apptext.dart';

class ActivityHistoryItem extends StatelessWidget {
  final String title;
  final String date;
  final String? measureUnit;
  final num quantity;
  const ActivityHistoryItem({
    super.key, required this.title, required this.date, this.measureUnit, required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.sp.padB,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    size: 16.sp,
                    weight: FontWeight.w500,
                  ),
                  2.sp.sbH,
                  AppText(
                    date,
                    size: 12.sp,
                    color: const Color(0xFF434343),
                  ),

                ],
              )
          ),
          AppText(
            "${quantity.toString()} ${measureUnit??""}",
            color: const Color(0xFF434343),
            size: 16.sp,
          )
        ],
      ),
    );
  }
}