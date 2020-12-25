import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/driver_drawer.dart';
import 'package:AsyadLogistic/components/pages/loadingData.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class InStokeOrderDetails extends StatefulWidget {
  final String orderState, name, uid;
  InStokeOrderDetails({Key key, this.orderState, this.name, this.uid})
      : super(key: key);

  @override
  _InStokeOrderDetailsState createState() => _InStokeOrderDetailsState();
}

class _InStokeOrderDetailsState extends State<InStokeOrderDetails> {
  TextEditingController noteController = TextEditingController();
  String type, status;
  bool isCancelld, isReturn, isDone, isDelivery, isReceived;
  final _formKey = GlobalKey<FormState>();
  String cityId;
  DateTime deliveryDate, doneDate, cancelledDate, returnDate, receivedDate;

  @override
  void initState() {
    deliveryDate = new DateTime.now();
    doneDate = new DateTime.now();
    cancelledDate = new DateTime.now();
    returnDate = new DateTime.now();
    receivedDate = new DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder<Order>(
        stream: OrderServices(uid: widget.uid).orderData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Order order = snapshot.data;

            return StreamBuilder<Customer>(
                stream: CustomerServices(uid: order.customerID).customerData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Customer customer = snapshot.data;
                    return StreamBuilder<Business>(
                        stream:
                            BusinessServices(uid: order.businesID).businessByID,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Business business = snapshot.data;
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
                                                        future: BusinessServices(
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
                                                        future: BusinessServices(
                                                                uid: order
                                                                    .businesID)
                                                            .businessPhoneNumber,
                                                        builder: (context,
                                                            snapshot) {
                                                          return InkWell(
                                                            child: Text(
                                                              " ${snapshot.data.toString()} ",
                                                              style: TextStyle(
                                                                fontSize: 14,
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
                                                        future: CustomerServices(
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
                                                            future: CustomerServices(
                                                                    uid: order
                                                                        .customerID)
                                                                .customerPhoneNumber,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                return InkWell(
                                                                  child: Text(
                                                                    " 0${snapshot.data.toString()} " ??
                                                                        "",
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
                                                              } else {
                                                                return Text("");
                                                              }
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
                                                            future: CustomerServices(
                                                                    uid: order
                                                                        .customerID)
                                                                .customerAdditionalPhoneNumber,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .hasData &&
                                                                  snapshot.data !=
                                                                      0) {
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
                                                              } else {
                                                                return Text("غير متوفر");
                                                              }
                                                            }),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          // Container(
                                          //   width: width - 50,
                                          //   height: 80,
                                          //   child: StreamBuilder<City>(
                                          //       stream: CityService(uid: cityId)
                                          //           .cityByID,
                                          //       builder: (context, snapshot) {
                                          //         City city = snapshot.data;
                                          //         return TextField(
                                          //           enabled: false,
                                          //           decoration: InputDecoration(
                                          //             contentPadding:
                                          //                 EdgeInsets.only(
                                          //                     top: 7,
                                          //                     bottom: 7,
                                          //                     right: 8),
                                          //             prefixIcon: Icon(
                                          //               Icons.location_on,
                                          //               color: Colors.blueGrey,
                                          //             ),
                                          //             hintText: city
                                          //                 .name, //String Data form DB.
                                          //           ),
                                          //         );
                                          //       }),
                                          // ),
                                          Container(
                                              width: width - 50,
                                              height: 80,
                                              child: FutureBuilder<String>(
                                                  future: CustomerServices(
                                                          uid: order.customerID)
                                                      .customerCity,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      cityId = snapshot.data;
                                                      return Card(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  16.0),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: height *
                                                                        0.025,
                                                                    right:
                                                                        height *
                                                                            0.025,
                                                                    top:
                                                                        height *
                                                                            0,
                                                                    bottom:
                                                                        height *
                                                                            0),
                                                                child: Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Colors
                                                                      .blueGrey,
                                                                ),
                                                              ),
                                                              Text(
                                                                cityId ?? "",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "Amiri",
                                                                ),
                                                              ),
                                                              FutureBuilder<
                                                                      String>(
                                                                  future: CustomerServices(
                                                                          uid: order
                                                                              .customerID)
                                                                      .customerSublineName,
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    return Text(
                                                                      " - ${snapshot.data}" ??
                                                                          "",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            "Amiri",
                                                                      ),
                                                                    );
                                                                  }),
                                                              FutureBuilder<
                                                                      String>(
                                                                  future: CustomerServices(
                                                                          uid: order
                                                                              .customerID)
                                                                      .customerAdress,
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    return Text(
                                                                      " - ${snapshot.data}" ??
                                                                          "",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontFamily:
                                                                            "Amiri",
                                                                      ),
                                                                    );
                                                                  }),
                                                            ],
                                                          ));
                                                    } else {
                                                      return Text(
                                                        "",
                                                      );
                                                    }
                                                  })),
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
                                                            future: OrderServices(
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
                                      Container(
                                        margin: EdgeInsets.all(40.0),
                                        child: RaisedButton(
                                          padding: EdgeInsets.all(10.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0)),
                                          onPressed: () async {
                                            OrderServices(
                                              uid: order.uid,
                                            ).updateOrderFromInStokeToisDelivery;

                                            Toast.show("تم الاستلام", context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.BOTTOM);
                                            await Future.delayed(
                                                Duration(milliseconds: 1000));
                                            Navigator.of(context).pop();
                                          },
                                          color: Color(0xff73a16a),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'تم الاستلام من المخزن',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Amiri',
                                                    fontSize: 24.0),
                                              ),
                                              SizedBox(
                                                width: 40.0,
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: Colors.white,
                                                size: 32.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
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

class CustomerInformation {
  Widget build(BuildContext context) {
    return TabBarView(children: []);
  }
}
