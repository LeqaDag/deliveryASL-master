import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/components/pages/loadingData.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:AsyadLogistic/components/orderComponent/orderInformationComponent/shared_information.dart';
import 'package:intl/intl.dart' as intl;
import 'package:toast/toast.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class ReceivedInfo extends StatefulWidget {
  final String uid, name;
  ReceivedInfo({this.uid, this.name});

  @override
  _ReceivedInfoState createState() => _ReceivedInfoState();
}

class _ReceivedInfoState extends State<ReceivedInfo> {
  String driverName = 'اسم السائق';
  final CollectionReference driverCollection =
      FirebaseFirestore.instance.collection('drivers');
  Driver driver;
  final _formKey = GlobalKey<FormState>();
  List<Location> locations;
  String locationID;

  List<Driver> driverList;
  String driverID;
  bool selected = false;
  int bonus = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Order>(
        stream: OrderServices(uid: widget.uid).orderData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Order order = snapshot.data;
            String orderType = '';
            if (order.isUrgent == false) {
              orderType = "عادي";
            } else {
              orderType = "مستعجل";
            }
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
                                  title: Text("معلومات طرد ${customer.name}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Amiri',
                                      )),
                                  backgroundColor: kAppBarColor,
                                  centerTitle: true,
                                ),
                                endDrawer: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AdminDrawer(name: widget.name)),
                                body: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListView(
                                    children: <Widget>[
                                      CustomTitle(
                                          "معلومات الاتصال بـ ${business.name}"),

                                      GestureDetector(
                                          onTap: () {
                                            launch("tel:" +
                                                Uri.encodeComponent(
                                                    "${business.phoneNumber.toString()}"));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 35,
                                            child: TextField(
                                              enabled: false,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 7,
                                                    right: 8),
                                                prefixIcon: Icon(
                                                  Icons.phone,
                                                  color: Colors.green,
                                                  size: 20,
                                                ),
                                                hintText: business.phoneNumber
                                                    .toString(), //String Data form DB.
                                              ),
                                            ),
                                          )),
                                      LabelTextField(Icons.email,
                                          Colors.red[600], business.email),

                                      CustomTitle("معلومات الزبون"),

                                      LabelTextField(Icons.person,
                                          Colors.purple, customer.name),
                                      GestureDetector(
                                          onTap: () {
                                            launch("tel:" +
                                                Uri.encodeComponent(
                                                    "0${customer.phoneNumber.toString()}"));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 35,
                                            child: TextField(
                                              enabled: false,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 7,
                                                    right: 8),
                                                prefixIcon: Icon(
                                                  Icons.phone,
                                                  color: Colors.green,
                                                  size: 20,
                                                ),
                                                hintText:
                                                    "0${customer.phoneNumber.toString()}", //String Data form DB.
                                              ),
                                            ),
                                          )),
                                      LabelTextFieldCityName(Icons.location_on,
                                          Colors.blue, customer.cityName),

                                      CustomTitle("معلومات الطلبية"),

                                      LabelTextField(Icons.short_text,
                                          Colors.green[700], order.description),
                                      LabelTextFieldPrice(order.price
                                          .toString()), // تغير الايكونات بعد اضافتها على الاجهزة بشكل رسمي
                                      LabelTextField(
                                          Icons.date_range,
                                          Colors.deepPurpleAccent[200],
                                          intl.DateFormat('yyyy-MM-dd')
                                              .format(order.date)),
                                      LabelTextField(Icons.scatter_plot,
                                          Colors.grey, orderType),

                                      CustomTitle("طرد غير موزع"),
                                      Container(
                                        margin: EdgeInsets.all(10.0),
                                        child: StreamBuilder<List<Location>>(
                                          stream: LocationServices().locations,
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Text('Loading...');
                                            } else {
                                              locations = snapshot.data;
                                              if (locations == []) {
                                                return LoadingData();
                                              } else {
                                                return DropdownButtonFormField<
                                                    String>(
                                                  value: locationID,
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide: BorderSide(
                                                          width: 1.0,
                                                          color:
                                                              Color(0xff636363),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide: BorderSide(
                                                          width: 2.0,
                                                          color:
                                                              Color(0xff73a16a),
                                                        ),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              right: 20.0,
                                                              left: 10.0),
                                                      labelText: "خط التوصيل",
                                                      labelStyle: TextStyle(
                                                          fontFamily: 'Amiri',
                                                          fontSize: 18.0,
                                                          color: Color(
                                                              0xff316686))),
                                                  items: locations.map(
                                                    (location) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: location.uid
                                                            .toString(),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            location.name,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Amiri',
                                                              fontSize: 16.0,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      locationID = val;
                                                      selected = true;
                                                    });
                                                  },
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      ),

                                      Container(
                                        child: selected
                                            ? _driverDrop()
                                            : Container(
                                                child: Text(""),
                                              ),
                                      ),
                                      FutureBuilder<int>(
                                          future: DriverServices(uid: driverID)
                                              .driverBonusData,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              bonus = (snapshot.data) + 1;
                                              return Text(" ");
                                            } else {
                                              return Text("");
                                            }
                                          }),
                                      // Container(
                                      //   child: driverSelected
                                      //       ? _driverPriceLine()
                                      //       : Container(
                                      //           child: Text(""),
                                      //         ),
                                      // ),
                                      Container(
                                        margin: EdgeInsets.all(40.0),
                                        child: RaisedButton(
                                          padding: EdgeInsets.all(10.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0)),
                                          onPressed: () async {
                                            if (driverID == "" &&
                                                driverID == null) {
                                            } else {
                                              print(bonus);
                                              if (order.type) {
                                                OrderServices(
                                                        uid: widget.uid,
                                                        driverID: driverID)
                                                    .updateOrderToisUrgent;
                                              } else {
                                                OrderServices(
                                                        uid: widget.uid,
                                                        driverID: driverID)
                                                    .updateOrderToisDelivery;
                                              }
                                              await driverCollection
                                                  .doc(driverID)
                                                  .update({
                                                'bonus': (bonus),
                                              });
                                              Toast.show("تم توزيع الطرد بنجاح",
                                                  context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.BOTTOM);
                                              await Future.delayed(
                                                  Duration(milliseconds: 1000));
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          color: Color(0xff73a16a),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'توزيع',
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

  Widget _driverDrop() {
    if (locationID != null) {
      return Container(
        margin: EdgeInsets.all(10.0),
        child: StreamBuilder<List<Driver>>(
          stream: DriverServices(locationID: locationID).driversBylocationID,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading...');
            } else {
              driverList = snapshot.data;

              if (driverList == []) {
                return LoadingData();
              } else {
                return DropdownButtonFormField<String>(
                  value: driverID,
                  decoration: InputDecoration(
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
                      ),
                      contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
                      labelText: "السائقين",
                      labelStyle: TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18.0,
                          color: Color(0xff316686))),
                  items: driverList.map(
                    (driver) {
                      return DropdownMenuItem<String>(
                        value: driver.uid.toString(),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            driver.name,
                            style: TextStyle(
                              fontFamily: 'Amiri',
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(() {
                      driverID = val;
                      // driverSelected = true;
                    });
                  },
                );
              }
            }
          },
        ),
      );
    } else {
      return Container(
        child: Text(""),
      );
    }
  }

  // Widget _driverPriceLine() {
  //   return Form(
  //       key: _formKey,
  //       child: Container(
  //         margin: EdgeInsets.all(10.0),
  //         child: TextFormField(
  //           validator: (value) {
  //             if (value.isEmpty) {
  //               return 'ادخل سعر التوصيل للسائق ';
  //             }
  //             return null;
  //           },
  //           controller: driverPrice,
  //           keyboardType: TextInputType.number,
  //           decoration: InputDecoration(
  //             labelText: " سعر التوصيل للسائق",
  //             labelStyle: TextStyle(
  //                 fontFamily: 'Amiri',
  //                 fontSize: 16.0,
  //                 color: Color(0xff316686)),
  //             contentPadding: EdgeInsets.only(right: 20.0),
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //           ),
  //         ),
  //       ));
  //   // OrderService(
  //   //         uid: order.uid,
  //   //         driverPrice: int.parse(
  //   //             driverPrice.text))
  //   //     .updateDriverPrice;
  //   // Navigator.pop(context);
  // }

}
