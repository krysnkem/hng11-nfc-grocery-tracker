import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

import 'core/routes/router.dart';
import 'core/styles/app_style.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'services/navigation.service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  FocusManager.instance.primaryFocus?.unfocus();

  runApp(const MyApp());
  (dynamic error, dynamic stack) {
    if (kDebugMode) {
      print(error);
      print(stack);
    }
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: OKToast(
          child: ScreenUtilInit(
        //setup to fit into bigger screens
        designSize: const Size(390, 846),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService().navigatorKey,
            scaffoldMessengerKey: NavigationService().snackBarKey,
            title: "GroceryTag",
            theme: Styles.themeData(),
            onGenerateRoute: Routers.generateRoute,
            home: const SplashScreen(),
          );
        },
      )),
    );
  }
}
