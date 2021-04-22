import 'package:AsyadLogistic/classes/driver.dart';
import '../itemComponent/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverList extends StatefulWidget {
  final String name;
  DriverList({this.name});

  @override
  _DriverListState createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  @override
  Widget build(BuildContext context) {
    List<Driver> drivers = Provider.of<List<Driver>>(context) ?? [];
    List<Driver> driver1 = Provider.of<List<Driver>>(context) ?? [];
    if (drivers != [] && drivers != []) {
      drivers = drivers.where((driv) {
        return driv.type == true;
      }).toList();
      driver1 = driver1.where((driv) {
        return driv.type == false;
      }).toList();
      return TabBarView(children: [
        ListView.builder(
          itemCount: drivers.length,
          itemBuilder: (context, index) {
            return Item(driver: drivers[index], name: widget.name);
          },
        ),
        ListView.builder(
          itemCount: driver1.length,
          itemBuilder: (context, index) {
            return Item(driver: driver1[index], name: widget.name);
          },
        ),
      ]);
    } else {
      return Container();
    }
  }
}
