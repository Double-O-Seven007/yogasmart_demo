import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'package:yogasmart_demo/Routes/route_manager.dart';
import 'package:yogasmart_demo/Services/bluetooth_connect.dart';

void main() {
  FlutterBluePlus.setOptions(restoreState: true);
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: false);
  // BTConnect().scanAndAssign;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BTConnect(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteManager.homeScreen,
        onGenerateRoute: RouteManager.routeManager,
      ),
    );
  }
}
