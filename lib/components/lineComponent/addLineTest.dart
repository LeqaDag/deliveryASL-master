import 'package:flutter/material.dart';

class AddLineTest extends StatefulWidget {
  @override
  _AddLineTestState createState() => new _AddLineTestState();
}

class _AddLineTestState extends State<AddLineTest>
    with SingleTickerProviderStateMixin {
  List<Widget> _phoneWidgets = List<Widget>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text(
          '+',
          style: TextStyle(fontSize: 20.0),
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.black26, width: 1.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10.0)),
        onPressed: () {
          setState(() {
            _phoneWidgets.add(Phone(
              fieldName: 'Phone Number',
            ));
          });
        },
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: ListView(
            children: List.generate(_phoneWidgets.length, (i) {
              return _phoneWidgets[i];
            }),
          )),
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