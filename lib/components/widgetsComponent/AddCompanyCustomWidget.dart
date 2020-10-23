import 'package:flutter/material.dart';

class LineChoiceAndPrice extends StatefulWidget {
  @override
  _LineChoiceAndPriceState createState() => _LineChoiceAndPriceState();
}

class _LineChoiceAndPriceState extends State<LineChoiceAndPrice> {
  TextEditingController linController = new TextEditingController();
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(
                  right: width * 0.04, left: width * 0.04, top: width * 0.03),
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
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Color(0xff636363),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
                  hintText: "خط التوصيل",
                  hintStyle: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 18.0,
                  ),
                  labelStyle: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 18.0,
                      color: Color(0xff316686)),
                ),
              ),
            ),
          ),
          Container(
            // margin: EdgeInsets.only(top:10 ,bottom:10 ,left:10 ,right: 10),
            child: Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(
                    right: width * 0.04, left: width * 0.04, top: width * 0.03),
                child: TextFormField(
                  controller: linController,
                  keyboardType: TextInputType.number,
                  // obscureText: obscuretext,

                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(right: 10.0, left: 10.0),
                    hintText: "سعر التوصيل",
                    hintStyle: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 18.0,
                    ),
                    prefixIcon: Icon(Icons.attach_money),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
