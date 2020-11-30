import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/classes/driverDeliveryCost.dart';
import 'package:sajeda_app/classes/location.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/cityServices.dart';
import 'package:sajeda_app/services/driverDeliveryCostServices.dart';
import 'package:sajeda_app/services/driverServices.dart';
import 'package:sajeda_app/services/locationServices.dart';
import 'package:toast/toast.dart';

import '../../../constants.dart';

class AddDriver extends StatefulWidget {
  final String name;
  AddDriver({this.name});

  @override
  _AddDriverState createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  String dropdownValue = 'One';
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  List<City> cities;
  String cityID;

  List<Location> locations;
  String locationID;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference driverCollection =
      FirebaseFirestore.instance.collection('drivers');

  String type = 'سائق خاص';
  bool typeResult;
  String city = 'المدينة';
  City cc;
  String address = 'One';

  TextEditingController emailController = TextEditingController();
  TextEditingController driverNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController deliveryPriceController = TextEditingController();
  TextEditingController loadController = TextEditingController();

  Map<String, TextEditingController> formListController = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة سائق',
            style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: AdminDrawer(name: widget.name)),
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
                      child: Image.asset('assets/oie_transparent (20).png'),
                      height: 150.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: driverNameController,
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
                      child: DropdownButtonFormField(
                        onChanged: (val) => setState(() => type = val),
                        items: <String>['سائق خاص', 'سائق شركة']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                value,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'Amiri', fontSize: 16.0),
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
                            contentPadding:
                                EdgeInsets.only(right: 20.0, left: 10.0),
                            labelText: "نوع السائق",
                            labelStyle: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 18.0,
                                color: Color(0xff316686))),
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
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'العنوان',
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
                      child: StreamBuilder<List<Location>>(
                        stream: LocationServices().locations,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text('Loading...');
                          } else {
                            locations = snapshot.data;
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
                                  labelText: "خط التوصيل",
                                  labelStyle: TextStyle(
                                      fontFamily: 'Amiri',
                                      fontSize: 18.0,
                                      color: Color(0xff316686))),
                              items: locations.map(
                                (location) {
                                  return DropdownMenuItem<String>(
                                    value: location.uid.toString(),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        location.name,
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
                                  locationID = val;
                                });
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: deliveryPriceController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'الرجاء ادخال سعر الخط ';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'سعر الخط',
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
                        controller: loadController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'الرجاء ادخال السعة ';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'سعة تحميل السيارة',
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
                      margin: EdgeInsets.all(40.0),
                      child: RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          _addDriver();
                        },
                        color: Color(0xff73a16a),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'إضافة',
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

  void _addDriver() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    if (_formKey.currentState.validate()) {
      firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) async {
        userCollection.doc().set({
          "userID": result.user.uid,
          "email": emailController.text,
          "phoneNumber": phoneController.text,
          "name": driverNameController.text,
          "userType": "2"
        }).then((value) async {
          if (type == 'سائق خاص')
            typeResult = false;
          else
            typeResult = true;
          await DriverServices().addDriverData(Driver(
              uid: result.user.uid,
              name: driverNameController.text,
              type: typeResult,
              email: emailController.text,
              phoneNumber: phoneController.text,
              address: addressController.text,
              cityID: cityID,
              load: int.parse(loadController.text),
              locationID: locationID,
              userID: result.user.uid,
              ));

          await DriverDeliveryCostServices().addDriverDeliveryCostData(
              new DriverDeliveryCost(
                  cost: int.parse(deliveryPriceController.text),
                  locationID: locationID,
                  driverID: result.user.uid));
        });
        isLoading = false;
        Toast.show("تم اضافة سائق بنجاح", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        await Future.delayed(Duration(milliseconds: 1000));
        Navigator.of(context).pop();
      }).catchError((err) {});
    }
  }
}
