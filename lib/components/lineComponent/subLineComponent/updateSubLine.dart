import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/city.dart';
import 'package:AsyadLogistic/classes/subLine.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/components/pages/loadingData.dart';
import 'package:AsyadLogistic/services/cityServices.dart';
import 'package:AsyadLogistic/services/subLineServices.dart';

import '../../../constants.dart';

class UpdateSubLine extends StatefulWidget {
  final String name;
  final String subLineID;
  UpdateSubLine({this.name, this.subLineID});

  @override
  _UpdateSubLineState createState() => _UpdateSubLineState();
}

class _UpdateSubLineState extends State<UpdateSubLine> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _subLineController = new TextEditingController();
  List<City> cities;
  String cityID;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SubLine>(
      stream: SubLineServices(uid: widget.subLineID).subLineByID,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          SubLine subLine = snapshot.data;
          _subLineController.text = subLine.name;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("تعديل الخط الفرعي",
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
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
                              child: Icon(
                                Icons.location_on,
                                color: Color(0xff316686),
                                size: 44.0,
                              ),
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
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            right: 20.0, left: 10.0),
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
                                      });
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: _subLineController,
                              decoration: InputDecoration(
                                labelText: 'الخط الفرعي',
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
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            margin: EdgeInsets.all(40.0),
                            child: RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  subLine.name = _subLineController.text;
                                  subLine.cityID = cityID;
                                  await SubLineServices(uid: subLine.uid)
                                      .updateData(subLine);
                                  Navigator.pop(context);
                                }
                              },
                              padding: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
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
        } else {
          return LoadingData();
        }
      },
    );
  }
}
