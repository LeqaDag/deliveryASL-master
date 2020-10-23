import 'package:sajeda_app/classes/driver.dart';
import '../itemComponent/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverList extends StatefulWidget {
  @override
  _DriverListState createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  @override
  Widget build(BuildContext context) {
    final drivers = Provider.of<List<Driver>>(context).where((driv) {
      return driv.type == true;
    }).toList();
    final driver1 = Provider.of<List<Driver>>(context).where((driv) {
      return driv.type == false;
    }).toList();
    return TabBarView(children: [
      ListView.builder(
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          return Item(driver: drivers[index]);
        },
      ),
      ListView.builder(
        itemCount: driver1.length,
        itemBuilder: (context, index) {
          return Item(driver: driver1[index]);
        },
      ),
    ]);
  }
}
