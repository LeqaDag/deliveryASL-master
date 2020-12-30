import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/components/screenComponent/done_orders.dart';
import 'package:AsyadLogistic/components/screenComponent/paid_orders.dart';

import '../../constants.dart';

class ReadyOrders extends StatelessWidget {
  final String name;
  ReadyOrders({this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("الطورد الجاهزة",
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
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaidOrders(name: name),
                        ),
                      );
                    },
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Color(0xff088A85),
                    child: Container(
                      width: 200,
                      height: 100,
                      child: Center(
                        child: Text(
                          "طرود محصلة",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Amiri',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RaisedButton(
                    onPressed: () { Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoneOrders(name: name),
                        ),
                      );},
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Color(0xff088A85),
                    child: Container(
                      width: 200,
                      height: 100,
                      child: Center(
                        child: Text(
                          "طرود غير محصلة",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Amiri',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
// StreamProvider<List<Order>>.value(
//             value: OrderServices().ordersByState('isDone'),
//             child: OrderList(orderState: 'isDone', name: name),
//           ),
