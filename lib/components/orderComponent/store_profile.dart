import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreProfile extends StatelessWidget {
  final String name;
  StoreProfile({this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff316686),
        title: Text("الصفحة الشخصية",
            style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
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
                          "assets/asyadlogo2.jpeg",
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      name?? "",
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: 'Amiri',
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
                child: Column(
                  children: <Widget>[
                    _profileData("رقم الهاتف", false, TextInputType.phone),
                    _profileData(
                        "البريد الالكتروني", false, TextInputType.emailAddress),
                    _profileData("كلمة المرور", true, null),
                    _editButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileData(String labeltext, bool bool, TextInputType type) {
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
      ),
    );
  }

  Widget _editButton() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: 200.0,
      child: RaisedButton(
        padding: EdgeInsets.all(10.0),
        color: Color(0xff73A16A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Color(0xff73A16A)),
        ),
        onPressed: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'تعديل',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Amiri', fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
