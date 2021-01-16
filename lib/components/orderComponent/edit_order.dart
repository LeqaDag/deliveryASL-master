import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/deliveriesCost.dart';
import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/classes/mainLine.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/classes/subLine.dart';
import 'package:AsyadLogistic/services/DeliveriesCostsServices.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:AsyadLogistic/services/mainLineServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:AsyadLogistic/services/subLineServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:toast/toast.dart';

class EditOrder extends StatefulWidget {
  final String name;
  final Order order;
  EditOrder({this.name, this.order});

  @override
  _EditOrderState createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
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
      typeOrder = "عادي",
      businessName,
      phoneNumber,
      additionalNumber,
      address,
      locationName,
      mainLineName,
      subName,
      customerAddress,
      orderDescription,
      orderNote,
      customerName;
  int orderTotalPrice = 0;
  String deliveryPrice;
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
      deliveryPrice =
          ((widget.order.totalPrice - widget.order.price).toString());
      orderTotalPrice = widget.order.totalPrice;
      indexLine = 0;
      sublineName = "";
      mainline = "";
      mainLineName = " ";
      locationName = "";
      subName = "";
      orderDescription = "";
      customerAddress = "";
      orderNote = "";
      isBusinessSelected = false;
      isLocationSelected = false;
    });
    super.initState();
  }

  bool orderType = false;
  DateTime orderDate = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Order>(
        stream: OrderServices(uid: widget.order.uid).orderByID,
        builder: (context, snapshot) {
          Order orderData = snapshot.data;
          return StreamBuilder<Customer>(
              stream: CustomerServices(uid: orderData.customerID).customerByID,
              builder: (context, snapshot) {
                Customer customerData = snapshot.data;
                return Scaffold(
                  endDrawer: Directionality(
                      textDirection: TextDirection.rtl,
                      child: AdminDrawer(name: widget.name)),
                  appBar: AppBar(
                    title: Text("تعديل طرد  ${customerData.name}",
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
                                FutureBuilder<String>(
                                    future: BusinessServices(
                                            uid: orderData.businesID)
                                        .businessName,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        businessName = snapshot.data.toString();
                                        return Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: StreamBuilder<List<Business>>(
                                            stream: BusinessServices().business,
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('Loading...');
                                              } else {
                                                business = snapshot.data;
                                                return DropdownButtonFormField<
                                                    String>(
                                                  value: businessID,
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
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            right: 20.0,
                                                            left: 10.0),
                                                    labelText: businessName,
                                                    labelStyle: TextStyle(
                                                      fontFamily: 'Amiri',
                                                      fontSize: 18.0,
                                                      color: Color(0xff316686),
                                                    ),
                                                  ),
                                                  items: business.map(
                                                    (busines) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: busines.uid
                                                            .toString(),
                                                        child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              busines.name,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Amiri',
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
                                                      //orderPrice.text = "";
                                                      isBusinessSelected = true;
                                                    });
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                        );
                                      } else {
                                        return Text("");
                                      }
                                    }),
                                _infoLabel(
                                  "معلومات الزبون",
                                  Icon(Icons.person,
                                      color: Colors.white, size: 30),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: TextFormField(
                                    onChanged: (String newValue) {
                                      setState(() {
                                        customerName = newValue;
                                      });
                                    },
                                    // initialValue: customerData.name,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          right: 20.0, left: 10.0),
                                      labelText: customerData.name,
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
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: TextFormField(
                                    onChanged: (String newValue) {
                                      setState(() {
                                        phoneNumber = newValue;
                                      });
                                    },
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(right: 20),
                                      labelText: "0" +
                                          customerData.phoneNumber.toString(),
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
                                // Container(
                                //   margin: EdgeInsets.only(
                                //       top: 10, bottom: 10, left: 10, right: 10),
                                //   child: TextFormField(
                                //     onChanged: (String newValue) {
                                //       setState(() {
                                //         additionalNumber = newValue;
                                //       });
                                //     },
                                //     initialValue: "0" +
                                //         customerData.phoneNumberAdditional
                                //             .toString(),
                                //     keyboardType:
                                //         TextInputType.numberWithOptions(
                                //             decimal: true),
                                //     decoration: InputDecoration(
                                //       contentPadding:
                                //           EdgeInsets.only(right: 20),
                                //       labelText: "رقم احتياطي",
                                //       labelStyle: TextStyle(
                                //         fontFamily: 'Amiri',
                                //         fontSize: 18.0,
                                //         color: Color(0xff316686),
                                //       ),
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(10),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                _locationChoice(),
                                _mainLineChoice(),
                                _subLineChoice(orderData.sublineID),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 10,
                                            right: 10),
                                        child: TextFormField(
                                          initialValue: customerData.address,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              address = newValue;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                right: 20.0, left: 10.0),
                                            labelText: "العنوان بالتفصيل",
                                            labelStyle: TextStyle(
                                              fontFamily: 'Amiri',
                                              fontSize: 18.0,
                                              color: Color(0xff316686),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                _infoLabel(
                                  "معلومات الطلبية",
                                  Icon(Icons.info,
                                      color: Colors.white, size: 30),
                                ),
                                _orderDescription(orderData.description),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 10,
                                            right: 10),
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
                                            contentPadding:
                                                EdgeInsets.only(right: 20.0),
                                            filled: true,
                                            fillColor: Color(0xffC6C4C4),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 10,
                                            right: 0),
                                        child: TextFormField(
                                          enabled: priceEnabled,
                                          initialValue:
                                              orderData.price.toString() ?? "0",
                                          onChanged: (value) {
                                            setState(() {
                                              orderTotalPrice =
                                                  (int.parse(value) +
                                                      int.parse(deliveryPrice));
                                            });
                                          },
                                          //controller: orderPrice,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: "سعر المنتج",
                                            labelStyle: TextStyle(
                                                fontFamily: 'Amiri',
                                                fontSize: 18.0,
                                                color: Color(0xff316686)),
                                            contentPadding:
                                                EdgeInsets.only(right: 20.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 10,
                                            right: 0),
                                        child: TextFormField(
                                          enabled: false,
                                          //controller: totalPriceController,
                                          decoration: InputDecoration(
                                            labelText:
                                                orderTotalPrice.toString(),
                                            contentPadding:
                                                EdgeInsets.only(right: 20.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                _notes(orderData.note),
                                _addNewOrderButton(snapshot, customerData),
                              ],
                            ),
                          ),
                        ),
                      )),
                );
              });
        });
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

  Widget _orderDescription(String description) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Expanded(
        child: TextFormField(
          initialValue: description,
          onChanged: (String newValue) {
            setState(() {
              orderDescription = newValue;
            });
          },
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

  Widget _locationChoice() {
    return FutureBuilder<String>(
        future: LocationServices(uid: widget.order.locationID).locationName,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            locationName = snapshot.data.toString();
            if (isBusinessSelected == true) {
              return Container(
                margin: EdgeInsets.all(10.0),
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
                          contentPadding:
                              EdgeInsets.only(right: 20.0, left: 10.0),
                          labelText: locationName,
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
                          //orderPrice.clear();

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
                                      deliveryPrice =
                                          value.docs[0]["deliveryPrice"];
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
                  },
                ),
              );
            } else {
              return Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
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
                    labelText: locationName,
                    labelStyle: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 18.0,
                      color: Color(0xff316686),
                    ),
                  ),
                ),
              );
            }
          } else {
            return Text("");
          }
        });
  }

  Widget _mainLineChoice() {
    return FutureBuilder<String>(
        future:
            MainLineServices(uid: widget.order.mainlineID).cityNameByMainLine,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            mainLineName = snapshot.data.toString();
            if (isLocationSelected == true) {
              return Container(
                margin: EdgeInsets.all(10.0),
                child: StreamBuilder<List<DeliveriesCosts>>(
                  stream: DeliveriesCostsServices(businessId: businessID)
                      .deliveryCostsBusiness,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Loading...');
                    } else {
                      cities = snapshot.data;

                      return Container(
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: StreamBuilder<List<MainLine>>(
                            stream: MainLineServices(locationID: locationID)
                                .mainLineByLocationID,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text('Loading...');
                              } else if (snapshot.hasError) {
                                return Text('snapshot.error');
                              } else {
                                mainlines = snapshot.data ?? [];

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
                                    contentPadding: EdgeInsets.only(
                                        right: 20.0, left: 10.0),
                                    labelText: mainLineName,
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
                                                  cityName =
                                                      value.data()["cityName"];
                                                },
                                              )
                                            },
                                          );
                                    });
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    // _key.currentState.reset();
                                  },
                                );
                              }
                            }),
                      );
                    }
                  },
                ),
              );
            } else {
              return Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                // ignore: missing_required_param
                child: DropdownButtonFormField<String>(
                  value: mainlineID,
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
                    labelText: mainLineName,
                    labelStyle: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 18.0,
                      color: Color(0xff636363),
                    ),
                  ),
                ),
              );
            }
          } else {
            return Text("");
          }
        });
  }

  Widget _subLineChoice(String sublineID) {
    return FutureBuilder<String>(
        future: SubLineServices(uid: sublineID).sublineName,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            subName = snapshot.data.toString();
            if (mainlineSelected == true) {
              return Container(
                margin: EdgeInsets.all(10.0),
                child: StreamBuilder<List<SubLine>>(
                  stream: SubLineServices(mainLineID: mainline)
                      .subLinesByMainLineID,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Loading...');
                    } else {
                      sublines = snapshot.data;

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
                          contentPadding:
                              EdgeInsets.only(right: 20.0, left: 10.0),
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
                  },
                ),
              );
            } else {
              return Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                // ignore: missing_required_param
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
                    labelText: subName,
                    labelStyle: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 18.0,
                      color: Color(0xff636363),
                    ),
                  ),
                ),
              );
            }
          } else {
            return Text("");
          }
        });
  }

  Widget _deliveryType() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: DropdownButtonFormField(
          value: widget.order.type ? 'عادي' : 'مستعجل',
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

  Widget _notes(String fieldController) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Expanded(
        child: TextFormField(
          initialValue: fieldController,
          onChanged: (String newValue) {
            setState(() {
              orderNote = newValue;
            });
          },
          //minLines: 2,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
            labelText: fieldController ?? "لا يوجد ملاحظات",
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

  Widget _addNewOrderButton(snapshot, customerData) {
    return Container(
      child: RaisedButton(
          padding: EdgeInsets.only(right: 60, left: 60),
          color: Color(0xff73A16A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Color(0xff73A16A)),
          ),
          onPressed: () async {
            print(phoneNumber);
            print(customerData.phoneNumber);
            if (phoneNumber == ("0" + customerData.phoneNumber.toString())) {
              await CustomerServices(uid: widget.order.customerID)
                  .updateData(Customer(
                name: customerName ?? customerData.name,
                phoneNumber: customerData.phoneNumber,
                cityName: cityName ?? customerData.cityName,
                cityID: cityID,
                address: address ?? customerData.address,
                businesID: businessID ?? snapshot.data.businesID,
                sublineName: sublineName ?? customerData.sublineName,
                isArchived: false,
              ));
            } else {
              await CustomerServices(uid: widget.order.customerID)
                  .updateData(Customer(
                name: customerName ?? customerData.name,
                phoneNumber: int.parse(phoneNumber),
                cityName: cityName ?? customerData.cityName,
                cityID: cityID,
                address: address ?? customerData.address,
                businesID: businessID ?? snapshot.data.businesID,
                sublineName: sublineName ?? customerData.sublineName,
                isArchived: false,
              ));
            }

            bool isUrgent = false;

            if (typeOrder == "عادي") {
              isUrgent = false;
            } else {
              isUrgent = true;
            }
            await OrderServices(uid: widget.order.uid).updateOrderData(Order(
              price: int.parse(deliveryPrice) ?? snapshot.data.price,
              totalPrice: orderTotalPrice ?? snapshot.data.totalPrice,
              description: orderDescription ?? snapshot.data.description,
              note: orderNote ?? snapshot.data.note,
              // customerID: customerData.uid,
              businesID: businessID ?? snapshot.data.businesID,
              sublineID: subline ?? snapshot.data.sublineID,
              locationID: locationID ?? snapshot.data.locationID,
              indexLine: indexLine ?? snapshot.data.indexLine,
              //mainLineIndex: snapshot.data.mainLineIndex,
              mainlineID: mainlineID ?? snapshot.data.mainlineID,
              isUrgent: isUrgent ?? snapshot.data.isUrgent,
            ));

            Toast.show("تم تعديل الطلبية بنجاح", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            await Future.delayed(Duration(milliseconds: 1000));
            //  Navigator.pop(context);
          },
          child: Text('تعديل',
              style: TextStyle(
                  fontFamily: 'Amiri', fontSize: 18.0, color: Colors.white))),
    );
  }
}
