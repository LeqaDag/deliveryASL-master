import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/services/businessServices.dart';

import '../../constants.dart';
import 'companyInvoice/company_invoice_main.dart';
import 'companyInvoice/invoice_list.dart';
import 'driverInvoice/driver_invoice_main.dart';

class InvoiceAdmin extends StatelessWidget {
  final String name;
  InvoiceAdmin({this.name});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: AdminDrawer(name: name),
        appBar: AppBar(
          backgroundColor: Color(0xFF457B9D),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
          title: Text(name ?? "",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Image(
                image: AssetImage("assets/companyPrice.png"),
                width: 80,
                height: 80,
              ),
              subtitle: Text(
                " فاتورة الشركات ",
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanyInvoiceAdmin(
                            name: name,
                          )),
                );
              },
            ),
            ListTile(
              title: Image(
                image: AssetImage("assets/driverPrice.png"),
                width: 80,
                height: 80,
              ),
              subtitle: Text(
                " فاتورة السائقون ",
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DriverInvoiceAdmin(
                            name: name,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
