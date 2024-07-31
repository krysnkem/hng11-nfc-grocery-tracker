import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/pallete.dart';

class Styles {

  static ThemeData themeData() {
    return ThemeData(
      fontFamily: 'SF Pro Display',
      primaryColor:primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      unselectedWidgetColor: Colors.black,
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          errorColor: const Color(0xffde3163),
          accentColor: const Color(0xff2FA2B9)
      ).copyWith(
        surface:  Colors.white,
      ),
      indicatorColor: const Color(0xffCBDCF8),

      splashColor: primaryColor.withOpacity(0.2),
      highlightColor: primaryColor.withOpacity(0.2),
      hoverColor: const Color(0xff4285F4),

      focusColor: const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      iconTheme: IconThemeData(
        color: blackColor
      ),
      dividerColor: Colors.grey.shade100,
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: blackColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: hintColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
        ),
        titleLarge: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: blackColor
        ),
      ),
      cardColor: whiteColor,
      brightness: Brightness.light,
      appBarTheme:  AppBarTheme(
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        color: Colors.transparent,
        foregroundColor: blackColor,
        iconTheme: IconThemeData(color: blackColor),
        titleTextStyle: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          color: blackColor,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      shadowColor: Colors.grey,
    );

  }
}