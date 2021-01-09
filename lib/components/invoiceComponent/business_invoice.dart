import 'package:AsyadLogistic/classes/business.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '../../constants.dart';
import 'shared_data.dart';

class BusinessInvoice extends StatefulWidget {
  final Business business;

  BusinessInvoice({@required this.business});

  @override
  _BusinessInvoiceState createState() => _BusinessInvoiceState();
}

class _BusinessInvoiceState extends State<BusinessInvoice> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    IconData icon;
    String stateOrder, driverName;
    Color color;
    DateTime stateDate;

    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
        Widget>[
      Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               
                VerticalDivider(),
               
                Icon(
                  Icons.arrow_downward,
                ),
                VerticalDivider(),
               
                Icon(
                  Icons.arrow_upward,
                ),
              ]),
          HorizantalDivider(width),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              
                VerticalDivider(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                     
                      Padding(
                        padding: EdgeInsets.only(
                            left: height * 0.015,
                            top: height * 0,
                            bottom: height * 0),
                        child: Image.asset(
                          'assets/price.png',
                          scale: 1.5,
                        ),
                      ),
                    ]),
              ]),
          HorizantalDivider(width),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
   
          ]),
          HorizantalDivider(width),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                
                VerticalDivider(),
                
              ]),
          HorizantalDivider(width),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              
              ]),
          HorizantalDivider(width),
         
        ],
      )),
      SizedBox(
        height: 15,
      ),
    ]);
  }

  // ignore: non_constant_identifier_names
  Widget VerticalDivider() {
    return Container(
      color: Colors.black45,
      height: 50,
      width: 1,
    );
  }

  // ignore: non_constant_identifier_names
  Widget HorizantalDivider(double width) {
    return Container(
      color: Colors.black45,
      height: 1,
      width: width,
    );
  }
}
