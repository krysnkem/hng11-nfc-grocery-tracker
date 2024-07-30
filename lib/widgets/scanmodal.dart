import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/screens/main/shoppinglist.dart/restockitem.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/app_button.dart';
import 'package:grocey_tag/widgets/apptext.dart';

class ScanModalwidget extends StatelessWidget {
  final String itemName;
  final bool checked;
  const ScanModalwidget({
    super.key,
    required this.itemName,
    required this.checked,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390.sp,
      height: 462.sp,
      child: PageView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              "Scan Item Tag",
              size: 20.sp,
              weight: FontWeight.w600,
            ),
            20.h.sbH,
            AppText(
              "Hold your Phone unto the NFC tag",
              size: 14.sp,
              weight: FontWeight.w400,
            ),
            50.h.sbH,
            SvgPicture.asset(AppImages.scan),
            30.h.sbH,
            TextButton(
                onPressed: () {},
                child: AppText(
                  "Cancel",
                  color: Colors.green,
                ))
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              "Item Confirmed",
              size: 20.sp,
              weight: FontWeight.w600,
            ),
            20.h.sbH,
            AppText(
              "You can now update the quantity of this item",
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
                  if (checked) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Restockitem(itemName: itemName),
                      ),
                    );
                  }
                },
                text: "Restock Item",
              ),
            ),
          ],
        )
      ]),
    );
  }
}
