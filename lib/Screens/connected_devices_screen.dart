import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yogasmart_demo/Routes/route_manager.dart';
import 'package:yogasmart_demo/Services/bluetooth_connect.dart';
import 'package:yogasmart_demo/Widgets/custom_card.dart';

class ConnectedDevicesScreen extends StatelessWidget {
  const ConnectedDevicesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<BTConnect>().bluetoothDevice;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Conneted devices',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              BTConnect().getConnectedDevices();
            },
            icon: Icon(
              Icons.refresh_rounded,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Consumer<BTConnect>(
        builder: (context, value, child) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: BTConnect().getConnectedDevices().length,
                itemBuilder: (context, index) => CustomCard(
                    buttonText: 'Disconnect ',
                    title: BTConnect().getConnectedDevices().first.platformName,
                    subtitle:
                        BTConnect().getConnectedDevices().first.remoteId.str,
                    onPressConnect: () {
                      value.disconnectDevice();
                    }),
              ),
            ),
            SafeArea(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RouteManager.pairedDeviceScreen,
                  );
                },
                child: Text(
                  'Paired Devices',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
