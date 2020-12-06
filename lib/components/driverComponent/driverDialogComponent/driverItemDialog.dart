import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/driver.dart';

class DriverItemDialog extends StatelessWidget {
  final Driver driver;
  DriverItemDialog({this.driver});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        onTap: () {
          Navigator.pop(context, driver);
        },
        title: Align(
          alignment: Alignment.center,
          child: Text(
            '${driver.name}',
            style: TextStyle(fontFamily: 'Amiri', fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
