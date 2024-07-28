import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/widget_extensions.dart';
import '../core/constants/pallete.dart';
import 'apptext.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isTransparent;
  final bool isOutline;
  final bool? noHeight;
  final double? borderWidth;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? textSize;
  final Color? borderColor;
  final Color? backGroundColor;
  final Color? textColor;
  final String? text;
  final List<Color>? gradientColors;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final bool? isLoading;
  final bool isExpanded;

  const AppButton(
      {Key? key,
      this.onTap,
      this.isTransparent = false,
      this.isOutline = false,
      this.isLoading,
      this.gradientColors,
      this.child,
      this.width,
      this.borderWidth,
      this.borderColor,
      this.textColor,
      this.backGroundColor,
      this.text, this.borderRadius, this.padding, this.height, this.textSize, this.isExpanded = true, this.noHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isExpanded? Expanded(child: buttonBuild()): buttonBuild(),
      ],
    );
  }

  Material buttonBuild() {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading == true ? null : onTap,
          borderRadius: BorderRadius.circular(borderRadius?? 8.sp),
          child: Container(
            height: noHeight==true? null: height ?? 46.sp,
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius??5),
              border: isTransparent? null:  Border.all(
                  width: borderWidth ?? 1.sp,
                  color: borderColor != null? (onTap == null || isLoading==true? borderColor!.withOpacity(0.5) : borderColor!) : (onTap == null || isLoading==true? (!isOutline? primaryColor.withOpacity(0.5) :blackColor.withOpacity(0.5)): (!isOutline? primaryColor: blackColor))),
              color: isOutline || isTransparent? Colors.transparent
                  : backGroundColor!=null? (onTap == null || isLoading==true? backGroundColor!.withOpacity(0.5): backGroundColor) : (onTap == null || isLoading==true? primaryColor.withOpacity(0.5): primaryColor),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Padding(
                    padding:
                        padding?? EdgeInsets.symmetric(horizontal: 5.sp, vertical: 5.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        child ??
                                AppText(
                                  text ?? "",
                                  isBold: true,
                                  color: textColor?? (isTransparent == true ? (onTap == null || isLoading==true? primaryColor.withOpacity(0.5): primaryColor): isOutline == true ? (onTap == null || isLoading==true? blackColor.withOpacity(0.5): blackColor): whiteColor),
                                  align: TextAlign.center,
                                  size: textSize,
                                ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
  }
}
