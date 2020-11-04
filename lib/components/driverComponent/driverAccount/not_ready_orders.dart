import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/classes/customer.dart';
import 'package:sajeda_app/classes/deliveryStatus.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/pages/driver_drawer.dart';
import 'package:sajeda_app/components/pages/loadingData.dart';
import 'package:sajeda_app/services/businessServices.dart';
import 'package:sajeda_app/services/customerServices.dart';
import 'package:sajeda_app/services/deliveryStatusServices.dart';
import 'package:sajeda_app/services/orderServices.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class NotReadyOrderDetails extends StatefulWidget {
  final String orderState, name, uid;
  NotReadyOrderDetails({Key key, this.orderState, this.name, this.uid})
      : super(key: key);

  @override
  _NotReadyOrderDetailsState createState() => _NotReadyOrderDetailsState();
}

class _NotReadyOrderDetailsState extends State<NotReadyOrderDetails> {
  TextEditingController noteController = TextEditingController();
  String type, status;
  bool isCancelld, isReturn, isDone;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder<Order>(
        stream: OrderService(uid: widget.uid).orderData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Order order = snapshot.data;

            return StreamBuilder<Customer>(
                stream: CustomerService(uid: order.customerID).customerData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Customer customer = snapshot.data;
                    return StreamBuilder<Business>(
                        stream:
                            BusinessService(uid: order.businesID).businessByID,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Scaffold(
                                appBar: AppBar(
                                  title: Text(" طرد ${customer.name}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Amiri',
                                      )),
                                  backgroundColor: kAppBarColor,
                                  centerTitle: true,
                                ),
                                endDrawer: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DriverDrawer(
                                      name: widget.name,
                                    )),
                                body: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListView(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                              width: width / 2.5,
                                              height: 80,
                                              child: Card(
                                                margin: EdgeInsets.fromLTRB(
                                                    0.0, 10.0, 0.0, 16.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: height * 0.025,
                                                          right: height * 0.025,
                                                          top: height * 0,
                                                          bottom: height * 0),
                                                      child: Icon(
                                                        Icons.location_city,
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                    FutureBuilder<String>(
                                                        future: BusinessService(
                                                                uid: order
                                                                    .businesID)
                                                            .businessName,
                                                        builder: (context,
                                                            snapshot) {
                                                          return Text(
                                                            snapshot.data ?? "",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Amiri",
                                                            ),
                                                          );
                                                        }),
                                                  ],
                                                ),
                                              )),
                                          Container(
                                              width: width / 2.4,
                                              height: 80,
                                              child: Card(
                                                margin: EdgeInsets.fromLTRB(
                                                    0.0, 10.0, 0.0, 16.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: height * 0.025,
                                                          right: height * 0.025,
                                                          top: height * 0,
                                                          bottom: height * 0),
                                                      child: Icon(
                                                        Icons.phone,
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                    FutureBuilder<String>(
                                                        future: BusinessService(
                                                                uid: order
                                                                    .businesID)
                                                            .businessPhoneNumber,
                                                        builder: (context,
                                                            snapshot) {
                                                          return InkWell(
                                                            child: Text(
                                                              " 0${snapshot.data.toString()} ",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    "Amiri",
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              launch("tel:" +
                                                                  Uri.encodeComponent(
                                                                      '0${snapshot.data.toString()}'));
                                                            },
                                                          );
                                                        }),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              width: width - 50,
                                              height: 80,
                                              child: Card(
                                                margin: EdgeInsets.fromLTRB(
                                                    0.0, 10.0, 0.0, 16.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: height * 0.025,
                                                          right: height * 0.025,
                                                          top: height * 0,
                                                          bottom: height * 0),
                                                      child: Icon(
                                                        Icons.person,
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                    FutureBuilder<String>(
                                                        future: CustomerService(
                                                                uid: order
                                                                    .customerID)
                                                            .customerName,
                                                        builder: (context,
                                                            snapshot) {
                                                          return Text(
                                                            snapshot.data ?? "",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Amiri",
                                                            ),
                                                          );
                                                        }),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                              width: width / 2.5,
                                              height: 80,
                                              child: Card(
                                                margin: EdgeInsets.fromLTRB(
                                                    0.0, 10.0, 0.0, 16.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          "رقم جوال ",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: "Amiri",
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: height *
                                                                      0.025,
                                                                  right:
                                                                      height *
                                                                          0.025,
                                                                  top: height *
                                                                      0,
                                                                  bottom:
                                                                      height *
                                                                          0),
                                                          child: Icon(
                                                            Icons.phone,
                                                            color:
                                                                Colors.blueGrey,
                                                          ),
                                                        ),
                                                        FutureBuilder<int>(
                                                            future: CustomerService(
                                                                    uid: order
                                                                        .customerID)
                                                                .customerPhoneNumber,
                                                            builder: (context,
                                                                snapshot) {
                                                              return InkWell(
                                                                child: Text(
                                                                  " 0${snapshot.data.toString()} ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "Amiri",
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  launch("tel:" +
                                                                      Uri.encodeComponent(
                                                                          '0${snapshot.data.toString()}'));
                                                                },
                                                              );
                                                            }),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )),
                                          Container(
                                              width: width / 2.5,
                                              height: 80,
                                              child: Card(
                                                margin: EdgeInsets.fromLTRB(
                                                    0.0, 10.0, 0.0, 16.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          " رقم جوال احتياطي ",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: "Amiri",
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: height *
                                                                      0.025,
                                                                  right:
                                                                      height *
                                                                          0.025,
                                                                  top: height *
                                                                      0,
                                                                  bottom:
                                                                      height *
                                                                          0),
                                                          child: Icon(
                                                            Icons.phone,
                                                            color:
                                                                Colors.blueGrey,
                                                          ),
                                                        ),
                                                        FutureBuilder<int>(
                                                            future: CustomerService(
                                                                    uid: order
                                                                        .customerID)
                                                                .customerAdditionalPhoneNumber,
                                                            builder: (context,
                                                                snapshot) {
                                                              return InkWell(
                                                                child: Text(
                                                                  " 0${snapshot.data.toString()} ",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "Amiri",
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  launch("tel:" +
                                                                      Uri.encodeComponent(
                                                                          '0${snapshot.data.toString()}'));
                                                                },
                                                              );
                                                            }),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              width: width - 50,
                                              height: 80,
                                              child: Card(
                                                margin: EdgeInsets.fromLTRB(
                                                    0.0, 10.0, 0.0, 16.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: height * 0.025,
                                                          right: height * 0.025,
                                                          top: height * 0,
                                                          bottom: height * 0),
                                                      child: Icon(
                                                        Icons.location_on,
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                    FutureBuilder<String>(
                                                        future: CustomerService(
                                                                uid: order
                                                                    .customerID)
                                                            .customerAdress,
                                                        builder: (context,
                                                            snapshot) {
                                                          return Text(
                                                            snapshot.data ?? "",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Amiri",
                                                            ),
                                                          );
                                                        }),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              width: width - 50,
                                              height: 80,
                                              child: Card(
                                                margin: EdgeInsets.fromLTRB(
                                                    0.0, 10.0, 0.0, 16.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Text(
                                                          "بيانات الطرد ",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: "Amiri",
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: height *
                                                                      0.025,
                                                                  right:
                                                                      height *
                                                                          0.025,
                                                                  top: height *
                                                                      0,
                                                                  bottom:
                                                                      height *
                                                                          0),
                                                        ),
                                                        FutureBuilder<String>(
                                                            future: OrderService(
                                                                    uid: order
                                                                        .uid)
                                                                .orderDescription,
                                                            builder: (context,
                                                                snapshot) {
                                                              return InkWell(
                                                                child: Text(
                                                                  snapshot.data ??
                                                                      "",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "Amiri",
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  launch("tel:" +
                                                                      Uri.encodeComponent(
                                                                          '0${snapshot.data.toString()}'));
                                                                },
                                                              );
                                                            }),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                      Form(
                                          key: _formKey,
                                          child: Column(children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.all(25.0),
                                              child: DropdownButtonFormField(
                                                onChanged: (String value) =>
                                                    setState(
                                                        () => type = value),
                                                value: type,
                                                items: <String>[
                                                  'تم التوصيل',
                                                  'لم يتم الرد على الهاتف',
                                                  'تم التوصيل مع تغيير السعر',
                                                  'ملغية بسبب خطأ في المنتج',
                                                  'ملغية لاسباب شخصية',
                                                  'ملغية لاسباب أخرى',
                                                  'راجعة بسبب خطأ في المنتج',
                                                  'راجعة لاسباب شخصية',
                                                  'راجعة لاسباب أخرى',
                                                  'مؤجلة',
                                                  'تم فقدان الطرد',
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        value,
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            fontFamily: 'Amiri',
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        width: 1.0,
                                                        color:
                                                            Color(0xff636363),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        width: 2.0,
                                                        color:
                                                            Color(0xff73a16a),
                                                      ),
                                                      //Change color to Color(0xff73a16a)
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            right: 20.0,
                                                            left: 10.0),
                                                    labelText: "حالة التوصيل",
                                                    labelStyle: TextStyle(
                                                        fontFamily: 'Amiri',
                                                        fontSize: 16.0,
                                                        color:
                                                            Color(0xff316686))),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 25.0, left: 25.0),
                                              child: TextFormField(
                                                controller: noteController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: 'ملاحظات',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Amiri',
                                                      fontSize: 18.0,
                                                      color: Color(0xff316686)),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          right: 20.0),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide: BorderSide(
                                                      width: 1.0,
                                                      color: Color(0xff636363),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
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
                                              margin: EdgeInsets.fromLTRB(
                                                  90, 30, 90, 0),
                                              child: RaisedButton(
                                                padding: EdgeInsets.all(10.0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(30.0)),
                                                onPressed: () async {
                                                  if (type == 'تم التوصيل') {
                                                    status = "1";
                                                    isDone = true;
                                                    isCancelld = false;
                                                    isReturn = false;
                                                  } else if (type ==
                                                      'لم يتم الرد على الهاتف') {
                                                    status = "2";
                                                  } else if (type ==
                                                      'تم التوصيل مع تغيير السعر') {
                                                    status = "3";
                                                    isDone = true;
                                                    isCancelld = false;
                                                    isReturn = false;
                                                  } else if (type ==
                                                      'ملغية بسبب خطأ في المنتج') {
                                                    status = "4";
                                                    isDone = false;
                                                    isCancelld = true;
                                                    isReturn = false;
                                                  } else if (type ==
                                                      'ملغية لاسباب شخصية') {
                                                    status = "5";
                                                    isDone = false;
                                                    isCancelld = true;
                                                    isReturn = false;
                                                  } else if (type ==
                                                      'ملغية لاسباب أخرى') {
                                                    status = "6";
                                                    isDone = false;
                                                    isCancelld = true;
                                                    isReturn = false;
                                                  } else if (type ==
                                                      'راجعة بسبب خطأ في المنتج') {
                                                    status = "7";
                                                    isDone = false;
                                                    isCancelld = false;
                                                    isReturn = true;
                                                  } else if (type ==
                                                      'راجعة لاسباب شخصية') {
                                                    status = "8";
                                                    isDone = false;
                                                    isCancelld = false;
                                                    isReturn = true;
                                                  } else if (type ==
                                                      'راجعة لاسباب أخرى') {
                                                    status = "9";
                                                    isDone = false;
                                                    isCancelld = false;
                                                    isReturn = true;
                                                  } else if (type == 'مؤجلة') {
                                                    status = "10";
                                                    isDone = false;
                                                    isCancelld = true;
                                                    isReturn = false;
                                                  } else if (type ==
                                                      'تم فقدان الطرد') {
                                                    status = "11";
                                                  } else {
                                                    status = "0";
                                                  }

                                                  await DeliveriesStatusServices()
                                                      .addDeliveryStatusData(
                                                          DeliveryStatus(
                                                              orderID:
                                                                  order.uid,
                                                              driverID: order
                                                                  .driverID,
                                                              businessID: order
                                                                  .businesID,
                                                              status: status,
                                                              date: DateTime
                                                                  .now(),
                                                              note:
                                                                  noteController
                                                                      .text,
                                                              isArchived:
                                                                  false));

                                                  if (type == 'لم يتم الرد على الهاتف' ||
                                                      type ==
                                                          'تم التوصيل مع تغيير السعر' ||
                                                      type ==
                                                          'ملغية بسبب خطأ في المنتج' ||
                                                      type ==
                                                          'ملغية لاسباب شخصية' ||
                                                      type ==
                                                          'ملغية لاسباب أخرى' ||
                                                      type ==
                                                          'راجعة بسبب خطأ في المنتج' ||
                                                      type ==
                                                          'راجعة لاسباب شخصية' ||
                                                      type ==
                                                          'راجعة لاسباب أخرى' ||
                                                      type == 'تم التوصيل') {
                                                    await OrderService(
                                                            uid: order.uid)
                                                        .updateOrderStatus(Order(
                                                            isCancelld:
                                                                isCancelld,
                                                            isReturn: isReturn,
                                                            isDone: isDone,
                                                            price: order.price,
                                                            totalPrice: order
                                                                .totalPrice,
                                                            type: order.type,
                                                            description: order
                                                                .description,
                                                            date: order.date,
                                                            note: order.note,
                                                            customerID: order
                                                                .customerID));
                                                    // Notification here for the admin
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                color: Color(0xff73a16a),
                                                child: Text(
                                                  'ارسال ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Amiri',
                                                      fontSize: 20.0),
                                                ),
                                              ),
                                            )
                                          ])),
                                    ],
                                  ),
                                ));
                          } else {
                            return LoadingData();
                          }
                        });
                  } else {
                    return LoadingData();
                  }
                });
          } else {
            return LoadingData();
          }
        });
  }
}
