import 'dart:ui';
import 'package:AsyadLogistic/components/pages/business_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/deliveriesCost.dart';
import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/classes/mainLine.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/classes/subLine.dart';
import 'package:AsyadLogistic/services/deliveriesCostsServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/mainLineServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:AsyadLogistic/services/subLineServices.dart';
import 'package:toast/toast.dart';

import '../business_main.dart';

class AddNewOdersByBusiness extends StatefulWidget {
  final String name, uid;
  AddNewOdersByBusiness({this.name, this.uid});

  @override
  _AddNewOdersByBusinessState createState() => _AddNewOdersByBusinessState();
}

class _AddNewOdersByBusinessState extends State<AddNewOdersByBusiness> {
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
    return Scaffold(
      endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: BusinessDrawer(name: widget.name)),
      appBar: AppBar(
        title: Text('اضافة طلبية جديدة',
            style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
        centerTitle: true,
        backgroundColor: Color(0xff316686),
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: Form(
                key: _formKey,
                child: ListView(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
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
   
      return Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: StreamBuilder<List<DeliveriesCosts>>(
            stream: DeliveriesCostsServices(businessId: widget.uid)
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
                        .where('businesID', isEqualTo: widget.uid)
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
              print(customerPhoneNumberAdditional.text);
              Customer customer;
              if (customerPhoneNumberAdditional.text == '') {
                customer = new Customer(
                  name: customerName.text,
                  phoneNumber: int.parse(customerPhoneNumber.text),
                  phoneNumberAdditional: int.parse("0"),
                  cityID: cityID,
                  cityName: cityName,
                  address: customerAddress.text,
                  businesID: widget.uid,
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
                  businesID: widget.uid,
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
                businesID: widget.uid,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BusinessMain(name: widget.name, uid: widget.uid)),
              );
            }
          },
          child: Text('اضافة',
              style: TextStyle(
                  fontFamily: 'Amiri', fontSize: 18.0, color: Colors.white))),
    );
  }
}
