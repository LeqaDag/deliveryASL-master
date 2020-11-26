import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/classes/customer.dart';
import 'package:sajeda_app/classes/deliveriesCost.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/classes/subLine.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/DeliveriesCostsServices.dart';
import 'package:sajeda_app/services/businessServices.dart';
import 'package:sajeda_app/services/customerServices.dart';
import 'package:sajeda_app/services/orderServices.dart';
import 'package:sajeda_app/services/subLineServices.dart';
import 'package:toast/toast.dart';

class AddNewOders extends StatefulWidget {
  final String name;
  AddNewOders({this.name});

  @override
  _AddNewOdersState createState() => _AddNewOdersState();
}

class _AddNewOdersState extends State<AddNewOders> {
  final _formKey = GlobalKey<FormState>();
  String customerCityID = 'One';
  String datehh = "", typeOrder = ' نوع التوصيل';
  List<DeliveriesCosts> cities;
  List<SubLine> sublines;
  List<Business> business;
  String cityID,
      subline,
      businessID = "",
      bus,
      cityName = "",
      cityId = "",
      cityIDAddress;
  List<int> orderTotalPrice = [0];
  static String deliveryPrice = "0";

  @override
  void initState() {
    deliveryPrice = "0";
    orderTotalPrice = [0];
    businessID = "";
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
                      _customerPhoneNumber(
                          "رقم احتياطي", 0, customerPhoneNumberAdditional),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _cityChoice(),
                      _subLineChoice(),
                    ],
                  ),
                  Row(
                    children: <Widget>[
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
                      _deliveryType(),
                    ],
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'ادخل سعر المنتج ';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                orderTotalPrice[0] = (int.parse(value) +
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
                            decoration: InputDecoration(
                              labelText: orderTotalPrice[0].toString(),
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

  Widget _cityChoice() {
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
                  value: cityID,
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
                      color: Color(0xff316686),
                    ),
                  ),
                  items: cities.map(
                    (city) {
                      return DropdownMenuItem<String>(
                        value: city.city.toString(),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              city.name,
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
                      cityID = val;
                      cityIDAddress = val;
                      FirebaseFirestore.instance
                          .collection('deliveries_costs')
                          .where('city', isEqualTo: cityID)
                          .get()
                          .then((value) => {
                                setState(() {
                                  deliveryPrice =
                                      value.docs[0]["deliveryPrice"];
                                  cityName = value.docs[0]["name"];
                                })
                              });
                    });
                  },
                );
              }
            }),
      ),
    );
  }

  Widget _subLineChoice() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: StreamBuilder<List<SubLine>>(
            stream: SubLineServices(cityID: cityIDAddress).subLinesCustomers,
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
                    labelText: "العنوان الفرعي",
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
                      print(subline);
                      // FirebaseFirestore.instance
                      //     .collection('deliveries_costs')
                      //     .where('city', isEqualTo: cityID)
                      //     .get()
                      //     .then((value) => {
                      //           setState(() {
                      //             deliveryPrice =
                      //                 value.docs[0]["deliveryPrice"];
                      //             cityName = value.docs[0]["name"];
                      //           })
                      //         });
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
      flex: 3,
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
              typeOrder = newValue;
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
              if (typeOrder == 'مستعجل') orderType = true;
              Customer customer = new Customer(
                  name: customerName.text,
                  phoneNumber: int.parse(customerPhoneNumber.text),
                  phoneNumberAdditional:
                      int.parse(customerPhoneNumberAdditional.text),
                  cityID: cityID,
                  cityName: cityName,
                  address: customerAddress.text,
                  businesID: businessID,
                  isArchived: false);
              String customerID =
                  await CustomerService().addcustomerData(customer);

              await OrderService().addOrderData(new Order(
                  price: int.parse(orderPrice.text),
                  totalPrice: orderTotalPrice,
                  type: orderType,
                  description: orderDescription.text,
                  date: orderDate,
                  note: orderNote.text,
                  customerID: customerID,
                  businesID: businessID,
                  sublineID: subline,
                  driverID: ""));
              Toast.show("تم اضافة الطلبية بنجاح", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              await Future.delayed(Duration(milliseconds: 1000));
              Navigator.of(context).pop();
            }
            // Customer customer = new Customer(
            //     name: customerName.text,
            //     phoneNumber: int.parse(customerPhoneNumber.text),
            //     phoneNumberAdditional:
            //         int.parse(customerPhoneNumberAdditional.text),
            //     cityID: customerCityID,
            //     address: customerAddress.text,
            //     isArchived: false);
            // String customerID =
            //     await CustomerService().addcustomerData(customer);

            // await OrderService().addOrderData(new Order(
            //     price: int.parse(orderPrice.text),
            //     totalPrice: orderTotalPrice,
            //     type: orderType,
            //     description: orderDescription.text,
            //     date: orderDate,
            //     note: orderNote.text,
            //     customerID: customerID,
            //     businesID: businessID));
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
            stream: BusinessService().business,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('يتم التحميل ...');
              } else {
                business = snapshot.data;
                return DropdownButtonFormField<String>(
                  value: bus,
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
                    (bus) {
                      return DropdownMenuItem<String>(
                        value: bus.uid.toString(),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              bus.name,
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
                      businessID = val;
                      deliveryPrice = "0";
                      orderTotalPrice[0] = 0;
                      orderPrice.text = "";
                    });
                  },
                );
              }
            }),
      ),
    );
  }
}
