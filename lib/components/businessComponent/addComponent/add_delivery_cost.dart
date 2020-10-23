import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/components/cityComponent/cityList.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/cityServices.dart';

import '../../../constants.dart';

class AddDeliveryCost extends StatefulWidget {
  final String name, businessID;
  AddDeliveryCost({this.name, this.businessID});

  @override
  _AddDeliveryCostState createState() => _AddDeliveryCostState();
}

class _AddDeliveryCostState extends State<AddDeliveryCost> {
  String dropdownValue = 'One';
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference deliveryCostCollection =
      FirebaseFirestore.instance.collection('deliveries_costs');
  final CollectionReference companyCollection =
      FirebaseFirestore.instance.collection('businesss');


  TextEditingController priceController = TextEditingController();

  String customerCityID = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name} إضافة سعر التوصيل ل ",
            style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  _cityChoice(),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: priceController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاء ادخال سعر التوصيل';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
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
                          //Change color to Color(0xff73a16a)
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(40.0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        _addDeliveryCost();
                      },
                      color: Color(0xff73a16a),
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
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget _cityChoice() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: RaisedButton(
          child: Text("المدينه"),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildAboutDialog(context),
            ).then((value) => print(value));
          },
        ),
      ),
    );
  }

  Widget _buildAboutDialog(BuildContext context) {
    return new AlertDialog(
        content: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: StreamProvider<List<City>>.value(
          value: CityService().citys, child: CityList()),
    ));
  }

  void _addDeliveryCost() async {
    User currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser.uid);
    print(companyCollection.snapshots().last);
    QuerySnapshot collectionSnapshot = await companyCollection.get();
    print(collectionSnapshot.docs[0].id);
    if (_formKey.currentState.validate()) {
      deliveryCostCollection.doc().set({
        "admin_id": currentUser.uid,
        "busines_id": collectionSnapshot.docs[0].id,
        //"city_id": cityID,
        "delivery_price": priceController.text,
        "is_archived": "2",
        "note": "2",
      }).then((value) {
        isLoading = false;
        Navigator.pop(context);
        Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => BusinessAdmin(name: name)),
        // );
      }).catchError((err) {});
    }
  }
}
