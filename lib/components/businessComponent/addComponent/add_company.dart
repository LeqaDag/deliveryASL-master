import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/components/businessComponent/addComponent/add_delivery_cost.dart';
import 'package:sajeda_app/components/businessComponent/businesssComponent/business_admin.dart';
import 'package:sajeda_app/components/pages/drawer.dart';

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

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference companyCollection =
      FirebaseFirestore.instance.collection('businesss');

  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
    );
  }

  void _addCompany() async {
    if (_formKey.currentState.validate()) {
      firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) {
        companyCollection.doc().set({
          "userID": result.user.uid,
          "email": emailController.text,
          "phoneNumber": phoneController.text,
          "name": companyNameController.text,
          "password": passwordController.text,
          "isArchived": false,
        }).then((value) {
          isLoading = false;
          Navigator.pop(context);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => AddDeliveryCost()),
          // );
        });
      }).catchError((err) {});
    }
  }
}
