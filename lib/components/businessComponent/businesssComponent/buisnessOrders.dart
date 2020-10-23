import 'package:flutter/material.dart';
import 'package:sajeda_app/components/businessComponent/itemComponent/buisness_orders_items.dart';

import '../../../constants.dart';

class CompaniesOrdersAdmin extends StatelessWidget {
  final String businessID, name;
  CompaniesOrdersAdmin({@required this.businessID, this.name});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text(name ?? "",
                style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
            centerTitle: true,
            backgroundColor: kAppBarColor,
          ),
          drawer: Drawer(),
          body: ListView(
            children: <Widget>[
              CustomCompanyOrdersItemsStatus(0, () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => CustomerOrderInformation()),
                // );
              }),
              CustomCompanyOrdersItemsStatus(1, () {}),
              CustomCompanyOrdersItemsStatus(2, () {}),
              CustomCompanyOrdersItemsStatus(3, () {}),
              CustomCompanyOrdersItemsStatus(4, () {}),
              CustomCompanyOrdersItemsStatus(5, () {}),
              CustomCompanyOrdersItemsStatus(6, () {}),
            ],
          ),
        ),
      ),
    );
  }
}
