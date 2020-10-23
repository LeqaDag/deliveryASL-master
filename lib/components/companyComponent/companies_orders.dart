import 'package:flutter/material.dart';
import 'package:sajeda_app/components/orderComponent/custome_order_information.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/components/widgetsComponent/Compannies_orders_customWigets.dart';

import '../../constants.dart';

class CompaniesOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("طردو شركة معينة",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
          backgroundColor: kAppBarColor,
          centerTitle: true,
        ),
        endDrawer: Directionality(
            textDirection: TextDirection.rtl, child: AdminDrawer()),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: <Widget>[
              CustomCompanyOrdersStatus(0, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerOrderInformation()),
                );
              }),
              CustomCompanyOrdersStatus(1, () {}),
              CustomCompanyOrdersStatus(2, () {}),
              CustomCompanyOrdersStatus(3, () {}),
              CustomCompanyOrdersStatus(4, () {}),
              CustomCompanyOrdersStatus(5, () {}),
              CustomCompanyOrdersStatus(6, () {}),
            ],
          ),
        ));
  }
}
