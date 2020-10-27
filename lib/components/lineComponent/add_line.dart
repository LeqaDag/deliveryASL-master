import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/components/cityComponent/cityList.dart';
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
  String cityName = 'المدينة';
  City city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("اضافة خط سير",
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
                          if (v.trim().isEmpty)
                            return 'رجاءً أدخل اسم الخط الرئيسي';
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.0,
                              color: Color(0xff636363),
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        elevation: 0,
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          height: 27,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                cityName,
                                style: TextStyle(
                                    color: Color(0xff316686),
                                    fontFamily: 'Amiri',
                                    fontSize: 18.0),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xff636363),
                                size: 25.0,
                              ),
                            ],
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildAboutDialog(context),
                          ).then((value) {
                            setState(() {
                              city = value;
                              cityName = city.name;
                            });
                          });
                        },
                      ),
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
                            print(_mainLineController);

                            String mainLineID = await MainLineServices()
                                .addMainLineData(new MainLine(
                                    name: _mainLineController.text));

                            subLineList.asMap().forEach((index, subline) async {
                              await SubLineServices().addSubLineData(
                                  new SubLine(
                                      cityID: city.uid,
                                      mainLineID: mainLineID,
                                      index: index,
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

  Widget _buildAboutDialog(BuildContext context) {
    return new AlertDialog(
        content: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: StreamProvider<List<City>>.value(
          value: CityService().citys, child: CityList()),
    ));
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
        } else
          subLineList.removeAt(index);
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

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      onChanged: (v) => _AddLineState.subLineList[widget.index] = v,
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
    );
  }
}
