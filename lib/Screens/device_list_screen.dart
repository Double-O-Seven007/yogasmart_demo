import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'package:yogasmart_demo/Services/bluetooth_connect.dart';
import 'package:yogasmart_demo/Widgets/custom_card.dart';

class DeviceListScreen extends StatelessWidget {
  DeviceListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              BTConnect().btOnOff();
            },
            icon: Icon(
              Icons.refresh_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Devices',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Consumer<BTConnect>(
        builder: (context, value, child) => StreamBuilder<List<ScanResult>>(
          stream: value.scanResults,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomCard(
                      title: 'YogaConnect',
                      subtitle: 'emulated remote id:12345',
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        value.bluetoothDevice = data.device;
                        return data.device.platformName.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomCard(
                                  // tileTap: () =>
                                  //     value.selectDevice(data.device),
                                  title: data.device.platformName,
                                  subtitle: '${data.device.remoteId}',
                                  onPressed: () async {
                                    // var device = data.device;
                                    value.connectToDevice();
                                    value.getConnectedDevices();
                                  },
                                ),
                              )
                            : SizedBox();
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Text('No Devices Found');
            }
          },
        ),
      ),
    );
  }
}
