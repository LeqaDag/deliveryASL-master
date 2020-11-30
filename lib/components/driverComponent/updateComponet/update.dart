import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/classes/driverDeliveryCost.dart';
import 'package:sajeda_app/classes/location.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/cityServices.dart';
import 'package:sajeda_app/services/driverDeliveryCostServices.dart';
import 'package:sajeda_app/services/driverServices.dart';
import 'package:sajeda_app/services/locationServices.dart';
import 'package:toast/toast.dart';

class UpdateDriver extends StatefulWidget {
  final String driverID, name;
  UpdateDriver({this.driverID, this.name});
  @override
  _UpdateDriverState createState() => _UpdateDriverState();
}

class _UpdateDriverState extends State<UpdateDriver> {
  final _formKey = GlobalKey<FormState>();
  List<City> cities;
  String cityID;

  List<Location> locations;
  String locationID, locationName = "", cityName = "";
  int driverDeliveryCost, load;
  String dropdownValue = 'One';
  TextEditingController deliveryPriceController = TextEditingController();

  String driverName, driverDeliveryCostId;
  bool type;
  String email;
  String phoneNumber;
  String passowrd;
  String address;
  String line = 'One';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Driver>(
        stream: DriverServices(uid: widget.driverID).driverByID,
        builder: (context, snapshot) {
          Driver driverData = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text("تعديل السائق/ ${driverData.name}")),
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
                            child:
                                Image.asset('assets/oie_transparent (20).png'),
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
                              items: <String>[
                                'سائق خاص',
                                'سائق شركة'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                              initialValue: driverData.email ?? "",
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
                              initialValue: driverData.phoneNumber ?? "",
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

                          FutureBuilder<String>(
                              future:
                                  CityServices(uid: driverData.cityID).cityName,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  cityName = snapshot.data.toString();
                                  return Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: StreamBuilder<List<City>>(
                                      stream: CityServices().citys,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text('Loading...');
                                        } else {
                                          cities = snapshot.data;
                                          return DropdownButtonFormField<
                                              String>(
                                            value: cityID,
                                            onChanged: (val) {
                                              setState(() {
                                                cityID = val;
                                              });
                                            },
                                            items: cities.map(
                                              (city) {
                                                return DropdownMenuItem<String>(
                                                  value: city.uid.toString(),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
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
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                    width: 1.0,
                                                    color: Color(0xff636363),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                    width: 2.0,
                                                    color: Color(0xff73a16a),
                                                  ),
                                                  //Change color to Color(0xff73a16a)
                                                ),
                                                contentPadding: EdgeInsets.only(
                                                    right: 20.0, left: 10.0),
                                                labelText: cityName,
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Amiri',
                                                    fontSize: 18.0,
                                                    color: Color(0xff316686))),
                                          );
                                        }
                                      },
                                    ),
                                  );
                                } else {
                                  return Text("");
                                }
                              }),

                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: TextFormField(
                              initialValue: driverData.address,
                              onChanged: (val) => setState(() => address = val),
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
                              initialValue: driverData.load.toString() ?? "",
                              onChanged: (val) =>
                                  setState(() => load = int.parse(val)),
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
                          FutureBuilder<String>(
                              future:
                                  LocationServices(uid: driverData.locationID)
                                      .cityName(driverData.locationID),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  locationName = snapshot.data.toString();
                                  return Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: StreamBuilder<List<Location>>(
                                      stream: LocationServices().locations,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text('Loading...');
                                        } else {
                                          locations = snapshot.data;
                                          return DropdownButtonFormField<
                                              String>(
                                            value: locationID,
                                            onChanged: (val) {
                                              setState(() {
                                                locationID = val;
                                              });
                                            },
                                            items: locations.map(
                                              (location) {
                                                return DropdownMenuItem<String>(
                                                  value:
                                                      location.uid.toString(),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
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
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                    width: 1.0,
                                                    color: Color(0xff636363),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(
                                                    width: 2.0,
                                                    color: Color(0xff73a16a),
                                                  ),
                                                  //Change color to Color(0xff73a16a)
                                                ),
                                                contentPadding: EdgeInsets.only(
                                                    right: 20.0, left: 10.0),
                                                labelText: locationName,
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Amiri',
                                                    fontSize: 18.0,
                                                    color: Color(0xff316686))),
                                          );
                                        }
                                      },
                                    ),
                                  );
                                } else {
                                  return Text("");
                                }
                              }),

                          FutureBuilder<String>(
                              future: DriverDeliveryCostServices(
                                      uid: driverData.uid)
                                  .driverDeliveryCostId(driverData.uid),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  driverDeliveryCostId =
                                      snapshot.data.toString();
                                  return Text("");
                                } else {
                                  return Text("");
                                }
                              }),

                          FutureBuilder<int>(
                              future: DriverDeliveryCostServices(
                                      uid: driverData.uid)
                                  .driverPriceData(driverData.uid),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  driverDeliveryCost =
                                      int.parse(snapshot.data.toString());
                                  return Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      initialValue:
                                          driverDeliveryCost.toString() ?? '',
                                      onChanged: (val) => setState(() =>
                                          driverDeliveryCost = int.parse(val)),
                                      // controller: deliveryPriceController,driverDeliveryCost
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'سعر الخط',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Amiri',
                                            fontSize: 18.0,
                                            color: Color(0xff316686)),
                                        contentPadding:
                                            EdgeInsets.only(right: 20.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            width: 1.0,
                                            color: Color(0xff636363),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Color(0xff73a16a),
                                          ),
                                          //Change color to Color(0xff73a16a)
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Text("");
                                }
                              }),

                          Container(
                            margin: EdgeInsets.all(40.0),
                            child: RaisedButton(
                              padding: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await DriverServices(uid: widget.driverID)
                                      .updateData(Driver(
                                          name:
                                              driverName ?? snapshot.data.name,
                                          type: type ?? snapshot.data.type,
                                          email: email ?? snapshot.data.email,
                                          phoneNumber: phoneNumber ??
                                              snapshot.data.phoneNumber,
                                          address:
                                              address ?? snapshot.data.address,
                                          cityID:
                                              cityID ?? snapshot.data.cityID,
                                          locationID: locationID ??
                                              snapshot.data.locationID,
                                          load: load ?? snapshot.data.load));
                                  await DriverDeliveryCostServices(
                                          uid: driverDeliveryCostId)
                                      .updateData(DriverDeliveryCost(
                                    driverID: widget.driverID,
                                    cost: driverDeliveryCost,
                                  ));
                                  Toast.show(
                                      "تم تعديل معلومات السائق بنجاح", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                  await Future.delayed(
                                      Duration(milliseconds: 1000));
                                  Navigator.of(context).pop();
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
            ),
          );
        });
  }
}
