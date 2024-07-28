import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey<ScaffoldMessengerState>();

  Future<dynamic> navigateTo(String routeName, {dynamic argument}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: argument);
  }

  Future<dynamic> navigateToReplaceWidget(Widget route) {
    return navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_) => route));
  }

  Future<dynamic> navigateToReplace(String routeName, {dynamic argument}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: argument);
  }

  Future<dynamic> navigateToAndRemoveUntil(String routeName, {dynamic argument}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  Future<dynamic> navigateToAndRemoveUntilWidget(Widget route) {
    return navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (_) => route), (route) => false);
  }

  void goBack({dynamic value}) {
    return navigatorKey.currentState!.pop(value);
  }
}
