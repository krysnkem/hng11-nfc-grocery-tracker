import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/core/models/activity.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/apptext.dart';

class ActivityHistoryItem extends StatelessWidget {
  final Activity activity;
  const ActivityHistoryItem({
    super.key,
    required this.activity,
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
                activity.itemName,
                size: 16.sp,
                weight: FontWeight.w500,
              ),
              2.sp.sbH,
              AppText(
                DateFormat('d MMMM \'at\' HH:mm').format(activity.date),
                size: 12.sp,
                color: const Color(0xFF434343),
              ),
            ],
          )),
          AppText(
            "${activity.operation == Operation.add ? '+ ' : '- '}${activity.quantity} ${activity.metric.name.toUpperCase()}",
            color: const Color(0xFF434343),
            size: 16.sp,
          )
        ],
      ),
    );
  }
}
