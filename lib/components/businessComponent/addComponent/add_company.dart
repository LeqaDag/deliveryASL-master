import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/city.dart';
import 'package:AsyadLogistic/classes/deliveriesCost.dart';
import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/components/businessComponent/businesssComponent/business_admin.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/deliveriesCostsServices.dart';
import 'package:AsyadLogistic/services/cityServices.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:toast/toast.dart';

import '../../../constants.dart';

class AddCompany extends StatefulWidget {
  final String name;
  AddCompany({this.name});

  @override
  _AddCompanyState createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  String dropdownValue = 'One';
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  List<City> cities;
  String cityID;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<Location> locations;
  String locationID;
  Map<String, TextEditingController> formListController = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة شركة',
            style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: BusinessAdmin(name: widget.name)),
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
              child: Form(
                key: _formKey,
                child: ListView(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/AddCompany.png'),
                      height: 150.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: companyNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'الرجاء ادخال الاسم';
                          }
                          return null;
                        },
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
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'الرجاء ادخال البريد الالكتروني';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'البريد الإلكتروني',
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
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: phoneController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'الرجاء ادخال رقم الجوال';
                          } else if (value.length != 10 || value.length > 10) {
                            return 'الرجاء ادخال رقم جوال صحيح';
                          }
                          return null;
                        },
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
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'الرجاء ادخال كلمة المرور';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          labelStyle: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 18.0,
                            color: Color(0xff316686),
                          ),
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
                    Container(
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
                                  labelText: "المدينة",
                                  labelStyle: TextStyle(
                                      fontFamily: 'Amiri',
                                      fontSize: 18.0,
                                      color: Color(0xff316686))),
                              items: cities.map(
                                (city) {
                                  return DropdownMenuItem<String>(
                                    value: city.uid.toString(),
                                    child: Align(
                                      alignment: Alignment.centerRight,
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
                              onChanged: (val) {
                                setState(() {
                                  cityID = val;
                                });
                              },
                            );
                          }
                        },
                      ),
                    ),
                    StreamBuilder<List<Location>>(
                        stream: LocationServices().locations,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            locations = snapshot.data;

                            return ListView.separated(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: locations.length,
                              itemBuilder: (context, index) {
                                return _addComponent(locations[index]);
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                            );
                          } else {
                            return Container();
                          }
                        }),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.all(40.0),
                      child: RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => AddDeliveryCost()),
                          // );
                          _addCompany();
                        },
                        color: Color(0xff73a16a),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'اضافة',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Amiri',
                                  fontSize: 24.0),
                            ),
                            SizedBox(
                              width: 40.0,
                            ),
                            Icon(
                              Icons.add_circle,
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
      ),
    );
  }

  void _addCompany() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;

    if (_formKey.currentState.validate()) {
      firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) {
        userCollection.doc().set({
          "userID": result.user.uid,
          "email": emailController.text,
          "phoneNumber": phoneController.text,
          "name": companyNameController.text,
          "userType": "1"
        }).then((value) async {
          await BusinessServices()
              .addBusinessData(Business(
            uid: result.user.uid,
            userID: result.user.uid,
            email: emailController.text,
            phoneNumber: phoneController.text,
            name: companyNameController.text,
            cityID: cityID,
            isArchived: false,
          ))
              .then((value) async {
            isLoading = false;
            locations.asMap().forEach((index, location) async {
              print(location);

              await DeliveriesCostsServices().addDeliveryCostData(
                  new DeliveriesCosts(
                      deliveryPrice: formListController[location.uid].text,
                      adminID: user.uid,
                      locationID: location.uid,
                      locationName: location.name,
                      businesID: result.user.uid));
            });
            Toast.show("تم اضافة اسعار التوصيل بنجاح", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            await Future.delayed(Duration(milliseconds: 1000));
            Toast.show("تم اضافة شركة بنجاح", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            await Future.delayed(Duration(milliseconds: 1000));
            Navigator.of(context).pop();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => AddDeliveryCost()),
            // );
          });
        });
      }).catchError((err) {});
    }
  }

  Widget _addComponent(Location location) {
    formListController[location.uid] = new TextEditingController();
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                location.name,
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
                controller: formListController[location.uid],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'ادخل سعر التوصيل';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'سعر التوصيل',
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
