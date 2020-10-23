import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/driverServices.dart';

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

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference driverCollection =
      FirebaseFirestore.instance.collection('driver');

  String type = 'سائق خاص';
  bool typeResult;
  String cityID = 'One';
  String address = 'One';
  String line = 'One';

  TextEditingController emailController = TextEditingController();
  TextEditingController driverNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
        child: Container(
            padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: Form(
              key: _formKey,
              child: ListView(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: DropdownButtonFormField(
                      onChanged: (val) => setState(() => address = val),
                      items: <String>['One', 'Two', 'Free', 'Four']
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
                          labelText: "المدينة",
                          labelStyle: TextStyle(
                              fontFamily: 'Amiri',
                              fontSize: 18.0,
                              color: Color(0xff316686))),
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
                    child: DropdownButtonFormField(
                      onChanged: (val) => setState(() => line = val),
                      items: <String>['One', 'Two', 'Free', 'Four']
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
                          labelText: "خط التوصيل",
                          labelStyle: TextStyle(
                              fontFamily: 'Amiri',
                              fontSize: 18.0,
                              color: Color(0xff316686))),
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
    );
  }

  void _addDriver() async {
    if (_formKey.currentState.validate()) {
      firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) {
        userCollection.doc().set({
          "userID": result.user.uid,
          "email": emailController.text,
          "phoneNumber": phoneController.text,
          "name": driverNameController.text,
          "userType": "2"
        }).then((value) {
          if (type == 'سائق خاص')
            typeResult = false;
          else
            typeResult = true;
          driverCollection.doc().set({
            "address": addressController.text,
            "city": cityID,
            "line": line,
            "type": typeResult,
            "userID": result.user.uid,
            "isArchived": false
          });
          isLoading = false;
          Navigator.pop(context);
        });
      }).catchError((err) {});
    }
  }
}