import 'dart:ui';

import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/components/pages/business_drawer.dart';
import 'package:AsyadLogistic/components/pages/loadingData.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusinessProfile extends StatefulWidget {
  final String name, uid;
  BusinessProfile({this.name, this.uid});

  @override
  _BusinessProfileState createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  final _formKey = GlobalKey<FormState>();

  String businessName;
  String email;
  String phoneNumber;
  String passowrd;
  String address;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Business>(
      stream: BusinessServices(uid: widget.uid).businessByID,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Business businessData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text("الصفحة الشخصية"),
              centerTitle: true,
              backgroundColor: Color(0xff316686),
            ),
            endDrawer: Directionality(
                textDirection: TextDirection.rtl,
                child: BusinessDrawer(
                  name: widget.name,
                  uid: widget.uid,
                )),
            backgroundColor: Colors.white,
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                  child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                        height: 170,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/background.jpg"),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                            child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/user.png",
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              widget.name ?? "",
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontFamily: 'Amiri',
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ))),
                    Container(
                      margin:
                          EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                      child: TextFormField(
                        initialValue: businessData.name ?? "",
                        onChanged: (val) => setState(() => businessName = val),
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
                      margin:
                          EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                      child: TextFormField(
                        initialValue: businessData.email,
                        onChanged: (val) => setState(() => email = val),
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
                      margin:
                          EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                      child: TextFormField(
                        initialValue: businessData.phoneNumber,
                        onChanged: (val) => setState(() => phoneNumber = val),
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
                      margin:
                          EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                      child: TextFormField(
                        onChanged: (val) => setState(() => passowrd = val),
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
                      margin:
                          EdgeInsets.only(top: 30.0, right: 40.0, left: 40.0),
                      child: RaisedButton(
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            final FirebaseAuth firebaseAuth =
                                FirebaseAuth.instance;
                            User currentUser = firebaseAuth.currentUser;
                            print(currentUser);
                            currentUser.updatePassword(passowrd).then((_) {
                              print("Succesfull changed password");
                              BusinessServices(uid: widget.uid)
                                  .updateData(Business(
                                name: businessName ?? snapshot.data.name,
                                email: email ?? snapshot.data.email,
                                phoneNumber:
                                    phoneNumber ?? snapshot.data.phoneNumber,
                                userID: snapshot.data.userID,
                                cityID: snapshot.data.cityID,
                              ));
                            }).catchError((error) {
                              print("Password can't be changed" +
                                  error.toString());
                              //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                            });
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
        } else {
          return Center(child: LoadingData());
        }
      },
    );
  }

  Widget _profileData(String labeltext, bool bool, TextInputType type,
      TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        obscureText: bool,
        keyboardType: type,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
          labelText: labeltext,
          labelStyle: TextStyle(
              fontFamily: 'Amiri', fontSize: 18.0, color: Color(0xff316686)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        controller: controller,
      ),
    );
  }
}
