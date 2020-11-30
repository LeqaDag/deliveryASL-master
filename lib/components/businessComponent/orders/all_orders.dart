import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/businessComponent/orders/business_orders.dart';
import 'package:sajeda_app/components/pages/business_drawer.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/services/orderServices.dart';

import '../../../constants.dart';

class BusinessOrders extends StatelessWidget {
  final String name, uid;
  BusinessOrders({this.name, this.uid});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("جميع الطلبيات",
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
        drawer: BusinessDrawer(name: name, uid: uid),
        body: StreamProvider<List<Order>>.value(
          value: OrderServices(businesID: uid, orderState: "all")
              .ordersBusinessByState,
          child: BusinessOrderList(name: name, uid: uid),
        ),
      ),
    );
  }
}
