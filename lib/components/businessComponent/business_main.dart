import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sajeda_app/components/businessComponent/orders/add_order.dart';
import 'package:sajeda_app/components/businessComponent/orders/all_orders.dart';
import 'package:sajeda_app/components/pages/business_drawer.dart';

class BusinessMain extends StatelessWidget {
  final String name, uid;
  BusinessMain({this.name, this.uid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            drawer: BusinessDrawer(name: name, uid: uid),
            appBar: AppBar(
              backgroundColor: Color(0xFF457B9D),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print('ahmad');
                    })
              ],
              title: Text(name ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amiri',
                  )),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                  title: Image(
                    image: AssetImage("assets/icon_add_new_order.png"),
                    width: 80,
                    height: 80,
                  ),
                  subtitle: Text(
                    "اضافة طلبية جديدة",
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddNewOdersByBusiness(name: name, uid: uid)),
                    );
                  },
                ),
                ListTile(
                  title: Image(
                    image: AssetImage("assets/icon_all_orders.png"),
                    width: 100,
                    height: 100,
                  ),
                  subtitle: Text(
                    "جميع الطلبيات",
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusinessOrders(name: name, uid: uid)),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
