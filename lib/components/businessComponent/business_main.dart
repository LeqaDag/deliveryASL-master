import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sajeda_app/components/businessComponent/orders/add_order.dart';
import 'package:sajeda_app/components/pages/business_drawer.dart';
import 'package:sajeda_app/services/invoiceServices.dart';
import 'package:sajeda_app/services/orderServices.dart';

import 'orders/all_orders.dart';

class BusinessMain extends StatefulWidget {
  final String name, uid;
  BusinessMain({this.name, this.uid});

  @override
  _BusinessMainState createState() => _BusinessMainState();
}

class _BusinessMainState extends State<BusinessMain> {
  @override
  Widget build(BuildContext context) {
    int totalPrice = 0, paidPrice = 0, remainingPrice = 0;
    print(widget.uid);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: BusinessDrawer(name: widget.name, uid: widget.uid),
        appBar: AppBar(
          backgroundColor: Color(0xFF457B9D),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
          title: Text(widget.name ?? "",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Table(
                border: TableBorder.all(
                  width: 0.4,
                ),
                children: [
                  TableRow(children: [
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage("assets/orderNum.png"),
                            width: 40,
                            height: 40,
                          ),
                          FutureBuilder<int>(
                              future: OrderService()
                                  .countBusinessOrders(widget.uid),
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data.toString() ?? "",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                );
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "عدد الطلبيات  ",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Amiri",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage("assets/totalPrice.png"),
                            width: 40,
                            height: 40,
                          ),
                          FutureBuilder<int>(
                              future: InvoiceService(businessId: widget.uid)
                                  .total(widget.uid),
                              builder: (context, snapshot) {
                                totalPrice = snapshot.data;
                                print(totalPrice);
                                if (totalPrice == null) {
                                  return Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text(
                                    snapshot.data.toString() ?? "",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                }
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("المبلغ الكلي  ",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: "Amiri",
                          )),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage("assets/paid.png"),
                            width: 40,
                            height: 40,
                          ),
                          FutureBuilder<int>(
                              future: InvoiceService(businessId: widget.uid)
                                  .paidPrice(widget.uid),
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text(
                                    snapshot.data.toString() ?? "",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                }
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "المبلغ المدفوع ",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Amiri",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage("assets/remaining.png"),
                            width: 40,
                            height: 40,
                          ),
                          FutureBuilder<int>(
                              future: InvoiceService(businessId: widget.uid)
                                  .paidPrice(widget.uid),
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  paidPrice = snapshot.data;
                                  remainingPrice = totalPrice - paidPrice;
                                  return Text(
                                    remainingPrice.toString() ?? "",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                }
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " المبلغ المتبقي  ",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Amiri",
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
                  ]),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/icon_add_new_order.png"),
                      width: 70,
                      height: 70,
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewOdersByBusiness(
                                  name: widget.name, uid: widget.uid)),
                        );
                      },
                      child: Text(
                        "اضافة طلبية جديدة",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/icon_all_orders.png"),
                      width: 80,
                      height: 80,
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BusinessOrders(
                                  name: widget.name, uid: widget.uid)),
                        );
                      },
                      child: Text(
                        "جميع الطلبيات",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
