import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/business_drawer.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import 'package:intl/intl.dart' as Intl;
import '../../../constants.dart';

class OrderStatus extends StatelessWidget {
  final Order order;
  final String orderState, name, uid, customerName;

  OrderStatus(
      {this.order, this.orderState, this.name, this.uid, this.customerName});

  @override
  Widget build(BuildContext context) {
    print(order.uid);
    String delivStatusID;
    FirebaseFirestore.instance
        .collection('delivery_status')
        .where('orderID', isEqualTo: order.uid)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => {delivStatusID = value.docs[0].id});
    print(delivStatusID);
    return Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل طرد $customerName",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Amiri',
            )),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: BusinessDrawer(name: name, uid: uid)),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Card(
              shape: Border(right: BorderSide(color: Colors.purple, width: 7)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        padding: EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'تم الإضافة في ',
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 200.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                Intl.DateFormat('yyyy-MM-dd')
                                        .format(order.isLoadingDate) +
                                    ' - ' +
                                    Intl.DateFormat.jm()
                                        .format(order.isLoadingDate),
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Card(
              shape: Border(right: BorderSide(color: Colors.purple, width: 7)),
              elevation: 2,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        padding: EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'تم التسليم لشركة في ',
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 200.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                Intl.DateFormat('yyyy-MM-dd')
                                        .format(order.isReceivedDate) +
                                    ' - ' +
                                    Intl.DateFormat.jm()
                                        .format(order.isReceivedDate),
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Card(
              shape: Border(right: BorderSide(color: Colors.purple, width: 7)),
              elevation: 2,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        padding: EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'تم استلامها من قبل السائق في ',
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 200.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                Intl.DateFormat('yyyy-MM-dd')
                                        .format(order.isDeliveryDate) +
                                    ' - ' +
                                    Intl.DateFormat.jm()
                                        .format(order.isDeliveryDate),
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Card(
              shape: Border(right: BorderSide(color: Colors.purple, width: 7)),
              elevation: 2,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        padding: EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'تم تسليمها لزبون في ',
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 200.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                Intl.DateFormat('yyyy-MM-dd')
                                        .format(order.isDoneDate) +
                                    ' - ' +
                                    Intl.DateFormat.jm()
                                        .format(order.isDoneDate),
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Card(
              shape: Border(right: BorderSide(color: Colors.purple, width: 7)),
              elevation: 2,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        padding: EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'تم تحصيلها في ',
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 200.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                Intl.DateFormat('yyyy-MM-dd')
                                        .format(order.isPaidDate) +
                                    ' - ' +
                                    Intl.DateFormat.jm()
                                        .format(order.isPaidDate),
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
