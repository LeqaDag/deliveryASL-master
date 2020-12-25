import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/deliveriesCost.dart';
import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/classes/subLine.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/services/deliveriesCostsServices.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:AsyadLogistic/services/subLineServices.dart';
import 'package:toast/toast.dart';

import '../../classes/mainLine.dart';
import '../../services/mainLineServices.dart';

class AddNewOders extends StatefulWidget {
  final String name;
  AddNewOders({this.name});

  @override
  _AddNewOdersState createState() => _AddNewOdersState();
}

class _AddNewOdersState extends State<AddNewOders> {
  final _formKey = GlobalKey<FormState>();
  List<DeliveriesCosts> cities;
  List<SubLine> sublines;
  List<MainLine> mainlines;
  List<Business> business;

  String cityID = "0",
      mainline,
      subline,
      businessID,
      bus = "0",
      cityName = "0",
      sublineName = "0",
      locationID,
      typeOrder = "عادي";
  int orderTotalPrice = 0;
  static String deliveryPrice = "0";
  bool isBusinessSelected, locationSelected, mainlineSelected;
  int indexLine;

  @override
  void initState() {
    deliveryPrice = "0";
    orderTotalPrice = 0;
    indexLine = 0;
    sublineName = "";
    isBusinessSelected = false;
    locationSelected = false;
    super.initState();
  }

  //Order Filed
  TextEditingController orderDescription = new TextEditingController();
  TextEditingController orderPrice = new TextEditingController();
  bool orderType = false;
  DateTime orderDate = new DateTime.now();
  TextEditingController orderNote = new TextEditingController();
  //Customer Fileds
  TextEditingController customerName = new TextEditingController();
  TextEditingController customerPhoneNumber = new TextEditingController();
  TextEditingController customerPhoneNumberAdditional =
      new TextEditingController();
  TextEditingController customerAddress = new TextEditingController();
  //

  List<Location> locations;

