import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/components/pages/driver_drawer.dart';
import 'package:sajeda_app/services/driverServices.dart';

class DriverProfile extends StatefulWidget {
  final String name, uid;
  DriverProfile({this.name, this.uid});

  @override
  _DriverProfileState createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  final _formKey = GlobalKey<FormState>();

  String driverName;
  String email;
  String phoneNumber;
  String passowrd;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Driver>>(
      stream: DriverService(uid: widget.uid).driverByuserID,
      builder: (context, snapshot) {
        Driver driverData = snapshot.data[0];
        return Scaffold(
          appBar: AppBar(
            title: Text("الصفحة الشخصية"),
            centerTitle: true,
            backgroundColor: Color(0xff316686),
          ),
          endDrawer: Directionality(
              textDirection: TextDirection.rtl,
              child: DriverDrawer(
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
                    margin: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                    child: TextFormField(
                      initialValue: driverData.name ?? "",
                      onChanged: (val) => setState(() => driverName = val),
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
                    margin: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
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
                    margin: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                    child: TextFormField(
                      initialValue: driverData.phoneNumber,
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
                    margin: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                    child: TextFormField(
                      initialValue: driverData.address,
                      onChanged: (val) => setState(() => driverName),
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
                    margin: EdgeInsets.only(top: 20.0, right: 40.0, left: 40.0),
                    child: TextFormField(
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
                    margin: EdgeInsets.only(top: 30.0, right: 40.0, left: 40.0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          // await DriverService(uid: widget.driverID)
                          //     .updateData(Driver(
                          //   name: driverName ?? snapshot.data.name,
                          //   type: type ?? snapshot.data.type,
                          //   email: email ?? snapshot.data.email,
                          //   phoneNumber:
                          //       phoneNumber ?? snapshot.data.phoneNumber,
                          //   passowrd: passowrd ?? snapshot.data.passowrd,
                          //   address: address ?? snapshot.data.address,
                          //   cityID: cityID ?? snapshot.data.cityID,
                          //   line: line ?? snapshot.data.line,
                          // ));
                          // Navigator.pop(context);
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
      },
    );
  }
}
