import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/orderComponent/orderList.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/components/screenComponent/auto_division.dart';
import 'package:sajeda_app/services/orderServices.dart';

import '../../constants.dart';

class PickupOrders extends StatelessWidget {
  final String name;
  PickupOrders({this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الطرود المستلمة",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Amiri',
            )),
        backgroundColor: kAppBarColor,
        centerTitle: true,
      ),
      endDrawer: Directionality(
        textDirection: TextDirection.rtl,
        child: AdminDrawer(name: name),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: 150,
              height: 50,
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              child: RaisedButton(
                elevation: 3,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AutoDivision(name: name)),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: Color(0xff73A16A),
                    width: 3,
                  ),
                ),
                child: Text(
                  "توزيع تلقائي".toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Amiri',
                  ),
                ),
                color: Colors.white,
                textColor: Color(0xff73A16A),
              ),
            ),
            StreamProvider<List<Order>>.value(
              value: OrderServices().ordersByState('isReceived'),
              child: OrderList(orderState: 'isReceived', name: name),
            ),
          ]),
        ),
      ),
    );
  }
}
