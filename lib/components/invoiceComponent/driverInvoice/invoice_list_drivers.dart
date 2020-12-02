import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/driver.dart';

import '../../../constants.dart';
import 'all_invoice_drivers.dart';

class InvoiceListDrivers extends StatefulWidget {
  final String name;
  InvoiceListDrivers({this.name});

  @override
  _InvoiceListDriversState createState() => _InvoiceListDriversState();
}

class _InvoiceListDriversState extends State<InvoiceListDrivers> {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    final drivers = Provider.of<List<Driver>>(context) ?? [];
    if (drivers != []) {
      return ListView.builder(
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          return AllInvoiceDrivers(
              color: KCustomCompanyOrdersStatus,
              driverId: drivers[index].uid,
              name: widget.name,
              onTapBox: () {
                print("yes");
              });
        },
      );
    }
  }
}
