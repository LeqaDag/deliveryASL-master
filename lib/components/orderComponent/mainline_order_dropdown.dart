import 'package:AsyadLogistic/classes/mainLine.dart';
import 'package:AsyadLogistic/services/mainLineServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainLineDropDown extends StatefulWidget {
  final String locationID, mainline;
  List<MainLine> mainlines;
  MainLineDropDown({this.locationID, this.mainline, this.mainlines});

  @override
  _MainLineDropDownState createState() => _MainLineDropDownState();
}

class _MainLineDropDownState extends State<MainLineDropDown> {

  
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: StreamBuilder<List<MainLine>>(
            stream:
                MainLineServices(locationID: widget.locationID).mainLineByLocationID,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              } else {
                widget.mainlines = snapshot.data;
                return DropdownButtonFormField<String>(
                  value: widget.mainline,
                  isExpanded: true,
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
                    labelText: " المدينة",
                    labelStyle: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 18.0,
                      color: Color(0xff316686),
                    ),
                  ),
                  items: widget.mainlines.map(
                    (mainline) {
                      print(mainline.name);
                      return DropdownMenuItem<String>(
                        value: mainline.uid.toString(),
                        child: Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${mainline.name}-${mainline.cityName}',
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: 16.0,
                                  ),
                                ))),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(() {
                     // widget.mainline = val;
                      //print(mainline);
                    });
                  },
                );
              }
            }),
      ),
    );
  }
}