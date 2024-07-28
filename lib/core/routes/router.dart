import 'package:flutter/material.dart';

import '../../screens/main/bottom_navigation.dart';
import '../../screens/on_boarding/on_boarding_screen.dart';
import 'routes.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ONBOARDING:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case HOMEROUTE:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());


      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
