import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSearchbar extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? borderColor;
  final double? borderWidth;
  final Color? backgroundColor;
  const AppSearchbar(
      {super.key,
      this.width,
      this.height,
      this.borderColor,
      this.borderWidth,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(
              width: borderWidth ?? 1.sp, color: borderColor ?? Colors.grey)),
      child: CupertinoSearchTextField(
        prefixIcon: Icon(
          Icons.search,
          size: 16,
        ),
        placeholder: "Search",
        placeholderStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
        style: TextStyle(),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
