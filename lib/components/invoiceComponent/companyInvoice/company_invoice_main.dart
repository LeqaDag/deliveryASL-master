import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/services/businessServices.dart';

import '../../../constants.dart';
import 'invoice_list.dart';

class CompanyInvoiceAdmin extends StatelessWidget {
  final String name;
  CompanyInvoiceAdmin({this.name});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:  Scaffold(
        appBar: AppBar(
          title: Text("فواتير الشركات",
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
        body: StreamProvider<List<Business>>.value(
          value: BusinessService().business,
          child: InvoiceList(name: name),
        ),
      ),
    );
  }
}