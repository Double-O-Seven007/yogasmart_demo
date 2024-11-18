import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'package:yogasmart_demo/Services/bluetooth_connect.dart';
import 'package:yogasmart_demo/Widgets/custom_card.dart';

class PairedDeviceScreen extends StatelessWidget {
  const PairedDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            )),
        backgroundColor: Colors.black,
        title: Text(
          'Paired',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<BTConnect>(
        builder: (context, value, child) =>
            StreamBuilder<List<BluetoothDevice>>(
                stream: BTConnect().getSystemDevices().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data![index];
                                return CustomCard(
                                    title: data.platformName,
                                    subtitle: data.remoteId.str,
                                    onPressConnect: () {},
                                    buttonText: 'Connect');
                              }),
                        )
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
      ),
    );
  }
}
