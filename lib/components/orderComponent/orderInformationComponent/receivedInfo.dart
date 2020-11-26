import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/classes/customer.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/classes/mainLine.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/orderComponent/orderInformationComponent/divide.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/components/pages/loadingData.dart';
import 'package:sajeda_app/services/businessServices.dart';
import 'package:sajeda_app/services/cityServices.dart';
import 'package:sajeda_app/services/customerServices.dart';
import 'package:sajeda_app/services/driverServices.dart';
import 'package:sajeda_app/services/mainLineServices.dart';
import 'package:sajeda_app/services/orderServices.dart';
import 'package:intl/intl.dart' as intl;
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
  Driver driver;
  final _formKey = GlobalKey<FormState>();
  List<MainLine> mainLines;
  String mainLineID;

  List<Driver> driverList;
  String driverID;
  bool selected = false, driverSelected = false;
  TextEditingController driverPrice = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Order>(
        stream: OrderService(uid: widget.uid).orderData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Order order = snapshot.data;
            String orderType = '';
            if (!order.type) {
              orderType = "عادي";
            } else {
              orderType = "مستعجل";
            }
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
                                      _customTitle(
                                          "معلومات الاتصال بـ ${business.name}"),

                                      GestureDetector(
                                          onTap: () {
                                            print(customer.phoneNumber
                                                .toString());
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
                                      _labelTextField(Icons.email,
                                          Colors.red[600], business.email),

                                      _customTitle("معلومات الزبون"),

                                      _labelTextField(Icons.person,
                                          Colors.purple, customer.name),
                                      GestureDetector(
                                          onTap: () {
                                            print(customer.phoneNumber
                                                .toString());
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
                                      _labelTextFieldCity(Icons.location_on,
                                          Colors.blue, customer.cityID),

                                      _customTitle("معلومات الطلبية"),

                                      _labelTextField(Icons.short_text,
                                          Colors.green[700], order.description),
                                      _labelTextFieldPrice(order.price
                                          .toString()), // تغير الايكونات بعد اضافتها على الاجهزة بشكل رسمي
                                      _labelTextField(
                                          Icons.date_range,
                                          Colors.deepPurpleAccent[200],
                                          intl.DateFormat('yyyy-MM-dd')
                                              .format(order.date)),
                                      _labelTextField(Icons.scatter_plot,
                                          Colors.grey, orderType),

                                      _customTitle("طرد غير موزع"),
                                      Container(
                                        margin: EdgeInsets.all(10.0),
                                        child: StreamBuilder<List<MainLine>>(
                                          stream: MainLineServices(
                                                  cityID: customer.cityID)
                                              .mainLineByCityID,
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Text('Loading...');
                                            } else {
                                              mainLines = snapshot.data;
                                              if (mainLines == []) {
                                                return LoadingData();
                                              } else {
                                                return DropdownButtonFormField<
                                                    String>(
                                                  value: mainLineID,
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
                                                  items: mainLines.map(
                                                    (mainLine) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: mainLine.uid
                                                            .toString(),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            mainLine.name,
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
                                                      mainLineID = val;
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
                                      Container(
                                        child: driverSelected
                                            ? _driverPriceLine()
                                            : Container(
                                                child: Text(""),
                                              ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(40.0),
                                        child: RaisedButton(
                                          padding: EdgeInsets.all(10.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0)),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              if (driverID == "" &&
                                                  driverID == null) {
                                              } else {
                                                if (order.type) {
                                                  OrderService(
                                                          uid: widget.uid,
                                                          driverID: driverID)
                                                      .updateOrderToisUrgent;
                                                } else {
                                                  OrderService(
                                                          uid: widget.uid,
                                                          driverID: driverID)
                                                      .updateOrderToisDelivery;
                                                }
                                                OrderService(
                                                        uid: widget.uid,
                                                        driverPrice: int.parse(
                                                            driverPrice.text))
                                                    .updateDriverPrice;
                                                Navigator.pop(context);
                                              }
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
    if (mainLineID != null) {
      return Container(
        margin: EdgeInsets.all(10.0),
        child: StreamBuilder<List<Driver>>(
          stream: DriverService(mainLineID: mainLineID).driversBymainLineID,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('Loading...');
            } else {
              driverList = snapshot.data;
              print(driverList);
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
                      driverSelected = true;
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
        child: Text("ssssss"),
      );
    }
  }

  Widget _driverPriceLine() {
    return Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'ادخل سعر التوصيل للسائق ';
              }
              return null;
            },
            controller: driverPrice,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: " سعر التوصيل للسائق",
              labelStyle: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 16.0,
                  color: Color(0xff316686)),
              contentPadding: EdgeInsets.only(right: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ));
    // OrderService(
    //         uid: order.uid,
    //         driverPrice: int.parse(
    //             driverPrice.text))
    //     .updateDriverPrice;
    // Navigator.pop(context);
  }

  Widget _customTitle(String title) {
    return Container(
      width: double.infinity,
      height: 40,
      color: KCustomCompanyOrdersStatus,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Amiri",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _labelTextFieldPhone(IconData icon, Color color, String text) {
    return Container(
      width: double.infinity,
      height: 35,
      child: TextField(
        onTap: () => launch("tel:0595114481"),
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
          prefixIcon: Icon(
            icon,
            color: color,
            size: 20,
          ),
          hintText: text, //String Data form DB.
        ),
      ),
    );
  }

  Widget _labelTextFieldPrice(String text) {
    return Container(
      width: double.infinity,
      height: 35,
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
          prefixIcon: Image.asset('assets/price.png'),
          hintText: text, //String Data form DB.
        ),
      ),
    );
  }

  Widget _labelTextField(IconData icon, Color color, String text) {
    return Container(
      width: double.infinity,
      height: 35,
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
          prefixIcon: Icon(
            icon,
            color: color,
            size: 20,
          ),
          hintText: text, //String Data form DB.
        ),
      ),
    );
  }

  Widget _labelTextFieldCity(IconData icon, Color color, String text) {
    return Container(
      width: double.infinity,
      height: 35,
      child: StreamBuilder<City>(
          stream: CityService(uid: text).cityByID,
          builder: (context, snapshot) {
            City city = snapshot.data;
            return TextField(
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
                prefixIcon: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
                hintText: city.name, //String Data form DB.
              ),
            );
          }),
    );
  }
}
