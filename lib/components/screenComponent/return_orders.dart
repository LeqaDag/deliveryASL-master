import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/orderComponent/orderList.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/orderServices.dart';

import '../../constants.dart';

class ReturnOrders extends StatelessWidget {
  final String name;
  ReturnOrders({this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("الطورد الراجعة",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
          backgroundColor: kAppBarColor,
          centerTitle: true,
        ),
        endDrawer: Directionality(
            textDirection: TextDirection.rtl, child: AdminDrawer(name: name)),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamProvider<List<Order>>.value(
            value: OrderService().ordersByState('isReturn'),
            child: OrderList(orderState: 'isReturn', name: name),
          ),
        ));
  }
}