  String mainLineID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: AdminDrawer(name: widget.name)),
      appBar: AppBar(
        title: Text('اضافة طلبية جديدة',
            style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
        centerTitle: true,
        backgroundColor: Color(0xff316686),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                _businessChoice(),
              ],
            ),
            _infoLabel(
              "معلومات الزبون",
              Icon(Icons.person, color: Colors.white, size: 30),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _customerName(customerName),
                  Row(
                    children: <Widget>[
                      _customerPhoneNumber(
                          "رقم الزبون", 10, customerPhoneNumber),
                      _customerAdditionPhoneNumber(
                          "رقم احتياطي", 0, customerPhoneNumberAdditional),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      _locationChoice(),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _mainLineChoice(),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _subLineChoice(),
                      _customerAddress(customerAddress),
                    ],
                  ),

                  FutureBuilder<int>(
                      future: SubLineServices(uid: subline).sublineIndex,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          indexLine = snapshot.data ?? -1;
                          return Visibility(
                            child: Text("Gone"),
                            visible: false,
                          );
                        } else {
                          return Visibility(
                            child: Text("Gone"),
                            visible: false,
                          );
                        }
                      }),
                  FutureBuilder<String>(
                      future: SubLineServices(uid: subline).sublineName,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          sublineName = snapshot.data ?? -1;
                          return Visibility(
                            child: Text("Gone"),
                            visible: false,
                          );
                        } else {
                          return Visibility(
                            child: Text("Gone"),
                            visible: false,
                          );
                        }
                      }),

                  FutureBuilder<String>(
                      future:
                          MainLineServices(uid: mainline).cityNameByMainLine,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data.toString());
                          cityName = snapshot.data ?? "";
                          return Visibility(
                            child: Text("Gone"),
                            visible: false,
                          );
                        } else {
                          return Visibility(
                            child: Text("Gone"),
                            visible: false,
                          );
                        }
                      }),
                  _infoLabel(
                    "معلومات الطلبية",
                    Icon(Icons.info, color: Colors.white, size: 30),
                  ),
                  _orderDescription(orderDescription),
                  // Row(
                  //   children: <Widget>[
                  //     _deliveryType(),
                  //   ],
                  // ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          child: TextFormField(
                            onChanged: (String newValue) {
                              setState(() {
                                deliveryPrice = newValue;
                              });
                            },
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: deliveryPrice,
                              labelStyle: TextStyle(
                                  fontFamily: 'Amiri',
                                  fontSize: 18.0,
                                  color: Colors.red),
                              contentPadding: EdgeInsets.only(right: 20.0),
                              filled: true,
                              fillColor: Color(0xffC6C4C4),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'ادخل سعر المنتج ';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                orderTotalPrice = (int.parse(value) +
                                    int.parse(deliveryPrice));
                              });
                            },
                            controller: orderPrice,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "سعر المنتج",
                              labelStyle: TextStyle(
                                  fontFamily: 'Amiri',
                                  fontSize: 18.0,
                                  color: Color(0xff316686)),
                              contentPadding: EdgeInsets.only(right: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 0),
                          child: TextFormField(
                            enabled: false,
                            //controller: totalPriceController,
                            decoration: InputDecoration(
                              labelText: orderTotalPrice.toString(),
                              contentPadding: EdgeInsets.only(right: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _notes(orderNote),

                  _addNewOrderButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoLabel(String lableText, Icon icon) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xff316686),
          labelText: lableText,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'Amiri',
          ),
          contentPadding: EdgeInsets.only(right: 20),
          prefixIcon: icon, //Icon(Icons.person,color: Colors.white,size: 30,),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide()),
        ),
      ),
    );
  }

  Widget _customerName(TextEditingController fieldController) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'ادخل اسم الزبون  ';
          }
          return null;
        },
        controller: fieldController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
          labelText: "اسم الزبون",
          labelStyle: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 18.0,
            color: Color(0xff316686),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _customerPhoneNumber(
      String labletext, double right, TextEditingController fieldController) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: right),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'ادخل رقم جوال';
            } else if (value.length != 10 || value.length > 10) {
              return 'الرجاء ادخال رقم جوال صحيح';
            }
            return null;
          },
          controller: fieldController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 20),
            labelText: labletext,
            labelStyle: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 18.0,
              color: Color(0xff316686),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customerAdditionPhoneNumber(
      String labletext, double right, TextEditingController fieldController) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: right),
        child: TextFormField(
          // validator: (value) {
          //   if (value.length != 10 || value.length > 10) {
          //     return 'الرجاء ادخال رقم جوال صحيح';
          //   }
          //   return null;
          // },
          controller: fieldController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 20),
            labelText: labletext,
            labelStyle: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 18.0,
              color: Color(0xff316686),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _locationChoice() {
    if (isBusinessSelected == true) {
      return Expanded(
        flex: 2,
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: StreamBuilder<List<DeliveriesCosts>>(
              stream: DeliveriesCostsServices(businessId: businessID)
                  .deliveryCostsBusiness,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading...');
                } else {
                  cities = snapshot.data;
                  return DropdownButtonFormField<String>(
                    value: locationID,
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
                      labelText: "المنطقة",
                      labelStyle: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 18.0,
                        color: Color(0xff316686),
                      ),
                    ),
                    items: cities.map(
                      (location) {
                        return DropdownMenuItem<String>(
                          value: location.locationID.toString(),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                location.locationName,
                                style: TextStyle(
                                  fontFamily: 'Amiri',
                                  fontSize: 16.0,
                                ),
                              )),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(() {
                        locationID = val;
                        FirebaseFirestore.instance
                            .collection('delivery_costs')
                            .where('locationID', isEqualTo: locationID)
                            .where('businesID', isEqualTo: businessID)
                            .get()
                            .then((value) => {
                                  setState(() {
                                    locationSelected = true;
                                    deliveryPrice =
                                        value.docs[0]["deliveryPrice"];
                                    //cityName = value.docs[0]["locationName"];
                                  })
                                });
                      });
                    },
                  );
                }
              }),
        ),
      );
    } else {
      return Expanded(
        flex: 2,
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          // ignore: missing_required_param
          child: DropdownButtonFormField<String>(
            value: locationID,
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
              labelText: "المنطقة",
              labelStyle: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 18.0,
                color: Color(0xff316686),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _subLineChoice() {
    return Expanded(
      // flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: StreamBuilder<List<SubLine>>(
            stream: SubLineServices(mainLineID: mainline).subLinesByMainLineID,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              } else {
                sublines = snapshot.data;
                return DropdownButtonFormField<String>(
                  value: subline,
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
                    labelText: " العنوان",
                    labelStyle: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 18.0,
                      color: Color(0xff316686),
                    ),
                  ),
                  items: sublines.map(
                    (subline) {
                      return DropdownMenuItem<String>(
                        value: subline.uid.toString(),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              subline.name,
                              style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 16.0,
                              ),
                            )),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(() {
                      subline = val;
                    });
                  },
                );
              }
            }),
      ),
    );
  }

  Widget _mainLineChoice() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: StreamBuilder<List<MainLine>>(
            stream:
                MainLineServices(locationID: locationID).mainLineByLocationID,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              } else {
                mainlines = snapshot.data;
                return DropdownButtonFormField<String>(
                  value: mainline,
                  isExpanded: true,
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
                    labelText: " المدينة",
                    labelStyle: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 18.0,
                      color: Color(0xff316686),
                    ),
                  ),
                  items: mainlines.map(
                    (mainline) {
                      print(mainline.name);
                      return DropdownMenuItem<String>(
                        value: mainline.uid.toString(),
                        child: Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${mainline.name}-${mainline.cityName}',
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: 16.0,
                                  ),
                                ))),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(() {
                      mainline = val;
                      print(mainline);
                    });
                  },
                );
              }
            }),
      ),
    );
  }

  Widget _customerAddress(TextEditingController fieldController) {
    return Expanded(
      //flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 0),
        child: TextFormField(
          controller: fieldController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
            labelText: "العنوان",
            labelStyle: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 18.0,
              color: Color(0xff316686),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _orderDescription(TextEditingController fieldController) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        controller: fieldController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
          labelText: "وصف الطلبية",
          labelStyle: TextStyle(
              fontFamily: 'Amiri', fontSize: 18.0, color: Color(0xff316686)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _deliveryType() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: DropdownButtonFormField(
          onChanged: (String newValue) {
            setState(() {
              //  typeOrder = newValue;
            });
          },
          items: <String>['عادي', 'مستعجل']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontFamily: 'Amiri', fontSize: 16.0),
                ),
              ),
            );
          }).toList(),
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
                //Change color to Color(0xff73a16a)
              ),
              contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
              labelText: "نوع التوصيل",
              labelStyle: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 18.0,
                  color: Color(0xff316686))),
        ),
      ),
    );
  }

  Widget _notes(TextEditingController fieldController) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: TextFormField(
        controller: fieldController,

        //minLines: 2,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
          labelText: "الملاحظات",
          labelStyle: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 18.0,
            color: Color(0xff316686),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _addNewOrderButton() {
    return Container(
      child: RaisedButton(
          padding: EdgeInsets.only(right: 60, left: 60),
          color: Color(0xff73A16A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Color(0xff73A16A)),
          ),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              // print(int.parse(orderPrice.text) +
              //     int.parse(deliveryPrice));

              Customer customer;
              if (customerPhoneNumberAdditional.text == '') {
                customer = new Customer(
                  name: customerName.text,
                  phoneNumber: int.parse(customerPhoneNumber.text),
                  phoneNumberAdditional: int.parse("0"),
                  cityID: cityID,
                  cityName: cityName,
                  address: customerAddress.text,
                  businesID: businessID,
                  sublineName: sublineName,
                  isArchived: false,
                );
              } else {
                customer = new Customer(
                  name: customerName.text,
                  phoneNumber: int.parse(customerPhoneNumber.text),
                  phoneNumberAdditional:
                      int.parse(customerPhoneNumberAdditional.text),
                  cityID: cityID,
                  cityName: cityName,
                  address: customerAddress.text,
                  businesID: businessID,
                  sublineName: sublineName,
                  isArchived: false,
                );
              }
              bool isUrgent = false;
              String customerID =
                  await CustomerServices().addcustomerData(customer);

              if (typeOrder == "عادي") {
                isUrgent = false;
              } else {
                isUrgent = true;
              }
              await OrderServices().addOrderData(new Order(
                price: int.parse(orderPrice.text),
                totalPrice: orderTotalPrice,
                type: false,
                description: orderDescription.text,
                date: orderDate,
                note: orderNote.text,
                isLoading: true,
                isLoadingDate: DateTime.now(),
                isReceived: false,
                isDelivery: false,
                isUrgent: isUrgent,
                isCancelld: false,
                isReturn: false,
                isDone: false,
                isPaid: false,
                inStock: false,
                customerID: customerID,
                businesID: businessID,
                driverID: "",
                isArchived: false,
                sublineID: subline,
                locationID: locationID,
                indexLine: indexLine,
                mainLineIndex: 0,
                mainlineID: mainline,
                isPaidDriver: false,
                paidDriverDate: DateTime.now(),
                isReceivedDate: DateTime.now(),
                isDeliveryDate: DateTime.now(),
                isCancelldDate: DateTime.now(),
                isReturnDate: DateTime.now(),
                isDoneDate: DateTime.now(),
                isPaidDate: DateTime.now(),
                inStockDate: DateTime.now(),
              ));
              Toast.show("تم اضافة الطلبية بنجاح", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              await Future.delayed(Duration(milliseconds: 1000));
              customerPhoneNumber.clear();
              orderDescription.clear();
              orderPrice.clear();
              customerName.clear();
              customerAddress.clear();
              customerPhoneNumberAdditional.clear();
              orderTotalPrice = 0;
            }
          },
          child: Text('اضافة',
              style: TextStyle(
                  fontFamily: 'Amiri', fontSize: 18.0, color: Colors.white))),
    );
  }

  Widget _businessChoice() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: StreamBuilder<List<Business>>(
            stream: BusinessServices().business,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                business = snapshot.data;
                print(business.length);

                return DropdownButtonFormField<String>(
                  value: businessID,
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
                    labelText: "الشركة",
                    labelStyle: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 18.0,
                      color: Color(0xff316686),
                    ),
                  ),
                  items: business.map(
                    (busines) {
                      return DropdownMenuItem<String>(
                        value: busines.uid.toString(),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              busines.name,
                              style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 16.0,
                              ),
                            )),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(() {
                      //bus = val;
                      businessID = val;
                      deliveryPrice = "0";
                      orderTotalPrice = 0;
                      orderPrice.text = "";
                      isBusinessSelected = true;
                    });
                  },
                );
              } else {
                return Text('يتم التحميل ...');
              }
            }),
      ),
    );
  }
}
