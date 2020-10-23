import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/companyComponent/orders_business_List.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/businessServices.dart';
import 'package:sajeda_app/services/orderServices.dart';

import '../../constants.dart';

class CompanyOrdersAdminSide extends StatelessWidget {
  final String uid;
  final String orderState;
  CompanyOrdersAdminSide({this.uid, this.orderState});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Business>(
        stream: BusinessService(uid: uid).businessByID,
        builder: (context, snapshot) {
          Business businessData = snapshot.data ?? null;
          return Scaffold(
              appBar: AppBar(
                title: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text("طرود ${businessData.name}",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Amiri',
                        ))),
                backgroundColor: kAppBarColor,
                centerTitle: true,
              ),
              endDrawer: Directionality(
                  textDirection: TextDirection.rtl, child: AdminDrawer()),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: StreamProvider<List<Order>>.value(
                  value: OrderService(
                          businesID: businessData.uid, orderState: orderState)
                      .ordersBusinessByState,
                  child: OrdersBusinessList(orderState:orderState),
                ),
              ));
        });
  }
}
