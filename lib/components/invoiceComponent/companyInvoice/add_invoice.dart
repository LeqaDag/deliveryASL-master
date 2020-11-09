import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/cityServices.dart';
import 'package:sajeda_app/services/orderServices.dart';
import 'package:toast/toast.dart';

import '../../../constants.dart';

class AddInvoice extends StatefulWidget {
  final String name, businessId;
  AddInvoice({this.name, this.businessId});

  @override
  _AddInvoiceState createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  List<Order> orders;
  int total;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference invoiceCollection =
      FirebaseFirestore.instance.collection('invoice');

  TextEditingController priceController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.businessId);
    return Scaffold(
      appBar: AppBar(
        title: Text('اضافة فاتورة',
            style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: AdminDrawer(name: widget.name)),
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          " عدد الطلبيات :",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Amiri",
                          ),
                        ),
                        FutureBuilder<int>(
                            future: OrderService(businesID: widget.businessId)
                                .countBusinessOrders(widget.businessId),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Text(
                                "  ${snapshot.data.toString()} " ?? "0",
                              );
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "المبلغ الكلي للشركة : ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Amiri",
                          ),
                        ),
                        StreamBuilder<List<Order>>(
                            stream: OrderService()
                                .businessAllOrders(widget.businessId),
                            builder: (context, snapshot) {
                              int totalPrice = 0;
                              if (!snapshot.hasData) {
                                return Text('جاري التحميل ... ');
                              } else {
                                orders = snapshot.data;
                                orders.forEach((element) {
                                  totalPrice += element.price;
                                  total = totalPrice;
                                });
                                return Text(totalPrice.toString());
                              }
                            }),
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.all(10.0),
                  //   child: StreamBuilder<List<Order>>(
                  //       stream:
                  //           OrderService().businessAllOrders(widget.businessId),
                  //       builder: (context, snapshot) {
                  //         int totalPrice = 0;
                  //         if (!snapshot.hasData) {
                  //           return Text('Loading...');
                  //         } else {
                  //           orders = snapshot.data;
                  //           orders.forEach((element) {
                  //             totalPrice += element.price;
                  //           });
                  //           return Text(totalPrice.toString());
                  //         }
                  //       }),
                  // ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'المبلغ المدفوع للشركة',
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
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: noteController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'ملاحظات',
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
                        _addInvoice();
                      },
                      color: Color(0xff73a16a),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'اضافة',
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

  void _addInvoice() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    invoiceCollection.doc().set({
      "note": noteController.text,
      "adminID": user.uid,
      "businessID": widget.businessId,
      "paidPrice": int.parse(priceController.text),
      "totalPrice": total,
      "isArchived": false,
    }).then((value) async {
      isLoading = false;

      Toast.show("تم اضافة فاتورة بنجاح", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      await Future.delayed(Duration(milliseconds: 1000));
      Navigator.of(context).pop();
    }).catchError((err) {});
  }
}
