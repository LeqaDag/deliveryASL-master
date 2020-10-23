import 'package:flutter/material.dart';

class CityChoice extends StatefulWidget {
  @override
  _CityChoiceState createState() => _CityChoiceState();
}

class _CityChoiceState extends State<CityChoice> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: DropdownButtonFormField(
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(fontFamily: 'Amiri', fontSize: 16.0),
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 2.0,
              color: Colors.blue,
            ),
            //Change color to Color(0xff73a16a)
          ),
          contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
          hintText: "المدينة",

          // labelStyle: TextStyle(
          //     fontFamily: 'Amiri', fontSize: 18.0, color: Color(0xff316686)),
        ),
      ),
    );
  }
}

class DynamicCustomTextFormField extends StatelessWidget {
  final TextInputType keyboardInputType;
  final bool obscuretext;
  final String hinttext;
  final Icon icon;
  final double borderCircular1;
  final double borderCircular2;
  final TextEditingController controller;

  DynamicCustomTextFormField(
      {this.keyboardInputType,
      this.obscuretext,
      this.hinttext,
      this.icon,
      this.borderCircular1,
      this.borderCircular2,
      this.controller});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
          right: width * 0.15,
          left: width * 0.15,
          top: width * 0.01,
          bottom: width * 0.01),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardInputType,
        obscureText: obscuretext,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 10.0, left: 10.0),
          hintText: hinttext,
          hintStyle: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 18.0,
          ),
          prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderCircular1),

            ///25
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderCircular2),

            ///40
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBoxSize extends StatelessWidget {
  final double height;
  CustomBoxSize({@required this.height});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * this.height,
    );
  }
}
