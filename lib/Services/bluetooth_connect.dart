import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BTConnect with ChangeNotifier {
  DeviceIdentifier? id;
  late BluetoothDevice? _bluetoothDevice = BluetoothDevice(
    remoteId: DeviceIdentifier(id.toString()),
  );
  BluetoothAdapterState _btAdapterState = BluetoothAdapterState.unknown;
  // int? index;
// first, check if bluetooth is supported by your hardware
// Note: The platform is initialized on the first call to any FlutterBluePlus method.
  Future btSupportCheck() async {
    if (await FlutterBluePlus.isSupported == false) {
      print("Bluetooth not supported by this device");
      notifyListeners();
      return;
    }
  }

  set bluetoothDevice(BluetoothDevice? device) {
    if (device!.platformName.isNotEmpty) {
      _bluetoothDevice = device;
      // selectDevice(device);
      print('set device: ${bluetoothDevice}');
    }
    notifyListeners();
  }

//get btDevice
  BluetoothDevice? get bluetoothDevice => _bluetoothDevice;
  //init when scan results are found
  // Future<void> assignDevice(ScanResult scanResult) async {
  //   bluetoothDevice = scanResult.device;
  //   notifyListeners();
  // }

// handle bluetooth on & off
// note: for iOS the initial state is typically BluetoothAdapterState.unknown
// note: if you have permissions issues you will get stuck at BluetoothAdapterState.unauthorized
  Future btOnOff() async {
    await FlutterBluePlus.adapterState
        .listen((BluetoothAdapterState state) {
          _btAdapterState = state;
          // print(_btAdapterState);
          if (_btAdapterState == BluetoothAdapterState.on) {
            // scanDevices();
            print('Scanning...');
            scanAndAssign();
          } else if (_btAdapterState == BluetoothAdapterState.off) {
            // show an error to the user, etc
          } else if (_btAdapterState == BluetoothAdapterState.turningOn) {
            CircularProgressIndicator();
          } else if (_btAdapterState == BluetoothAdapterState.turningOff) {
            print('Bluetooth off in progress. Tunr Bluetooth back on');
          } else if (_btAdapterState == BluetoothAdapterState.unavailable) {
            print('Bluetooth unavailable on your device');
          }
        })
        .asFuture()
        .catchError(
          ((value) {
            print('Future error: ${value.toString()}');
          }),
        );
    notifyListeners();
  }

//Scan results getter
  // int get scanResultsVar => _scanResultsLength;
// turn on bluetooth ourself if we can
// for iOS, the user controls bluetooth enable/disable
  Future turnOnBTManually() async {
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
    notifyListeners();
  }

// cancel to prevent duplicate listeners
// subscription.cancel();

//!Scan Devices
// listen to scan results
// Note: `onScanResults` clears the results between scans. You should use
//  `scanResults` if you want the current scan results *or* the results from the previous scan.
  // Future scanDevices() async {
  //   if (_btAdapterState == BluetoothAdapterState.on) {
  //     FlutterBluePlus.startScan(
  //       timeout: const Duration(seconds: 10),
  //     );

  //     await FlutterBluePlus.scanResults.listen((results) {
  //       ScanResult scanResult = results.first;
  //       _bluetoothDevice = scanResult.device;
  //       assignDevice(scanResult);
  //     });
  //   }
  //   notifyListeners();
  // }

  Future<void> scanAndAssign() async {
    await FlutterBluePlus.scanResults.listen((results) {
      if (results.isNotEmpty) {
        // Automatically pick the first device
        bluetoothDevice = results.first.device;
        print(
            "Device assigned: ${bluetoothDevice!.advName}, remote: ${bluetoothDevice!.remoteId}");
        notifyListeners();
      }
    });
    FlutterBluePlus.startScan(timeout: Duration(seconds: 10));
  }

//Get Scaned devices
  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

// select device
  // Future<void> selectDevice(BluetoothDevice device) async {
  //   bluetoothDevice = await device;
  //   FlutterBluePlus.startScan(timeout: Duration(seconds: 10));
  //   print('Selected: ${bluetoothDevice!.platformName.toString()}');
  //   notifyListeners();
  // }

  // StreamSubscription<List<ScanResult>> scanResults() {
  //   return FlutterBluePlus.onScanResults.listen(
  //     (results) {
  //       if (results.isNotEmpty) {
  //         ScanResult r = results.last; // the most recently found device
  //         // _bluetoothDevice = r.device;
  //         _scanResultsLength = results.length;
  //         devicesFound = results.length;

  //         // print(
  //         //     '${r.device.remoteId}: "${r.advertisementData.advName}" found!');
  //         notifyListeners();
  //       } else if (results.isEmpty) {
  //         print('No devices found');
  //         FlutterBluePlus.stopScan();
  //         notifyListeners();
  //       }
  //       // FlutterBluePlus.stopScan();
  //       notifyListeners();
  //     },
  //     onError: (e) {
  //       FlutterBluePlus.stopScan();
  //       print(e);
  //       notifyListeners();
  //     },
  //   );
  // }

// Wait for Bluetooth enabled & permission granted
// In your real app you should use `FlutterBluePlus.adapterState.listen` to handle all states
// ?Refererence code for waiting for bluetooth connections
  void btPermissionGranted() async {
    await FlutterBluePlus.adapterState.listen;
    notifyListeners();
  }

// await FlutterBluePlus.adapterState.where((val) => val == BluetoothAdapterState.on).first;

// Start scanning w/ timeout
// Optional: use `stopScan()` as an alternative to timeout
  void stopScan() async {
    await FlutterBluePlus.startScan(
      withServices: [Guid("180D")], // match any of the specified services
      withNames: ["Bluno"], // *or* any of the specified names
      timeout: Duration(seconds: 15),
    );
    notifyListeners();
  }

  //!Connect To A Device

  // listen for disconnection
  void listenForDisconnection() {
    // selectDevice(_bluetoothDevice!);
    var onDisconnected = bluetoothDevice!.connectionState.listen(
      (BluetoothConnectionState state) async {
        if (state == BluetoothConnectionState.disconnected) {
          // 1. typically, start a periodic timer that tries to
          //    reconnect, or just call connect() again right now
          connectToDevice();
          // 2. you must always re-discover services after disconnection!
          print(
              "${_bluetoothDevice!.disconnectReason?.code} ${_bluetoothDevice!.disconnectReason?.description}");
        }
        notifyListeners();
      },
    );
    notifyListeners();
  }

// Connect to the device
  Future connectToDevice() async {
    if (bluetoothDevice != null) {
      await bluetoothDevice!.connect(autoConnect: false);
    } else {
      print('No device assigned yet');
    }
    notifyListeners();
  }

// Disconnect from device
  Future disconnectDevice() async {
    await _bluetoothDevice!.disconnect();
    notifyListeners();
  }

// ??!Get Connected Devices
  void getConnectedDevices() {
    List<BluetoothDevice> devs = FlutterBluePlus.connectedDevices;
    for (var d in devs) {
      print('connected device: ${d}');
      if (devs.isEmpty) {
        print("No Devices Connected");
      }
    }
    notifyListeners();
  }
}
