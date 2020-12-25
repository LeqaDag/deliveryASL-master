import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:AsyadLogistic/components/businessComponent/orders/add_order.dart';
import 'package:AsyadLogistic/components/pages/business_drawer.dart';
import 'package:AsyadLogistic/services/invoiceServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';

import 'orders/all_orders.dart';

class BusinessMain extends StatefulWidget {
  final String name, uid;
  BusinessMain({this.name, this.uid});

  @override
  _BusinessMainState createState() => _BusinessMainState();
}

class _BusinessMainState extends State<BusinessMain> {
  String orderNumber = "0";
  List<Order> orders;
  int total = 0, paidSalary = 0;

  @override
  void initState() {
    orderNumber = "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0, paidPrice = 0, remainingPrice = 0;
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
            Expanded(
                child: Container(
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
                              future: OrderServices()
                                  .countBusinessOrders(widget.uid),
                              builder: (context, snapshot) {
                                orderNumber = snapshot.data.toString();
                                if (snapshot.hasData) {
                                  return Text(
                                    orderNumber ?? "",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 15,
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
                        "عدد الطلبيات  ",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Amiri",
                        ),
                      ),
                    ],),
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage("assets/totalPrice.png"),
                            width: 40,
                            height: 40,
                          ),
                          StreamBuilder<List<Order>>(
                              stream:
                                  OrderServices().businessAllOrders(widget.uid),
                              builder: (context, snapshot) {
                                int totalPrice = 0;
                                if (!snapshot.hasData) {
                                  return Text('جاري التحميل ... ');
                                } else {
                                  orders = snapshot.data;
                                  orders.forEach((element) {
                                    totalPrice += element.price;
                                    total = totalPrice;
                                  });
                                  return Text(
                                    totalPrice.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                }
                              },),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("المبلغ الكلي  ",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Amiri",
                          )),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                  ]),
                  TableRow(children: [
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage("assets/done.png"),
                            width: 40,
                            height: 40,
                          ),
                          FutureBuilder<int>(
                              future: OrderServices()
                                  .countBusinessDoneOrders(widget.uid),
                              builder: (context, snapshot) {
                                orderNumber = snapshot.data.toString();
                                if (snapshot.hasData) {
                                  return Text(
                                    orderNumber ?? "",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 15,
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
                        "عدد الطرود الجاهزة  ",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Amiri",
                        ),
                      ),
                    ]),
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage("assets/return.png"),
                            width: 40,
                            height: 40,
                          ),
                          FutureBuilder<int>(
                              future: OrderServices()
                                  .countBusinessReturnOrders(widget.uid),
                              builder: (context, snapshot) {
                                orderNumber = snapshot.data.toString();
                                if (snapshot.hasData) {
                                  return Text(
                                    orderNumber ?? "",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 15,
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
                      Text(" عدد الطرود الراجعة",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Amiri",
                          )),
                      SizedBox(
                        height: 20,
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
                              future: BusinessServices(uid: widget.uid)
                                  .businessPaidSalary,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  paidSalary = snapshot.data;
                                  return Text(
                                    snapshot.data.toString() ?? "",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 15,
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
                          fontSize: 16,
                          fontFamily: "Amiri",
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                          Text(
                            (total - paidSalary).toString() ?? "0",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " المبلغ المتبقي  ",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Amiri",
                        ),
                      ),
                    ]),
                  ]),
                ],
              ),
            )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
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
                                  name: widget.name, uid: widget.uid),
                            ),
                          );
                        },
                        child: Text(
                          "اضافة طلبية جديدة",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
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
            )),
          ],
        ),
      ),
    );
  }
}
