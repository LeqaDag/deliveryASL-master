import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/mainLine.dart';
import 'package:sajeda_app/classes/subLine.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
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

  @override
  Widget build(BuildContext context) {
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
                          stream: MainLineServices(uid: widget.mainLineID)
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
                          subLineList.asMap().forEach((index, subline) async {
                            print(subline);
                            await SubLineServices().addSubLineData(new SubLine(
                                mainLineID: widget.mainLineID,
                                indexLine: index,
                                name: subline));
                          });
                          Navigator.pop(context);
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
      onChanged: (v) => _AddSubLineState.subLineList[widget.index] = v,
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
