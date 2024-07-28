import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/app-card.dart';
import 'package:grocey_tag/widgets/app_button.dart';
import 'package:grocey_tag/widgets/apptext.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    bool show = true;

    return Scaffold(
      appBar:show?  AppBar(
        title: Text("Welcome back!"),
      ): null,
      body: show?
      ListView(
        padding: EdgeInsets.only(top: 10.sp, left: 16.sp, right: 16.sp),
        children: [
          AppText(
            "Inventory Summary:",
            size: 16.sp,
            weight: FontWeight.w500,
          ),
          16.sp.sbH,
          AppCard()
        ],
      ):
      Padding(
        padding: 16.sp.padA,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.noContent,
              height: 150.sp,
              width: 150.sp,
            ),
            10.sp.sbH,
            AppText(
              "Welcome to GroceyTag",
              size: 22.sp,
              isBold: true,
            ),
            4.sp.sbH,
            AppText(
              "Start managing your groceries\neffectively with NFC tags",
              align: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            20.sp.sbH,
            AppButton(
              onTap: (){},
              text: "Register Your first Item",
            )
          ],
        ),
      ),
    );
  }
}
