import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/classes/deliveriesCost.dart';
import 'package:sajeda_app/components/cityComponent/cityList.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/DeliveriesCostsServices.dart';
import 'package:sajeda_app/services/cityServices.dart';

import '../../../constants.dart';

class AddDeliveryCost extends StatefulWidget {
  final String name, businessID, businessName, busID;
  AddDeliveryCost({this.name, this.businessID, this.businessName, this.busID});

  @override
  _AddDeliveryCostState createState() => _AddDeliveryCostState();
}

class _AddDeliveryCostState extends State<AddDeliveryCost> {
  final _formKey = GlobalKey<FormState>();
  static List<String> deliveryCostList = [null];
  static List<String> cityList = [null];
 static List<String> priceList = [null];

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
                    ..._getAll(),
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
                            deliveryCostList
                                .asMap()
                                .forEach((index, price) async {
                              print(price);

                              await DeliveriesCostsServices()
                                  .addDeliveryCostData(new DeliveriesCosts(
                                      deliveryPrice: price,
                                      adminID: user.uid,
                                      city: cityList[index],
                                      businesID: widget.busID));
                            });
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

  List<Widget> _getAll() {
    List<Widget> friendsTextFields = [];
    cityList.length = deliveryCostList.length;
    deliveryCostList.length = deliveryCostList.length;

    for (int i = 0; i < deliveryCostList.length; i++) {
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
              // we need add button at last friends row
              _addRemoveButton(i == deliveryCostList.length - 1, i),
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
          deliveryCostList.insert(index, null);
        } else
          deliveryCostList.removeAt(index);
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
  TextEditingController _priceController;
  String city;
  City cc;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController();
    city = 'المدينة';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RaisedButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.0,
                color: Color(0xff636363),
              ),
              borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          elevation: 0,
          child: Container(
            margin: EdgeInsets.all(10.0),
            height: 27,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  city,
                  style: TextStyle(
                      color: Color(0xff316686),
                      fontFamily: 'Amiri',
                      fontSize: 18.0),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xff636363),
                  size: 25.0,
                ),
              ],
            ),
          ),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildAboutDialog(context),
            ).then((value) {
              setState(() {
                cc = value;
                city = cc.name;
                _AddDeliveryCostState.cityList[widget.index] = city;
                print(city);
              });
            });
          },
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (v) =>
                  _AddDeliveryCostState.deliveryCostList[widget.index] = v,
              keyboardType: TextInputType.number,
              controller: _priceController,
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

Widget _buildAboutDialog(BuildContext context) {
  return new AlertDialog(
      content: Container(
    width: double.maxFinite,
    height: double.maxFinite,
    child: StreamProvider<List<City>>.value(
        value: CityService().citys, child: CityList()),
  ));
}
