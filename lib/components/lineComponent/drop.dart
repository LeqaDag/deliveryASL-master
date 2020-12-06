import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/city.dart';
import 'package:AsyadLogistic/services/cityServices.dart';

import '../../constants.dart';

class Test55 extends StatefulWidget {
  final String name;
  Test55({this.name});
  @override
  _Test55State createState() => _Test55State();
}

class _Test55State extends State<Test55> {
  List<City> cities;
  String cityID;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<City>>(
      stream: CityServices().citys,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading...');
        } else {
          cities = snapshot.data;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text("خطوط التوصيل",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Amiri',
                    )),
                backgroundColor: kAppBarColor,
                centerTitle: true,
              ),
              body: Container(
                padding: EdgeInsets.all(15),
                child: DropdownButtonFormField<String>(
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
                      contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
                      labelText: "خط التوصيل",
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
                      print(cityID);
                    });
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
