import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../classes/mainLine.dart';
import '../../services/mainLineServices.dart';

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
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:toast/toast.dart';

class AddOrder extends StatefulWidget {
  final String name;
  AddOrder({this.name});
  @override
  _AddOrderState createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<FormFieldState>();
  List<DeliveriesCosts> cities;
  List<SubLine> sublines;
  List<MainLine> mainlines;
  List<Business> business;

  List<Location> locations;
  String cityID = "0",
      mainline,
      mainlineID,
      subline,
      businessID,
      bus = "0",
      cityName = "0",
      sublineName = "",
      locationID,
      locationId,
      typeOrder = "عادي";
  int orderTotalPrice = 0;
  static String deliveryPrice = "0";
  bool isBusinessSelected = false,
      isLocationSelected = false,
      mainlineSelected = false,
      isSubLineSelected = false,
      priceEnabled = false;
  int indexLine = 0;
  reset() {
    _key.currentState.reset();
  }

  // void maxBarcodeValue() async {
  //   String barcode = await OrderServices().maxBarcodeValue;
  //   setState(() {
  //     maxBarcode = barcode.substring(6);
  //   });
  // }

  @override
  void initState() {
    setState(() {
      deliveryPrice = "0";
      orderTotalPrice = 0;
      indexLine = 0;
      sublineName = "";
      mainline = "";
      // locationID = "";
      isBusinessSelected = false;
      isLocationSelected = false;
    });
    super.initState();
  }

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
  @override
  Widget build(BuildContext context) {
    // print(maxBarcode + "fngjfdngb");
    return Scaffold(
      endDrawer: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: AdminDrawer(name: widget.name)),
      appBar: AppBar(
        title: Text('اضافة طلبية جديدة',
            style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
        centerTitle: true,
        backgroundColor: Color(0xff316686),
      ),
      body: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Form(
                key: _formKey,
                child: ListView(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      child: StreamBuilder<List<Business>>(
                        stream: BusinessServices().business,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            business = snapshot.data;
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
                                contentPadding:
                                    EdgeInsets.only(right: 20.0, left: 10.0),
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
                                  bus = val;
                                  businessID = val;
                                  deliveryPrice = "0";
                                  orderTotalPrice = 0;
                                  orderPrice.text = "";
                                  isBusinessSelected = true;
                                });
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              },
                            );
                          } else {
                            return Text('يتم التحميل ...');
                          }
                        },
                      ),
                    ),
                    _infoLabel(
                      "معلومات الزبون",
                      Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'ادخل اسم الزبون  ';
                          }
                          return null;
                        },
                        controller: customerName,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(right: 20.0, left: 10.0),
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
                    ),
                    Row(
                      children: <Widget>[
                        _customerPhoneNumber(
                            "رقم الزبون", 10, customerPhoneNumber),
                        _customerAdditionPhoneNumber(
                            "رقم احتياطي", 0, customerPhoneNumberAdditional),
                      ],
                    ),
                    _locationChoice(),
                    _mainLineChoice(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _subLineChoice(),
                        _customerAddress(customerAddress),
                      ],
                    ),
                    _infoLabel(
                      "معلومات الطلبية",
                      Icon(Icons.info, color: Colors.white, size: 30),
                    ),
                    _orderDescription(orderDescription),
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
                              enabled: priceEnabled,
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
                    Row(
                      children: <Widget>[
                        _deliveryType(),
                      ],
                    ),
                    _notes(orderNote),
                    _addNewOrderButton(),
                  ],
                ),
              ),
            ),
          )),
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
      return Container(
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
                      locationId = val;
                      isLocationSelected = true;
                      mainlineSelected = false;
                      mainlines = null;
                      mainline = '';
                      priceEnabled = true;
                    });
                    orderPrice.clear();

                    FirebaseFirestore.instance
                        .collection('delivery_costs')
                        .where('locationID', isEqualTo: locationID)
                        .where('businesID', isEqualTo: businessID)
                        .get()
                        .then(
                          (value) => {
                            setState(
                              () {
                                // isLocationSelected = true;
                                deliveryPrice = value.docs[0]["deliveryPrice"];
                                //cityName = value.docs[0]["locationName"];
                              },
                            )
                          },
                        );
                    orderTotalPrice = 0;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                );
              }
            }),
      );
    } else {
      return Container(
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
      );
    }
  }

  Widget _orderDescription(TextEditingController fieldController) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Expanded(
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
      ),
    );
  }

  Widget _mainLineChoice() {
    print(locationID);
    if (isLocationSelected == true) {
      return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: StreamBuilder<List<MainLine>>(
            stream:
                MainLineServices(locationID: locationID).mainLineByLocationID,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              } else if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text('snapshot.error');
              } else {
                mainlines = snapshot.data ?? [];
                print(mainlines);
                return DropdownButtonFormField<String>(
                  // key: _key,
                  value: mainlineSelected ? mainline : null,
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
                    (mainL) {
                      return DropdownMenuItem<String>(
                        value: mainL.uid.toString(),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${mainL.name}-${mainL.cityName}',
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
                      mainline = val;
                      mainlineID = mainline;
                      mainlineSelected = true;
                      subline = '';
                      sublines = null;
                      isSubLineSelected = false;

                      FirebaseFirestore.instance
                          .collection('mainLines')
                          .doc(mainline)
                          .get()
                          .then(
                            (value) => {
                              setState(
                                () {
                                  cityName = value.data()["cityName"];
                                },
                              )
                            },
                          );

                      // print("mainline: ");
                      // print(mainline);
                    });
                    FocusScope.of(context).requestFocus(new FocusNode());
                    // _key.currentState.reset();
                  },
                );
              }
            }),
      );
    } else {
      return Container(
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
            labelText: "المدينة",
            labelStyle: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 18.0,
              color: Color(0xff636363),
            ),
          ),
        ),
      );
    }
  }

  Widget _subLineChoice() {
    // print(mainline);
    if (mainlineSelected == true) {
      return Flexible(
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: StreamBuilder<List<SubLine>>(
              stream:
                  SubLineServices(mainLineID: mainline).subLinesByMainLineID,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading...');
                } else {
                  sublines = snapshot.data;
                  // print(sublines);
                  return DropdownButtonFormField<String>(
                    value: isSubLineSelected ? subline : null,
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
                      (sub) {
                        return DropdownMenuItem<String>(
                          value: sub.uid.toString(),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                sub.name,
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
                        isSubLineSelected = true;
                        print(subline);
                        FirebaseFirestore.instance
                            .collection('subLines')
                            .doc(subline)
                            .get()
                            .then(
                              (value) => {
                                setState(
                                  () {
                                    sublineName = value.data()["name"];
                                  },
                                )
                              },
                            );

                        FirebaseFirestore.instance
                            .collection('subLines')
                            .doc(subline)
                            .get()
                            .then(
                              (value) => {
                                setState(
                                  () {
                                    indexLine = value.data()["indexLine"];
                                  },
                                )
                              },
                            );
                      });

                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  );
                }
              }),
        ),
      );
    } else {
      return Flexible(
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          child: DropdownButtonFormField<String>(
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
              labelText: "المدينة",
              labelStyle: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 18.0,
                color: Color(0xff636363),
              ),
            ),
            items: [],
            onChanged: (val) {},
          ),
        ),
      );
    }
  }

  Widget _customerAddress(TextEditingController fieldController) {
    return Flexible(
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

  Widget _deliveryType() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: DropdownButtonFormField(
          onChanged: (String newValue) {
            setState(() {
              typeOrder = newValue;
            });
            FocusScope.of(context).requestFocus(new FocusNode());
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
              labelText: typeOrder,
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
      child: Expanded(
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
      ),
    );
  }

  Widget _addNewOrderButton() {
    return StreamBuilder<List<Order>>(
        stream: OrderServices().orders,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Order> orders = snapshot.data;
            orders.sort((a, b) => a.barcode.compareTo(b.barcode));
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

                      // setState(() {
                      //   maxBarcodeValue();
                      // });
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
                      String barcode = '';
                      String maxBarcode = orders.last.barcode.substring(6);
                      String maxValue = '';
                      print(maxBarcode);
                      switch ((int.parse(maxBarcode) + 1).toString().length) {
                        case 1:
                          {
                            maxValue = "00000" +
                                (int.parse(maxBarcode) + 1).toString();
                          }
                          break;
                        case 2:
                          {
                            maxValue =
                                "0000" + (int.parse(maxBarcode) + 1).toString();
                          }
                          break;
                        case 3:
                          {
                            maxValue =
                                "000" + (int.parse(maxBarcode) + 1).toString();
                          }
                          break;
                        case 4:
                          {
                            maxValue =
                                "00" + (int.parse(maxBarcode) + 1).toString();
                          }
                          break;
                        case 5:
                          {
                            maxValue =
                                "0" + (int.parse(maxBarcode) + 1).toString();
                          }
                          break;
                        case 6:
                          {
                            maxValue = "000000";
                          }
                          break;
                        default:
                      }
                      if (DateTime.now().month.toString().length > 1) {
                        barcode = DateTime.now().year.toString() +
                            DateFormat.M().format(DateTime.now()) +
                            maxValue;
                      } else {
                        barcode = DateTime.now().year.toString() +
                            ("0" + DateFormat.M().format(DateTime.now())) +
                            maxValue;
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
                        barcode: barcode,
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
                          fontFamily: 'Amiri',
                          fontSize: 18.0,
                          color: Colors.white))),
            );
          } else {
            return Container();
          }
        });
  }
}
