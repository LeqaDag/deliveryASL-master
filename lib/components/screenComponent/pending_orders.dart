import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/orderComponent/orderList.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/orderServices.dart';

import '../../constants.dart';

class PendingOrders extends StatefulWidget {
  final String name;
  PendingOrders({this.name});

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("الطرود المحملة",
              style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
          backgroundColor: kAppBarColor,
          centerTitle: true,
        ),
        endDrawer: Directionality(
            textDirection: TextDirection.rtl, child: AdminDrawer()),
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamProvider<List<Order>>.value(
            value: OrderService().ordersByState('isLoading'),
            child: OrderList(orderState: 'isLoading'),
          ),
        ));
  }
}
