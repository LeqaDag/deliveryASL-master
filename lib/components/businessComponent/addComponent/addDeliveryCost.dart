import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/classes/deliveriesCost.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/DeliveriesCostsServices.dart';
import 'package:sajeda_app/services/cityServices.dart';

import '../../../constants.dart';

class AddDeliveryCost2 extends StatefulWidget {
  final String name, businessID, businessName, busID;
  AddDeliveryCost2({this.name, this.businessID, this.businessName, this.busID});

  @override
  _AddDeliveryCost2State createState() => _AddDeliveryCost2State();
}

class _AddDeliveryCost2State extends State<AddDeliveryCost2> {
  final _formKey = GlobalKey<FormState>();

  List<City> cities;
  String cityID;

  @override
  void initState() {
    super.initState();

    // _priceController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${widget.businessName} إضافة سعر التوصيل ل ",
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
                    StreamBuilder<List<City>>(
                        stream: CityService().citys,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            cities = snapshot.data;

                            for (var i = 0; i < cities.length; i++) {
                              return _addComponent(cities[i]);
                            }
                          } else {
                            return Container();
                          }
                        }),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.all(40.0),
                      child: RaisedButton(
                        onPressed: () {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          final User user = auth.currentUser;
                          if (_formKey.currentState.validate()) {
                            Navigator.pop(context);
                          }
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

  Widget _addComponent(City city) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              city.name,
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.purple[900],
                fontFamily: 'Amiri',
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'ادخل سعر التوصيل';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'سعر التوصيل',
                labelStyle: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 18.0,
                    color: Color(0xff316686)),
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
