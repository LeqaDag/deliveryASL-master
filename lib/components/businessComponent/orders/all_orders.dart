import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/orderComponent/orderList.dart';
import 'package:sajeda_app/components/pages/business_drawer.dart';
import 'package:sajeda_app/services/orderServices.dart';

class BusinessOrders extends StatelessWidget {
  final String name, uid;
  BusinessOrders({this.name, this.uid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              drawer: BusinessDrawer(name: name, uid: uid),
              appBar: AppBar(
                backgroundColor: Color(0xFF457B9D),
                title: Text("جميع الطلبيات",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Amiri',
                    )),
                centerTitle: true,
              ),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: StreamProvider<List<Order>>.value(
                  value: OrderService().ordersByState('isReceived'),
                  child: OrderList(orderState: 'isReceived'),
                ),
              ))),
    );
  }
}
