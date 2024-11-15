import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:yogasmart_demo/Routes/route_manager.dart';

void main() {
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.homeScreen,
      onGenerateRoute: RouteManager.routeManager,
    );
  }
}
