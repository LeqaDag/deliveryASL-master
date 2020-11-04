import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/mainLine.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/components/pages/loadingData.dart';
import 'package:sajeda_app/services/mainLineServices.dart';

import '../../../constants.dart';

class UpdateMainLine extends StatefulWidget {
  final String name;
  final String mainLineID;
  UpdateMainLine({this.name, this.mainLineID});

  @override
  _UpdateMainLineState createState() => _UpdateMainLineState();
}

class _UpdateMainLineState extends State<UpdateMainLine> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _mainLineController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainLine>(
      stream: MainLineServices(uid: widget.mainLineID).mainLineByID,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          MainLine mainLine = snapshot.data;
          _mainLineController.text = mainLine.name;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("تعديل خط التوصيل ارئيسي",
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
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            margin: EdgeInsets.all(40.0),
                            child: RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  mainLine.name = _mainLineController.text;
                                  await MainLineServices(uid: mainLine.uid)
                                      .updateData(mainLine);
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
