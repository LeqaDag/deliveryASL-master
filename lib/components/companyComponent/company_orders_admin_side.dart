import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/companyComponent/orders_business_List.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/components/pages/loading.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';

import '../../constants.dart';

class CompanyOrdersAdminSide extends StatefulWidget {
  final String uid, name;
  final String orderState;
  CompanyOrdersAdminSide({this.uid, this.orderState, this.name});

  @override
  _CompanyOrdersAdminSideState createState() => _CompanyOrdersAdminSideState();
}

class _CompanyOrdersAdminSideState extends State<CompanyOrdersAdminSide> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Business>(
        stream: BusinessServices(uid: widget.uid).businessByID,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Business businessData = snapshot.data;
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
                    textDirection: TextDirection.rtl,
                    child: AdminDrawer(
                      name: widget.name,
                    )),
                body: Directionality(
                  textDirection: TextDirection.rtl,
                  child: StreamProvider<List<Order>>.value(
                    value: OrderServices(
                            businesID: businessData.uid,
                            orderState: widget.orderState)
                        .ordersBusinessByState,
                    child: OrdersBusinessList(
                        orderState: widget.orderState, name: widget.name),
                  ),
                ));
          } else {
            return LoadingPage();
          }
        });
  }
}
