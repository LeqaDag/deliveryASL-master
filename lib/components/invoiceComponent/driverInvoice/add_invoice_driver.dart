import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/services/driverDeliveryCostServices.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:toast/toast.dart';

import '../../../constants.dart';

class AddInvoiceDriver extends StatefulWidget {
  final String name, driverId, driverName;
  final int total;
  AddInvoiceDriver({this.name, this.driverId, this.driverName, this.total});

  @override
  _AddInvoiceDriverState createState() => _AddInvoiceDriverState();
}

class _AddInvoiceDriverState extends State<AddInvoiceDriver> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int isDoneOrders = 0, totalSalary = 0;
  List<Order> orders;
  List<String> orderIds = [];
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference invoiceCollection =
      FirebaseFirestore.instance.collection('invoice');

  TextEditingController priceController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.driverId);
    return Scaffold(
      appBar: AppBar(
        title: Text('اضافة فاتورة ${widget.driverName} ',
            style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: AdminDrawer(name: widget.name)),
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            " عدد الطرود الكلية:",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(driverID: widget.driverId)
                                .countDriverOrders(widget.driverId),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Expanded(
                                child: Text(
                                  "  ${snapshot.data.toString()} " ?? "0",
                                ),
                              );
                            }),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Text(
                            " عدد الطرود الموزعة :",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(driverID: widget.driverId)
                                .countDriverOrderByStateOrder("isDone"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Expanded(
                                child: Text(
                                  "  ${snapshot.data.toString()} " ?? "0",
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "المبلغ الكلي للسائق : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                        ),

                        FutureBuilder<int>(
                            future: OrderServices(driverID: widget.driverId)
                                .countDriverOrderByStateOrder("isDone"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                isDoneOrders = snapshot.data;

                                return FutureBuilder<int>(
                                    future: DriverDeliveryCostServices(
                                            driverId: widget.driverId)
                                        .driverPriceData(widget.driverId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        totalSalary =
                                            snapshot.data * isDoneOrders;
                                        print(snapshot.data);
                                        //  isDoneOrders = snapshot.data;
                                        return Expanded(
                                          child: Text(
                                            "  ${totalSalary.toString()} " ??
                                                "0",
                                          ),
                                        );
                                      } else {
                                        return Text("");
                                      }
                                    });
                              } else {
                                return Text("");
                              }
                            }),

                        // StreamBuilder<List<Order>>(
                        //     stream: OrderServices()
                        //         .driverAllOrders(widget.driverId),
                        //     builder: (context, snapshot) {
                        //       if (!snapshot.hasData) {
                        //         return Text('0');
                        //       } else {
                        //         return Text(widget.total.toString());
                        //       }
                        //     }),
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.all(10.0),
                  //   child: StreamBuilder<List<Order>>(
                  //       stream:
                  //           OrderService().businessAllOrders(widget.businessId),
                  //       builder: (context, snapshot) {
                  //         int totalPrice = 0;
                  //         if (!snapshot.hasData) {
                  //           return Text('Loading...');
                  //         } else {
                  //           orders = snapshot.data;
                  //           orders.forEach((element) {
                  //             totalPrice += element.price;
                  //           });
                  //           return Text(totalPrice.toString());
                  //         }
                  //       }),
                  // ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'المبلغ المدفوع للسائق',
                        labelStyle: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 18.0,
                            color: Color(0xff316686)),
                        contentPadding: EdgeInsets.only(right: 20.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Color(0xff636363),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color(0xff73a16a),
                          ),
                          //Change color to Color(0xff73a16a)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: noteController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'ملاحظات',
                        labelStyle: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 18.0,
                            color: Color(0xff316686)),
                        contentPadding: EdgeInsets.only(right: 20.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Color(0xff636363),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Color(0xff73a16a),
                          ),
                          //Change color to Color(0xff73a16a)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(40.0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        _addInvoice();
                      },
                      color: Color(0xff73a16a),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'اضافة',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Amiri',
                                fontSize: 24.0),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          Icon(
                            Icons.add_circle,
                            color: Colors.white,
                            size: 32.0,
                          ),
                          StreamBuilder<List<Order>>(
                              stream: OrderServices(driverID: widget.driverId)
                                  .driversIsDoneOrders(widget.driverId),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text("");
                                } else {
                                  orders = snapshot.data;
                                  int index = 0;
                                  orders.forEach((element) {
                                    orderIds.insert(index, element.uid);
                                    index++;
                                  });
                                  return Text("");
                                }
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void _addInvoice() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;

    FirebaseFirestore.instance
        .collection('drivers')
        .doc(widget.driverId)
        .update({
      "paidDate": new DateTime.now(),
      "paidSalary": int.parse(priceController.text)
    });

    orderIds.forEach((element) async {
      FirebaseFirestore.instance.collection('orders').doc(element).update({
        "isPaidDriver": true,
        "paidSriverDate": new DateTime.now(),
      });
    });

    Toast.show("تم اضافة الفاتورة بنجاح", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    await Future.delayed(Duration(milliseconds: 1000));
    Navigator.of(context).pop();
    // invoiceCollection.doc().set({
    //   "note": noteController.text,
    //   "adminID": user.uid,
    //   "driverID": widget.driverId,
    //   "paidPriceDriver": int.parse(priceController.text),
    //   "totalPriceDriver": widget.total,
    //   "isArchived": false,
    // }).then((value) async {
    //   isLoading = false;

    //   Toast.show("تم اضافة الفاتورة بنجاح", context,
    //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    //   await Future.delayed(Duration(milliseconds: 1000));
    //   Navigator.of(context).pop();
    // }).catchError((err) {});
  }
}
