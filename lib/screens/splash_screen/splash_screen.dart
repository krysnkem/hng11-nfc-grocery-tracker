import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/core/routes/routes.dart';
import 'package:grocey_tag/screens/main/bottom_navigation.dart';
import 'package:grocey_tag/services/navigation.service.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';

import '../../core/constants/constants.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool? isLogIn = false;
  bool? isUserSetPin = false;
  bool? onBoardingCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // HANDLE NAVIGATION AFTER SPLASH SCREEN
          appRelaunch();
        }
      });
  }
  Future<Object> appRelaunch() async {
    return navigationService.navigateToReplaceWidget(BottomNavigation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: SvgPicture.asset(
                  AppImages.appSplashLogo,
                  height: 90.sp,
                  width: 90.sp
              ),
            ),
            16.sp.sbH,
            AppText("GroceryTag", size: 28.sp, weight: FontWeight.w800,)
          ],
        ),
      ),
    );
  }
}
