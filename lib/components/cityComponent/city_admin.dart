import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/services/cityServices.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';
import 'cityList.dart';

class AdminCitiesHome extends StatefulWidget {
  final String name;
  AdminCitiesHome({this.name});

  @override
  _AdminCitiesHomeState createState() => _AdminCitiesHomeState();
}

class _AdminCitiesHomeState extends State<AdminCitiesHome> {
  @override
  Widget build(BuildContext context) {
    TextEditingController cityNameController = new TextEditingController();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("المدن",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
          centerTitle: true,
          backgroundColor: kAppBarColor,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                return showDialog<String>(
                  context: context,
                  child: new AlertDialog(
                    contentPadding: const EdgeInsets.all(16.0),
                    content: new Row(
                      children: <Widget>[
                        Expanded(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller: cityNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText:"المدينة",
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new FlatButton(
                          child: Text(
                            'اضافة',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                          onPressed: () async {
                            await CityServices()
                                .addCityData(new City(
                                    name: cityNameController.text,
                                    isArchived: false
                                    ));
                            Toast.show("تم اضافة المدينة بنجاح", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                            Future.delayed(Duration(milliseconds: 1000));
                            Navigator.of(context).pop();
                          })
                    ],
                  ),
                );
              },
              icon: Icon(Icons.add),
              color: Colors.white,
            )
          ],
        ),
        drawer: AdminDrawer(name: widget.name),
        body: StreamProvider<List<City>>.value(
          value: CityServices().citys,
          child: CityList(name: widget.name),
        ),
      ),
    );
  }
}
