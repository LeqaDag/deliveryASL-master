import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/city.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/services/cityServices.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';

class AddCity extends StatefulWidget {
  final String name;
  AddCity({this.name});

  @override
  _AddCityState createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  final _formKey = GlobalKey<FormState>();
  static Map<int, TextEditingController> citiesListController = {};
  static List<String> citiesList = [null];

  @override
  void initState() {
    
    citiesList = [null];
    citiesListController = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "اضافة مدن",
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
                          child: Image.asset("assets/city-100.png")),
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
                            citiesListController
                                .forEach((index, subline) async {
                              await CityServices().addCityData(new City(
                                  isArchived: false,
                                  name: subline.text,
                                  mainLineID: ""));
                            });
                            Toast.show("تم اضافة مدن بنجاح", context,
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
    for (int i = 0; i < citiesList.length; i++) {
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
              _addRemoveButton(i == citiesList.length - 1, i),
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
          citiesList.insert(index, null);
        } else {
          citiesList.removeAt(index);
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
    _AddCityState.citiesListController[widget.index] =
        new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: _AddCityState.citiesListController[widget.index],
            decoration: InputDecoration(
              labelText: ' اسم المدينة',
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
              if (v.trim().isEmpty) return 'رجاءً أدخل اسم المدينة ';
              return null;
            },
          ),
        ),
      ],
    );
  }
}
