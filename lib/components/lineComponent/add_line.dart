import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/city.dart';
import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/services/cityServices.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:AsyadLogistic/services/mainLineServices.dart';
import 'package:AsyadLogistic/services/subLineServices.dart';
import 'package:toast/toast.dart';

import '../../classes/mainLine.dart';
import '../../classes/subLine.dart';
import '../../constants.dart';

class AddLine extends StatefulWidget {
  final String name;
  AddLine({this.name});

  @override
  _AddLineState createState() => _AddLineState();
}

class _AddLineState extends State<AddLine> {
  final _formKey = GlobalKey<FormState>();
  static Map<int, TextEditingController> subLineListController = {};
  TextEditingController _mainLineController = new TextEditingController();
  static List<String> subLineList = [null];
  String cityID, locationID;
  String region = '  المنطقة', cityName = "";
  List<Location> locations;
  List<City> cities;

  @override
  void initState() {
    subLineList = [null];
    subLineListController = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "اضافة خط توصيل",
          style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri'),
        ),
        backgroundColor: kAppBarColor,
        centerTitle: true,
      ),
      endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: AdminDrawer(
            name: widget.name,
          )),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                          width: 50,
                          height: 120,
                          child: Image.asset("assets/DeliveryLine.png")),
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
                                  labelText: "المنطقة",
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
                                  print(locationID);
                                });
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _mainLineController,
                        decoration: InputDecoration(
                          labelText: 'الخط الرئيسي',
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
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.red[600],
                            ),
                          ),
                        ),
                        validator: (v) {
                          if (v.trim().isEmpty)
                            return 'رجاءً أدخل اسم الخط الرئيسي';
                          return null;
                        },
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
                                  // print(cityID);
                                });
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                              },
                            );
                          }
                        },
                      ),
                    ),
                    FutureBuilder<String>(
                        future: CityServices(uid: cityID).cityName,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data.toString());
                            cityName = snapshot.data.toString();
                            return Text(
                              " ",
                            );
                          } else {
                            return Text("");
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    ..._getFriends(),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.all(40.0),
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            String mainLineID = await MainLineServices()
                                .addMainLineData(new MainLine(
                                    cityName: cityName,
                                    name: _mainLineController.text,
                                    locationID: locationID,
                                    cityID: cityID,
                                    isArchived: false));

                            subLineListController
                                .forEach((index, subline) async {
                              await SubLineServices().addSubLineData(
                                  new SubLine(
                                      mainLineID: mainLineID,
                                      indexLine: index,
                                      cityID: cityID,
                                      name: subline.text));
                            });
                            await CityServices(uid: cityID)
                                .updateMainLine(mainLineID);
                            Toast.show("تم اضافة خط توصيل بنجاح", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                            await Future.delayed(Duration(milliseconds: 1000));
                            Navigator.of(context).pop();
                          }
                        },
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
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
                        color: Color(0xff73a16a),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < subLineList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: [
              Expanded(child: FriendTextFields(i)),
              SizedBox(
                width: 16,
              ),
              _addRemoveButton(i == subLineList.length - 1, i),
            ],
          ),
        ),
      ));
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          subLineList.insert(index, null);
        } else {
          subLineList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  @override
  void initState() {
    super.initState();
    _AddLineState.subLineListController[widget.index] =
        new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: _AddLineState.subLineListController[widget.index],
            decoration: InputDecoration(
              labelText: 'الخط الفرعي',
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
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.red[600],
                ),
              ),
            ),
            validator: (v) {
              if (v.trim().isEmpty) return 'رجاءً أدخل اسم الخط الفرعي ';
              return null;
            },
          ),
        ),
      ],
    );
  }
}
