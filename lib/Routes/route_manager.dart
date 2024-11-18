import 'package:flutter/material.dart';
import 'package:yogasmart_demo/Screens/device_list_screen.dart';
import 'package:yogasmart_demo/Screens/home_screen.dart';

class RouteManager {
  static const String homeScreen = '/';
  static const String deviceListScreen = '/deviceListScreen';

  static Route<dynamic> routeManager(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case deviceListScreen:
        return MaterialPageRoute(
          builder: (context) => DeviceListScreen(),
        );
      default:
        throw const FormatException('There is something wrong with the route');
    }
  }
}
