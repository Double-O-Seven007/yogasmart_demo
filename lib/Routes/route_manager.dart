import 'package:flutter/material.dart';
import 'package:yogasmart_demo/Screens/home_screen.dart';

class RouteManager {
  static const String homeScreen = '/';

  static Route<dynamic> routeManager(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      default:
        throw const FormatException('There is something wrong with the route');
    }
  }
}
