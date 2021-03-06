import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/services/driverServices.dart';

import '../../../constants.dart';
import 'invoice_list_drivers.dart';

class DriverInvoiceAdmin extends StatelessWidget {
  final String name;
  DriverInvoiceAdmin({this.name});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("فواتير السائقين",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
          centerTitle: true,
          backgroundColor: kAppBarColor,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
              color: Colors.white,
            ),
          ],
        ),
        drawer: AdminDrawer(name: name),
        body: StreamProvider<List<Driver>>.value(
          value: DriverServices().drivers,
          child: InvoiceListDrivers(name: name),
        ),
      ),
    ));
  }
}
