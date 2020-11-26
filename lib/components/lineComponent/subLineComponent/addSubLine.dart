import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/classes/mainLine.dart';
import 'package:sajeda_app/classes/subLine.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/cityServices.dart';
import 'package:sajeda_app/services/mainLineServices.dart';
import 'package:sajeda_app/services/subLineServices.dart';

import '../../../constants.dart';

class AddSubLine extends StatefulWidget {
  final String name;
  final String mainLineID;
  AddSubLine({this.name, this.mainLineID});

  @override
  _AddSubLineState createState() => _AddSubLineState();
}

class _AddSubLineState extends State<AddSubLine> {
  final _formKey = GlobalKey<FormState>();
  static List<String> subLineList = [null];
  static Map<int, TextEditingController> subLineListController = {};
  static List<String> citiesList = [null];

  @override
  void initState() {
    subLineList = [null];
    citiesList = [null];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: SubLineServices(mainLineID: widget.mainLineID).maxIndex,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int maxIndex = snapshot.data +1;
            print(maxIndex);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text("اضافة خط توصيل فرعي",
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
                              margin: EdgeInsets.all(40.0),
                              child: StreamBuilder<MainLine>(
                                  stream:
                                      MainLineServices(uid: widget.mainLineID)
                                          .mainLineByID,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      MainLine mainLine = snapshot.data;
                                      return Text(
                                        "خط التوصيل الرئيسي ${mainLine.name}",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xff316686),
                                          fontFamily: 'Amiri',
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "جاري التحميل ....",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xff316686),
                                          fontFamily: 'Amiri',
                                        ),
                                      );
                                    }
                                  }),
                            ),
                            ..._getFriends(),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              margin: EdgeInsets.all(40.0),
                              child: RaisedButton(
                                onPressed: () async {
                                  subLineListController
                                      .forEach((index, subline) async {
                                    print(subline);
                                    await SubLineServices().addSubLineData(
                                        new SubLine(
                                            mainLineID: widget.mainLineID,
                                            indexLine: index + maxIndex,
                                            cityID: citiesList[index],
                                            name: subline.text));
                                  });
                                  Navigator.pop(context);
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
          } else {
            return Center(child: Image.asset("assets/EmptyOrder.png"));
          }
        });
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
        } else {
          subLineList.removeAt(index);
          citiesList.removeAt(index);

          subLineListController.remove(index);
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
  List<City> cities;
  String cityID;
  @override
  void initState() {
    super.initState();
    _AddSubLineState.subLineListController[widget.index] =
        new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
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
                    value: _AddSubLineState.citiesList[widget.index],
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
                        _AddSubLineState.citiesList[widget.index] = val;
                        // print(cityID);
                      });
                    },
                  );
                }
              },
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: _AddSubLineState.subLineListController[widget.index],
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
