import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yogasmart_demo/Services/bluetooth_connect.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    super.key,
    this.title,
    this.subtitle,
    // this.tileTap,
    required this.onPressed,
  });
  String? title;
  String? subtitle;
  Function() onPressed;
  // Function()? tileTap;
  @override
  Widget build(BuildContext context) {
    return Consumer<BTConnect>(
      builder: (context, value, child) => Card(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              // onTap: tileTap,
              title: Text(
                '${title}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text('${subtitle}'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  value.btPermissionGranted();
                  value.listenForDisconnection();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text('Device connected successsfully'),
                    ),
                  );
                },
                child: Text(
                  'Connect',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
