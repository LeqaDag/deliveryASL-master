import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/city.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';

class AddSecretary extends StatefulWidget {
  final String name;
  AddSecretary({this.name});

  @override
  _AddSecretaryState createState() => _AddSecretaryState();
}

class _AddSecretaryState extends State<AddSecretary> {
  String dropdownValue = 'One';
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  List<City> cities;
  String cityID;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection('admin');

  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة سكرتير',
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
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/secretary.png'),
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
                  // Container(
                  //   margin: EdgeInsets.all(10.0),
                  //   child: StreamBuilder<List<City>>(
                  //     stream: CityService().citys,
                  //     builder: (context, snapshot) {
                  //       if (!snapshot.hasData) {
                  //         return Text('Loading...');
                  //       } else {
                  //         cities = snapshot.data;
                  //         return DropdownButtonFormField<String>(
                  //           value: cityID,
                  //           decoration: InputDecoration(
                  //               enabledBorder: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(10.0),
                  //                 borderSide: BorderSide(
                  //                   width: 1.0,
                  //                   color: Color(0xff636363),
                  //                 ),
                  //               ),
                  //               focusedBorder: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(10.0),
                  //                 borderSide: BorderSide(
                  //                   width: 2.0,
                  //                   color: Color(0xff73a16a),
                  //                 ),
                  //               ),
                  //               contentPadding:
                  //                   EdgeInsets.only(right: 20.0, left: 10.0),
                  //               labelText: "المدينة",
                  //               labelStyle: TextStyle(
                  //                   fontFamily: 'Amiri',
                  //                   fontSize: 18.0,
                  //                   color: Color(0xff316686))),
                  //           items: cities.map(
                  //             (city) {
                  //               return DropdownMenuItem<String>(
                  //                 value: city.uid.toString(),
                  //                 child: Align(
                  //                   alignment: Alignment.centerRight,
                  //                   child: Text(
                  //                     city.name,
                  //                     style: TextStyle(
                  //                       fontFamily: 'Amiri',
                  //                       fontSize: 16.0,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               );
                  //             },
                  //           ).toList(),
                  //           onChanged: (val) {
                  //             setState(() {
                  //               cityID = val;
                  //             });
                  //           },
                  //         );
                  //       }
                  //     },
                  //   ),
                  // ),
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
                        _addSecretary();
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
    );
  }

  void _addSecretary() async {
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
          adminCollection.doc(result.user.uid).set({
            "userID": result.user.uid,
            "email": emailController.text,
            "phoneNumber": int.parse(phoneController.text),
            "name": companyNameController.text,
            "type": false,
            "isArchived": false,
          }).then((value) async {
            isLoading = false;

            Toast.show("تم اضافة سكرتير بنجاح", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            await Future.delayed(Duration(milliseconds: 1000));
            Navigator.of(context).pop();
          });
        });
      }).catchError((err) {});
    }
  }
}
