import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/components/pages/driver_drawer.dart';
import 'package:sajeda_app/services/orderServices.dart';

import '../../../constants.dart';
import 'driver_orders_list.dart';

class DriverMain extends StatelessWidget {
  final String name, uid;
  DriverMain({this.name, this.uid});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
          length: 3,
          child: StreamProvider<List<Order>>.value(
            value: OrderServices(driverID: uid, orderState: "driverOrders")
                .ordersBusinessByState,
            child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                      labelColor: kAppBarColor,
                      unselectedLabelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          color: Colors.white),
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "طرود غير جاهزة",
                              style: TextStyle(
                                  fontSize: 15.0, fontFamily: 'Amiri'),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "طرود جاهزة ",
                              style: TextStyle(
                                  fontSize: 15.0, fontFamily: 'Amiri'),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "طرود عالقة ",
                              style: TextStyle(
                                  fontSize: 15.0, fontFamily: 'Amiri'),
                            ),
                          ),
                        ),
                      ]),
                  title: Text(name ?? "",
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
                drawer: DriverDrawer(name: name, uid: uid),
                body: DriverOrderList(name: name, uid: uid)),
          ),
        ));
  }
}
