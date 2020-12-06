import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/orderComponent/orderList.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/services/orderServices.dart';

import '../../constants.dart';

class AllOrders extends StatelessWidget {
  final String name;
  AllOrders({this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("الطرود الموزعة"),
          backgroundColor: kAppBarColor,
          centerTitle: true,
        ),
        endDrawer: Directionality(
            textDirection: TextDirection.rtl, child: AdminDrawer(name: name)),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamProvider<List<Order>>.value(
            value: OrderServices().ordersByState('isDelivery'),
            child: OrderList(
              orderState: 'isDelivery',
              name: name,
            ),
          ),
        ));
  }
}
