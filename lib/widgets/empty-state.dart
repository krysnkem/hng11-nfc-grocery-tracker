import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:lottie/lottie.dart';

import 'apptext.dart';

class EmptyListState extends StatelessWidget {
  final String text;
  final String lottieFile;
  const EmptyListState(
      {super.key, required this.text, required this.lottieFile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            lottieFile,
            alignment: Alignment.center,
            height: 300.sp,
            width: 300.sp,
          ),
          20.sp.sbH,
          AppText(
            text,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 17.sp),
          )
        ],
      ),
    );
  }
}
