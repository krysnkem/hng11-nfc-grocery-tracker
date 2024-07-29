import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';
import 'package:grocey_tag/widgets/inputbox.dart';

import '../../../widgets/app_button.dart';

class Itemsdetails extends StatelessWidget {
  const Itemsdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "Item Details",
              size: 22.sp,
              weight: FontWeight.w600,
            ),
            AppText(
              "Details of items in inventory",
              size: 12.sp,
              weight: FontWeight.w400,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: 16.sp.padA,
        child: Column(
          children: [
            Inputboxes(
              text: "Item Name",
              width: 358,
              height: 48,
            ),
            20.h.sbH,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                QuantityInput(text: "Quantity", width: 283, height: 48),
                quantity()
              ],
            ),
            20.h.sbH,
            Inputboxes(
              text: "Purchase Date",
              width: 358,
              height: 48,
              prefixpath: Icon(
                Icons.calendar_month,
                size: 16,
              ),
            ),
            20.h.sbH,
            Inputboxes(
              text: "Expiry Date",
              width: 358,
              height: 48,
              prefixpath: Icon(
                Icons.calendar_month,
                size: 16,
              ),
            ),
            20.h.sbH,
            Inputboxes(
              text: "Additional Notes",
              width: 358,
              height: 48,
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    onTap: () {},
                    isOutline: true,
                    text: "Cancel",
                  ),
                ),
                16.sp.sbW,
                Expanded(
                  child: AppButton(
                    onTap: () {},
                    text: "Save",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
