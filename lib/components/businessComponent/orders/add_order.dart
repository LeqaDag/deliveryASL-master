import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/classes/customer.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/cityComponent/cityList.dart';
import 'package:sajeda_app/components/pages/business_drawer.dart';
import 'package:sajeda_app/services/cityServices.dart';
import 'package:sajeda_app/services/customerServices.dart';
import 'package:sajeda_app/services/orderServices.dart';
import 'package:provider/provider.dart';

class AddNewOdersByBusiness extends StatefulWidget {
  final String name, uid;
  AddNewOdersByBusiness({this.name, this.uid});

  @override
  _AddNewOdersByBusinessState createState() => _AddNewOdersByBusinessState();
}

class _AddNewOdersByBusinessState extends State<AddNewOdersByBusiness> {
  final _formKey = GlobalKey<FormState>();
  String customerCityID = 'One';
  String datehh = "";

  //Order Filed
  TextEditingController orderDescription = new TextEditingController();
  TextEditingController orderPrice = new TextEditingController();
  bool orderType = false;
  List<int> orderTotalPrice = [10, 20];
  DateTime orderDate = new DateTime.now();
  TextEditingController orderNote = new TextEditingController();

  //Customer Fileds
  TextEditingController customerName = new TextEditingController();
  TextEditingController customerPhoneNumber = new TextEditingController();
  TextEditingController customerPhoneNumberAdditional =
      new TextEditingController();
  TextEditingController customerAddress = new TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: BusinessDrawer(name: widget.name, uid: widget.uid)),
      appBar: AppBar(
        title: Text('اضافة طلبية جديدة',
            style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
        centerTitle: true,
        backgroundColor: Color(0xff316686),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: <Widget>[
            _infoLabel(
              "معلومات الزبون",
              Icon(Icons.person, color: Colors.white, size: 30),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _customerName(customerName),
                  Row(
                    children: <Widget>[
                      _customerPhoneNumber(
                          "رقم الزبون", 10, customerPhoneNumber),
                      _customerPhoneNumber(
                          "رقم احتياطي", 0, customerPhoneNumberAdditional),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      //sajeda code
                      _cityChoice(),
                      //sajeda code
                      _customerAddress(customerAddress),
                    ],
                  ),
                  _infoLabel(
                    "معلومات الطلبية",
                    Icon(Icons.info, color: Colors.white, size: 30),
                  ),
                  _orderDescription(orderDescription),
                  Row(
                    children: <Widget>[
                      _deliveryType(),
                      _orderDate(),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _deliveryPriceByCity(),
                      _oderPrice(orderPrice),
                      _totalOderPrice(),
                    ],
                  ),
                  _notes(orderNote),
                  _addNewOrderButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ملاحظة: عند الاضافة الى قاعدة البيانات لا بد من اعطاء براميتر لكل دالة وخصاية المفتاح للدوال
  Widget _deliveryPriceByCity() {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: TextFormField(
          enabled: false,
          decoration: InputDecoration(
            labelStyle: TextStyle(
                fontFamily: 'Amiri', fontSize: 18.0, color: Colors.red),
            contentPadding: EdgeInsets.only(right: 20.0),
            filled: true,
            fillColor: Color(0xffC6C4C4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  } // سعر التوصيل حسب المدينة المختارة

  Widget _oderPrice(TextEditingController fieldController) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 0),
        child: TextFormField(
          controller: fieldController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "سعر المنتج",
            labelStyle: TextStyle(
                fontFamily: 'Amiri', fontSize: 18.0, color: Color(0xff316686)),
            contentPadding: EdgeInsets.only(right: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  } // سعر المنتج المدخل من قبل البائع

  Widget _totalOderPrice() {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 0),
        child: TextFormField(
          enabled: false,
          decoration: InputDecoration(
            labelText: "السعر الكلي",
            contentPadding: EdgeInsets.only(right: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  } // السعر الكلي للمنتح = سعر التوصيل + سعر المنتج ،، وهو الذي يظهر للسائق

  Widget _infoLabel(String lableText, Icon icon) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xff316686),
          labelText: lableText,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'Amiri',
          ),
          contentPadding: EdgeInsets.only(right: 20),
          prefixIcon: icon, //Icon(Icons.person,color: Colors.white,size: 30,),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide()),
        ),
      ),
    );
  }

  Widget _customerName(TextEditingController fieldController) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: TextFormField(
        controller: fieldController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
          labelText: "اسم الزبون",
          labelStyle: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 18.0,
            color: Color(0xff316686),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _customerPhoneNumber(
      String labletext, double right, TextEditingController fieldController) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: right),
        child: TextFormField(
          controller: fieldController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 20),
            labelText: labletext,
            labelStyle: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 18.0,
              color: Color(0xff316686),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
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

  Widget _customerAddress(TextEditingController fieldController) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 0),
        child: TextFormField(
          controller: fieldController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
            labelText: "العنوان",
            labelStyle: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 18.0,
              color: Color(0xff316686),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _orderDescription(TextEditingController fieldController) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        controller: fieldController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
          labelText: "وصف الطلبية",
          labelStyle: TextStyle(
              fontFamily: 'Amiri', fontSize: 18.0, color: Color(0xff316686)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _deliveryType() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: DropdownButtonFormField(
          onChanged: (String newValue) {
            setState(() {
              customerCityID = newValue;
            });
          },
          items: <String>['عادي', 'مستعجل']
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
              contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
              labelText: "نوع التوصيل",
              labelStyle: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 18.0,
                  color: Color(0xff316686))),
        ),
      ),
    );
  }

  Widget _orderDate() {
    return Expanded(
      flex: 3,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 0),
        child: TextFormField(
          enabled: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
            labelText: datehh,
            prefixIcon: Icon(
              Icons.date_range,
              color: Color(0xff316686),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _notes(TextEditingController fieldController) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: TextFormField(
        controller: fieldController,

        //minLines: 2,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
          labelText: "الملاحظات",
          labelStyle: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 18.0,
            color: Color(0xff316686),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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

  Widget _addNewOrderButton() {
    return Container(
      child: RaisedButton(
          padding: EdgeInsets.only(right: 60, left: 60),
          color: Color(0xff73A16A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Color(0xff73A16A)),
          ),
          onPressed: () async {
            Customer customer = new Customer(
                name: customerName.text,
                phoneNumber: int.parse(customerPhoneNumber.text),
                phoneNumberAdditional:
                    int.parse(customerPhoneNumberAdditional.text),
                cityID: customerCityID,
                address: customerAddress.text,
                isArchived: false);
            String customerID =
                await CustomerService().addcustomerData(customer);

            await OrderService().addOrderData(new Order(
              price: int.parse(orderPrice.text),
              totalPrice: orderTotalPrice,
              type: orderType,
              description: orderDescription.text,
              date: orderDate,
              note: orderNote.text,
              customerID: customerID,
            ));
          },
          child: Text('اضافة',
              style: TextStyle(
                  fontFamily: 'Amiri', fontSize: 18.0, color: Colors.white))),
    );
  }
}
