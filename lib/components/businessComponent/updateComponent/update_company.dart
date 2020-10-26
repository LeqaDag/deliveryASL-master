import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/businessServices.dart';

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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Business>(
        stream: BusinessService(uid: widget.businessID).businessByID,
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
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: TextFormField(
                            initialValue: businessData.password,
                            onChanged: (val) => setState(() => passowrd = val),
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
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await BusinessService(uid: widget.businessID)
                                    .updateData(Business(
                                  name: companyName ?? snapshot.data.name,
                                  email: email ?? snapshot.data.email,
                                  phoneNumber:
                                      phoneNumber ?? snapshot.data.phoneNumber,
                                  password: passowrd ?? snapshot.data.password,
                                  userID: snapshot.data.userID,
                                ));
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
}
