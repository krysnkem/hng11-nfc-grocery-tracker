import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/widget_extensions.dart';
import '../core/constants/pallete.dart';

class AppCard extends StatelessWidget {
  final Color? backgroundColor;
  final Color? borderColor;
  final double? radius;
  final double? widths;
  final double? blurRadius;
  final double? borderWidth;
  final double? spreadRadius;
  final double? heights;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Decoration? decoration;
  final VoidCallback? onTap;
  final bool? expandable;
  final bool? useShadow;
  final bool bordered;
  const AppCard({
    super.key,
    this.backgroundColor,
    this.radius,
    this.widths,
    this.heights,
    this.padding,
    this.margin,
    this.child,
    this.decoration,
    this.onTap,
    this.expandable,
    this.bordered = true,
    this.useShadow,
    this.borderColor,
    this.blurRadius,
    this.spreadRadius,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? 0.0.padH,
      child: InkWell(
        onTap: onTap,
        splashColor:  Colors.grey.shade300,
        highlightColor:  Colors.grey.shade400,
        borderRadius: BorderRadius.circular(radius ?? 8.sp),
        child: Container(
          height: heights,
          width: widths ?? (expandable == true ? null : width(context)),
          padding: padding ?? 16.0.padA,
          decoration: decoration ??
              BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(radius ?? 8.sp),
                  boxShadow: useShadow != true
                      ? null
                      : [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: blurRadius ?? 1,
                              blurStyle: BlurStyle.normal,
                              spreadRadius: spreadRadius ?? 0.5)
                        ],
                  border: bordered == true
                      ? Border.all(
                          color: borderColor ?? const Color(0xFFEAEAEA),
                          width: borderWidth ?? 2)
                      : null),
          child: child,
        ),
      ),
    );
  }
}
