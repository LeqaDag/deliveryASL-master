import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/city.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/classes/mainLine.dart';
import 'package:AsyadLogistic/components/driverComponent/driverDialogComponent/driverListDialog.dart';
import 'package:AsyadLogistic/services/cityServices.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/mainLineServices.dart';

class Divide extends StatefulWidget {
  final String id;
  Divide({this.id});
  @override
  _DivideState createState() => _DivideState();
}

class _DivideState extends State<Divide> {
  String driverName = 'اسم السائق';
  Driver driver;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<City>>(
        stream: CityServices(name: widget.id).cityIDByName,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            City city = snapshot.data[0];
            return StreamBuilder<List<MainLine>>(
                stream: MainLineServices(cityID: city.uid).mainLineByCityID,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    MainLine mainLine = snapshot.data[0];
                    return Container(
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
                                driverName,
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
                                _buildAboutDialog(context, mainLine.uid),
                          ).then((value) {
                            setState(() {
                              driver = value;
                              driverName = city.name;
                            });
                          });
                        },
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                });
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _buildAboutDialog(BuildContext context, String mainLineID) {
    return new AlertDialog(
        content: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: StreamProvider<List<Driver>>.value(
          value: DriverServices(mainLineID: mainLineID).driversBymainLineID,
          child: DriverListDialog()),
    ));
  }
}
