import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yogasmart_demo/Routes/route_manager.dart';
import 'package:yogasmart_demo/Services/bluetooth_connect.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<BTConnect>().bluetoothDevice;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<BTConnect>(
        builder: (context, value, child) {
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 43, 15, 15),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(500),
                  ),
                  image: DecorationImage(
                    colorFilter: ColorFilter.linearToSrgbGamma(),
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/images/yoga.jpg'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      WavyAnimatedText('Welcome to YogaConnect'),
                      WavyAnimatedText('Get Your device ready'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 8,
              ),
              SafeArea(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size.fromWidth(MediaQuery.of(context).size.width / 2),
                  ),
                  onPressed: () {
                    BTConnect().btSupportCheck;
                    BTConnect().btOnOff();
                    // BTConnect().scanResults;
                    Navigator.pushNamed(context, RouteManager.deviceListScreen);
                    // print(BTConnect().scanResultsVar[0]);

                    // showCupertinoDialog(
                    //   barrierDismissible: true,
                    //   context: context,
                    //   builder: (context) => AlertDialog.adaptive(
                    //     insetAnimationCurve: Curves.linear,
                    //     title: Text('Available Bluetooth Devices'),
                    //     content: Column(
                    //       children: [],
                    //     ),
                    //   ),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.power_settings_new_rounded,
                        ),
                      ),
                      Text('Connect Mat'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
