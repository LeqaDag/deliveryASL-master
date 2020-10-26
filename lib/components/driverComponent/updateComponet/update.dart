import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/driverServices.dart';

class UpdateDriver extends StatefulWidget {
  final String driverID, name;
  const UpdateDriver({this.driverID, this.name});
  @override
  _UpdateDriverState createState() => _UpdateDriverState();
}

class _UpdateDriverState extends State<UpdateDriver> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'One';

  String driverName;
  bool type;
  String email;
  String phoneNumber;
  String passowrd;
  String cityID;
  String address = 'One';
  String line = 'One';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Driver>(
        stream: DriverService(uid: widget.driverID).driverByID,
        builder: (context, snapshot) {
          Driver driverData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text("تعديل السائق/ ${driverData.name}"),
              centerTitle: true,
              backgroundColor: Color(0xff316686),
            ),
            endDrawer: Directionality(
                textDirection: TextDirection.rtl,
                child: AdminDrawer(
                  name: widget.name,
                )),
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
                            initialValue: driverData.name ?? "",
                            onChanged: (val) =>
                                setState(() => driverName = val),
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
                          child: DropdownButtonFormField(
                            value: driverData.type ? 'سائق شركة' : 'سائق خاص',
                            onChanged: (val) => setState(() {
                              if (val == 'سائق خاص')
                                type = false;
                              else
                                type = true;
                            }),
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
                            initialValue: driverData.email,
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
                            initialValue: driverData.phoneNumber,
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
                          child: DropdownButtonFormField(
                            value: address ?? driverData.address,
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
                            initialValue: driverData.cityID,
                            onChanged: (val) => setState(() => cityID = val),
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
                            initialValue: driverData.passowrd,
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
                          margin: EdgeInsets.all(10.0),
                          child: DropdownButtonFormField(
                            value: line ?? driverData.line,
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
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                await DriverService(uid: widget.driverID)
                                    .updateData(Driver(
                                  name: driverName ?? snapshot.data.name,
                                  type: type ?? snapshot.data.type,
                                  email: email ?? snapshot.data.email,
                                  phoneNumber:
                                      phoneNumber ?? snapshot.data.phoneNumber,
                                  passowrd: passowrd ?? snapshot.data.passowrd,
                                  address: address ?? snapshot.data.address,
                                  cityID: cityID ?? snapshot.data.cityID,
                                  line: line ?? snapshot.data.line,
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
