import 'package:AsyadLogistic/classes/city.dart';
import 'package:AsyadLogistic/classes/deliveriesCost.dart';
import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/services/DeliveriesCostsServices.dart';
import 'package:AsyadLogistic/services/cityServices.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/services/businessServices.dart';

class UpdateCompany extends StatefulWidget {
  final String businessID, name;
  const UpdateCompany({this.businessID, this.name});

  @override
  _UpdateCompanyState createState() => _UpdateCompanyState();
}

class _UpdateCompanyState extends State<UpdateCompany> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'One';

  String companyName;
  bool type;
  String email;
  String phoneNumber;
  String passowrd;
  List<City> cities;
  String cityID, cityName = "";
  List<DeliveriesCosts> deliveriesCosts;
  List<Location> locations;
  String locationID;
  Map<String, TextEditingController> formListController = {};
  List<String> deliveryCostIds = [];

  TextEditingController cost0 = TextEditingController();
  TextEditingController cost1 = TextEditingController();
  TextEditingController cost2 = TextEditingController();
  TextEditingController cost3 = TextEditingController();
  TextEditingController cost4 = TextEditingController();
  TextEditingController cost5 = TextEditingController();
  String price0, price1, price2, price3, price4, price5;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Business>(
        stream: BusinessServices(uid: widget.businessID).businessByID,
        builder: (context, snapshot) {
          Business businessData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text("${businessData.name} / تعديل شركة "),
              centerTitle: true,
              backgroundColor: Color(0xff316686),
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
                          child: Image.asset('assets/AddCompany.png'),
                          height: 150.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: TextFormField(
                            initialValue: businessData.name ?? "",
                            onChanged: (val) =>
                                setState(() => companyName = val),
                            decoration: InputDecoration(
                              labelText: 'الإسم',
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
                        // val.isEmpty ? 'Please enter a name' : null

                       
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: TextFormField(
                            initialValue: businessData.phoneNumber,
                            onChanged: (val) =>
                                setState(() => phoneNumber = val),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'رقم الجوال',
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

                        FutureBuilder<String>(
                            future:
                                CityServices(uid: businessData.cityID).cityName,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                cityName = snapshot.data.toString();
                                return Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: StreamBuilder<List<City>>(
                                    stream: CityServices().citys,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text('Loading...');
                                      } else {
                                        cities = snapshot.data;
                                        return DropdownButtonFormField<String>(
                                          value: cityID,
                                          onChanged: (val) {
                                            setState(() {
                                              cityID = val;
                                            });
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                          items: cities.map(
                                            (city) {
                                              return DropdownMenuItem<String>(
                                                value: city.uid.toString(),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    city.name,
                                                    style: TextStyle(
                                                      fontFamily: 'Amiri',
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  width: 1.0,
                                                  color: Color(0xff636363),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  width: 2.0,
                                                  color: Color(0xff73a16a),
                                                ),
                                                //Change color to Color(0xff73a16a)
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  right: 20.0, left: 10.0),
                                              labelText: cityName,
                                              labelStyle: TextStyle(
                                                  fontFamily: 'Amiri',
                                                  fontSize: 18.0,
                                                  color: Color(0xff316686))),
                                        );
                                      }
                                    },
                                  ),
                                );
                              } else {
                                return Text("");
                              }
                            }),
                        StreamBuilder<List<DeliveriesCosts>>(
                            stream: DeliveriesCostsServices(
                                    businessId: widget.businessID)
                                .deliveryCostsBusiness,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                deliveriesCosts = snapshot.data;

                                int index = 0;
                                deliveriesCosts.forEach((element) {
                                  deliveryCostIds.insert(index, element.uid);
                                  index++;
                                });
                                return Column(children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[0])
                                                  .locatinName,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);

                                                  return Expanded(
                                                    child: Text(
                                                      snapshot.data.toString(),
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        color:
                                                            Colors.purple[900],
                                                        fontFamily: 'Amiri',
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[0])
                                                  .deliveryPrice,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  price0 =
                                                      snapshot.data.toString();
                                                  return TextFormField(
                                                    controller: cost0,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      labelText: snapshot.data
                                                          .toString(),
                                                      labelStyle: TextStyle(
                                                          fontFamily: 'Amiri',
                                                          fontSize: 18.0,
                                                          color: Color(
                                                              0xff316686)),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              right: 20.0),
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
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[1])
                                                  .locatinName,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  //  isDoneOrders = snapshot.data;
                                                  return Expanded(
                                                    child: Text(
                                                      snapshot.data.toString(),
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        color:
                                                            Colors.purple[900],
                                                        fontFamily: 'Amiri',
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[1])
                                                  .deliveryPrice,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  price1 =
                                                      snapshot.data.toString();
                                                  return TextFormField(
                                                    controller: cost1,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      labelText: snapshot.data
                                                          .toString(),
                                                      labelStyle: TextStyle(
                                                          fontFamily: 'Amiri',
                                                          fontSize: 18.0,
                                                          color: Color(
                                                              0xff316686)),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              right: 20.0),
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
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[2])
                                                  .locatinName,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  //  isDoneOrders = snapshot.data;
                                                  return Expanded(
                                                    child: Text(
                                                      snapshot.data.toString(),
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        color:
                                                            Colors.purple[900],
                                                        fontFamily: 'Amiri',
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[2])
                                                  .deliveryPrice,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  price2 =
                                                      snapshot.data.toString();
                                                  return TextFormField(
                                                    controller: cost2,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      labelText: snapshot.data
                                                          .toString(),
                                                      labelStyle: TextStyle(
                                                          fontFamily: 'Amiri',
                                                          fontSize: 18.0,
                                                          color: Color(
                                                              0xff316686)),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              right: 20.0),
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
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[3])
                                                  .locatinName,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  //  isDoneOrders = snapshot.data;
                                                  return Expanded(
                                                    child: Text(
                                                      snapshot.data.toString(),
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        color:
                                                            Colors.purple[900],
                                                        fontFamily: 'Amiri',
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[3])
                                                  .deliveryPrice,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  price3 =
                                                      snapshot.data.toString();
                                                  return TextFormField(
                                                    controller: cost3,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      labelText: snapshot.data
                                                          .toString(),
                                                      labelStyle: TextStyle(
                                                          fontFamily: 'Amiri',
                                                          fontSize: 18.0,
                                                          color: Color(
                                                              0xff316686)),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              right: 20.0),
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
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[4])
                                                  .locatinName,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  //  isDoneOrders = snapshot.data;
                                                  return Expanded(
                                                    child: Text(
                                                      snapshot.data.toString(),
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        color:
                                                            Colors.purple[900],
                                                        fontFamily: 'Amiri',
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[4])
                                                  .deliveryPrice,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  price4 =
                                                      snapshot.data.toString();
                                                  return TextFormField(
                                                    controller: cost4,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      labelText: snapshot.data
                                                          .toString(),
                                                      labelStyle: TextStyle(
                                                          fontFamily: 'Amiri',
                                                          fontSize: 18.0,
                                                          color: Color(
                                                              0xff316686)),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              right: 20.0),
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
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[5])
                                                  .locatinName,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  //  isDoneOrders = snapshot.data;
                                                  return Expanded(
                                                    child: Text(
                                                      snapshot.data.toString(),
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        color:
                                                            Colors.purple[900],
                                                        fontFamily: 'Amiri',
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: FutureBuilder<String>(
                                              future: DeliveriesCostsServices(
                                                      uid: deliveryCostIds[5])
                                                  .deliveryPrice,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  price5 =
                                                      snapshot.data.toString();
                                                  print(price5);
                                                  return TextFormField(
                                                    controller: cost5,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                      labelText: snapshot.data
                                                          .toString(),
                                                      labelStyle: TextStyle(
                                                          fontFamily: 'Amiri',
                                                          fontSize: 18.0,
                                                          color: Color(
                                                              0xff316686)),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              right: 20.0),
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
                                                    ),
                                                  );
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]);
                              }
                              return Text("");
                            }),

                        Container(
                          margin: EdgeInsets.all(40.0),
                          child: RaisedButton(
                            padding: EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: () async {
                              print(companyName);
                              print(email);
                              print(companyName);
                              print(phoneNumber);
                              print(cityID);

                              if (_formKey.currentState.validate()) {
                                await BusinessServices(uid: widget.businessID)
                                    .updateData(Business(
                                        name: companyName ?? snapshot.data.name,
                                        phoneNumber: phoneNumber ??
                                            snapshot.data.phoneNumber,
                                        userID: snapshot.data.userID,
                                        cityID:
                                            cityID ?? snapshot.data.cityID));

                                if (cost0.text != "") {
                                  await DeliveriesCostsServices(
                                          uid: deliveryCostIds[0])
                                      .updateData(DeliveriesCosts(
                                          deliveryPrice: cost0.text));
                                }
                                if (cost1.text != "") {
                                  await DeliveriesCostsServices(
                                          uid: deliveryCostIds[1])
                                      .updateData(DeliveriesCosts(
                                          deliveryPrice: cost1.text ?? price1));
                                }
                                if (cost2.text != "") {
                                  await DeliveriesCostsServices(
                                          uid: deliveryCostIds[2])
                                      .updateData(DeliveriesCosts(
                                          deliveryPrice: cost2.text ?? price2));
                                }
                                if (cost3.text != "") {
                                  await DeliveriesCostsServices(
                                          uid: deliveryCostIds[3])
                                      .updateData(DeliveriesCosts(
                                          deliveryPrice: cost3.text ?? price3));
                                }
                                if (cost4.text != "") {
                                  await DeliveriesCostsServices(
                                          uid: deliveryCostIds[4])
                                      .updateData(DeliveriesCosts(
                                          deliveryPrice: cost4.text ?? price4));
                                }

                                if (cost5.text != "") {
                                  await DeliveriesCostsServices(
                                          uid: deliveryCostIds[5])
                                      .updateData(DeliveriesCosts(
                                          deliveryPrice: cost5.text ?? price5));
                                }

                                Navigator.pop(context);
                              }
                            },
                            color: Color(0xff73a16a),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'تعديل',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Amiri',
                                      fontSize: 24.0),
                                ),
                                SizedBox(
                                  width: 40.0,
                                ),
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 32.0,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  Widget _addComponent(DeliveriesCosts deliveriesCosts) {
    formListController[deliveriesCosts.uid] = new TextEditingController();

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                deliveriesCosts.locationName,
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.purple[900],
                  fontFamily: 'Amiri',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: TextFormField(
                controller: formListController[deliveriesCosts.uid],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: deliveriesCosts.deliveryPrice,
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
