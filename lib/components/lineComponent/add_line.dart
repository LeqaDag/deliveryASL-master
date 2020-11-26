import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/cityServices.dart';
import 'package:sajeda_app/services/mainLineServices.dart';
import 'package:sajeda_app/services/subLineServices.dart';

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
  TextEditingController _mainLineController = new TextEditingController();
  static List<String> subLineList = [null];
  static List<String> citiesList = [null];
  String cityID;
  String region = '  المنطقة';
  @override
  void initState() {
    subLineList = [null];
    citiesList = [null];
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
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      child: DropdownButtonFormField(
                        onChanged: (String newValue) {
                          setState(() {
                            region = newValue;
                          });
                        },
                        items: <String>['الوسط', 'الشمال', 'الجنوب']
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
                            labelText: "المنطقة",
                            labelStyle: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 18.0,
                                color: Color(0xff316686))),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   margin: EdgeInsets.all(10.0),
                    //   child: StreamBuilder<List<City>>(
                    //       stream: CityService().citys,
                    //       builder: (context, snapshot) {
                    //         if (!snapshot.hasData) {
                    //           return Text('Loading...');
                    //         } else {
                    //           cities = snapshot.data;
                    //           return DropdownButtonFormField<String>(
                    //             value: cityID,
                    //             decoration: InputDecoration(
                    //                 enabledBorder: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(10.0),
                    //                   borderSide: BorderSide(
                    //                     width: 1.0,
                    //                     color: Color(0xff636363),
                    //                   ),
                    //                 ),
                    //                 focusedBorder: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(10.0),
                    //                   borderSide: BorderSide(
                    //                     width: 2.0,
                    //                     color: Color(0xff73a16a),
                    //                   ),
                    //                 ),
                    //                 contentPadding: EdgeInsets.only(
                    //                     right: 20.0, left: 10.0),
                    //                 labelText: "المدينة",
                    //                 labelStyle: TextStyle(
                    //                     fontFamily: 'Amiri',
                    //                     fontSize: 18.0,
                    //                     color: Color(0xff316686))),
                    //             items: cities.map(
                    //               (city) {
                    //                 return DropdownMenuItem<String>(
                    //                   value: city.uid.toString(),
                    //                   child: Align(
                    //                     alignment: Alignment.centerRight,
                    //                     child: Text(
                    //                       city.name,
                    //                       style: TextStyle(
                    //                         fontFamily: 'Amiri',
                    //                         fontSize: 16.0,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 );
                    //               },
                    //             ).toList(),
                    //             onChanged: (val) {
                    //               setState(() {
                    //                 cityID = val;
                    //                 print(cityID);
                    //               });
                    //             },
                    //           );
                    //         }
                    //       }),
                    // ),
                    ..._getFriends(),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.all(40.0),
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print(_mainLineController);

                            String mainLineID = await MainLineServices()
                                .addMainLineData(new MainLine(
                                    name: _mainLineController.text,
                                    region: region
                                    // cityID: cityID,
                                    ));

                            subLineList.asMap().forEach((index, subline) async {
                              print(subline);
                              await SubLineServices().addSubLineData(
                                  new SubLine(
                                      mainLineID: mainLineID,
                                      indexLine: index,
                                      cityID: citiesList[index],
                                      name: subline));
                            });

                            Navigator.pop(context);
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
          citiesList.insert(index, null);
        } else
          subLineList.removeAt(index);
        citiesList.removeAt(index);
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
  TextEditingController _nameController;
  List<City> cities;
  String cityID;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: TextFormField(
          controller: _nameController,
          onChanged: (v) => _AddLineState.subLineList[widget.index] = v,
          onSaved: (v) => _AddLineState.subLineList[widget.index] = v,
          decoration: InputDecoration(
            labelText: 'الخط الفرعي',
            labelStyle: TextStyle(
                fontFamily: 'Amiri', fontSize: 18.0, color: Color(0xff316686)),
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
        )),
        Expanded(
            child: Container(
          margin: EdgeInsets.all(10.0),
          child: StreamBuilder<List<City>>(
              stream: CityService().citys,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading...');
                } else {
                  cities = snapshot.data;
                  return DropdownButtonFormField<String>(
                    value: _AddLineState.citiesList[widget.index],
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
                        // cityID = val;
                        _AddLineState.citiesList[widget.index] = val;
                        // print(cityID);
                      });
                    },
                  );
                }
              }),
        )),
      ],
    );
  }
}
