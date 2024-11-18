import 'package:flutter/material.dart';
import 'package:yogasmart_demo/Screens/connected_devices_screen.dart';
import 'package:yogasmart_demo/Screens/device_list_screen.dart';
import 'package:yogasmart_demo/Screens/home_screen.dart';
import 'package:yogasmart_demo/Screens/paired_devices.dart';

class RouteManager {
  static const String homeScreen = '/';
  static const String deviceListScreen = '/deviceListScreen';
  static const String connectedDeviceScreen = '/connectedDeviceScreen';
  static const String pairedDeviceScreen = '/pairedDeviceScreen';

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
      case connectedDeviceScreen:
        return MaterialPageRoute(
          builder: (context) => ConnectedDevicesScreen(),
        );
      case pairedDeviceScreen:
        return MaterialPageRoute(
          builder: (context) => PairedDeviceScreen(),
        );
      default:
        throw const FormatException('There is something wrong with the route');
    }
  }
}
