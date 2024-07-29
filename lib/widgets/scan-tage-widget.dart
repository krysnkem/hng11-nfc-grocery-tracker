import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/core/constants/constants.dart';
import 'package:grocey_tag/core/constants/pallete.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/app_button.dart';
import 'package:grocey_tag/widgets/apptext.dart';

class ScanTagWidget extends StatelessWidget {
  final VoidCallback onTap;
  const ScanTagWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText("Scan Item Tag", size: 20.sp, weight: FontWeight.w600,),
          const AppText("Hold your phone unto the NFC tag"),
          SvgPicture.asset(
            AppImages.scan,
            height: 197.sp,
            width: 146.sp,
          ),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  isOutline: true,
                  text: "Cancel",
                  onTap: navigationService.goBack,
                  textColor: primaryColor,
                  borderColor: primaryColor,
                ),
              ),
              16.sp.sbW,
              Expanded(
                child: AppButton(
                  text: "Proceed",
                  onTap: (){
                    navigationService.goBack();
                    onTap();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
