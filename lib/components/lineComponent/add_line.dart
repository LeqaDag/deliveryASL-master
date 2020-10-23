import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/components/widgetsComponent/AddLineCustomwidgets.dart';

import '../../constants.dart';

class AddLine extends StatefulWidget {
  @override
  _AddLineState createState() => _AddLineState();
}

class _AddLineState extends State<AddLine> with SingleTickerProviderStateMixin {
  // int _counter = 2;
  // int indexController = 1;
  // TextEditingController mainLine = new TextEditingController();
  // TextEditingController cityID = new TextEditingController();
  // List<TextEditingController> subLine = new List<TextEditingController>();
  List<Widget> _phoneWidgets = List<Widget>();

  // List<DynamicCustomTextFormField> dynamicCustomTextFormField = [];
  // addCustomTextFormField() {
  //   dynamicCustomTextFormField.add(DynamicCustomTextFormField(
  //     keyboardInputType: TextInputType.text,
  //     obscuretext: false,
  //     hinttext: "اسم الخط الفرعي " + _counter.toString(),
  //     icon: null,
  //     borderCircular1: 15,
  //     borderCircular2: 15,
  //     controller: subLine[indexController] = new TextEditingController(),
  //   ));
  //   setState(() {
  //     indexController++;
  //     _counter++;
  //     // here is submit code for submit button
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("اضافة خط سير",
            style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
        backgroundColor: kAppBarColor,
        centerTitle: true,
      ),
      endDrawer: Directionality(
          textDirection: TextDirection.rtl, child: AdminDrawer()),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            Container(
                width: 50,
                height: 120,
                child: Image.asset("assets/DeliveryLine.png")),
            DynamicCustomTextFormField(
              keyboardInputType: TextInputType.text,
              obscuretext: false,
              hinttext: "اسم الخط الرئيسي",
              icon: null,
              borderCircular1: 15,
              borderCircular2: 15,
              // controller: mainLine,
            ),
            Container(
                margin:
                    EdgeInsets.only(right: width * 0.123, left: width * 0.123),
                child: CityChoice()),
            Stack(
              children: [
                DynamicCustomTextFormField(
                    keyboardInputType: TextInputType.text,
                    obscuretext: false,
                    hinttext: "اسم الخط الفرعي 1",
                    icon: null,
                    borderCircular1: 15,
                    borderCircular2: 15,
                    // controller: subLine[0] = new TextEditingController()
                    ),
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Container(
                    height: 30,
                    width: 30,
                    child: FloatingActionButton(
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black26,
                              width: 1.0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () {
                        setState(() {
                          _phoneWidgets.add(Phone(
                            fieldName: 'Phone Number',
                          ));
                        });
                      },
                    ),
                  ),
                )
              ],
            ),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: ListView(
                  children: List.generate(_phoneWidgets.length, (i) {
                    return _phoneWidgets[i];
                  }),
                )),

            CustomBoxSize(height: 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Container(
                height: 55,
                child: FlatButton(
                  onPressed: () {},
                  color: KAddCompanyButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    "اضافة",
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 30,
                      color: kAdminLoginButtonColor,
                    ),
                  ),
                ),
              ),
            ),

            /// flat Add button
            CustomBoxSize(height: 0.03),
          ],
        ),
      ),
    );
  }
}

class Phone extends StatelessWidget {
  String fieldName;
  Phone({this.fieldName = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: Colors.white, width: 0.1),
          ),
          filled: true,
          icon: Icon(
            Icons.phone,
            color: Colors.black,
            size: 20.0,
          ),
          labelText: fieldName,
          labelStyle: TextStyle(
              fontSize: 15.0,
              height: 1.5,
              color: Color.fromRGBO(61, 61, 61, 1)),
          fillColor: Color(0xffD2E8E6),
        ),
        maxLines: 1,
      ),
    );
  }
}
