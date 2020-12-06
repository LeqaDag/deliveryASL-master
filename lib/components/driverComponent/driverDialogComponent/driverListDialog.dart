import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/components/driverComponent/driverDialogComponent/driverItemDialog.dart';

class DriverListDialog extends StatefulWidget {
  @override
  _DriverListDialogState createState() => _DriverListDialogState();
}

class _DriverListDialogState extends State<DriverListDialog> {
  @override
  Widget build(BuildContext context) {
    final driver = Provider.of<List<Driver>>(context);
    print(driver);
    return ListView.builder(
      itemCount: driver.length,
      itemBuilder: (context, index) {
        return DriverItemDialog(driver: driver[index]);
      },
    );
  }
}
