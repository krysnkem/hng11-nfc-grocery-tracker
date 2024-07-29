import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';

class filterbutton extends StatelessWidget {
  final VoidCallback? onTap;
  const filterbutton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/svg/filter.svg",
            width: 16,
            height: 16,
          ),
          10.w.sbW,
          AppText(
            "Filter",
            size: 12,
          )
        ],
      ),
    );
  }
}
