import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/components/pages/loadingData.dart';
import 'package:AsyadLogistic/components/screenComponent/admin_orders.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:AsyadLogistic/components/orderComponent/orderInformationComponent/shared_information.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class LoadingInfo extends StatelessWidget {
  final String uid, name;
  LoadingInfo({Key key, this.uid, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Order>(
        stream: OrderServices(uid: uid).orderData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Order order = snapshot.data;
            String orderType = '';
            if (order.isUrgent == false) {
              orderType = "عادي";
            } else {
              orderType = "مستعجل";
            }
            print(order.customerID);
            return StreamBuilder<Customer>(
                stream: CustomerServices(uid: order.customerID).customerData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Customer customer = snapshot.data;
                    return StreamBuilder<Business>(
                        stream:
                            BusinessServices(uid: order.businesID).businessByID,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Business business = snapshot.data;
                            return Scaffold(
                                appBar: AppBar(
                                  title: Text("معلومات طرد ${customer.name}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Amiri',
                                      )),
                                  backgroundColor: kAppBarColor,
                                  centerTitle: true,
                                ),
                                endDrawer: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AdminDrawer(
                                      name: name,
                                    )),
                                body: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListView(
                                    children: <Widget>[
                                      CustomTitle(
                                          "معلومات الاتصال بـ ${business.name}"),
                                      GestureDetector(
                                          onTap: () {
                                            print(customer.phoneNumber
                                                .toString());
                                            launch("tel:" +
                                                Uri.encodeComponent(
                                                    "${business.phoneNumber.toString()}"));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 35,
                                            child: TextField(
                                              enabled: false,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 7,
                                                    right: 8),
                                                prefixIcon: Icon(
                                                  Icons.phone,
                                                  color: Colors.green,
                                                  size: 20,
                                                ),
                                                hintText: business.phoneNumber
                                                    .toString(), //String Data form DB.
                                              ),
                                            ),
                                          )),

                                      LabelTextField(Icons.email,
                                          Colors.red[600], business.email),

                                      CustomTitle("معلومات الزبون"),

                                      LabelTextField(Icons.person,
                                          Colors.purple, customer.name),
                                      GestureDetector(
                                          onTap: () {
                                            print(customer.phoneNumber
                                                .toString());
                                            launch("tel:" +
                                                Uri.encodeComponent(
                                                    "0${customer.phoneNumber.toString()}"));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 35,
                                            child: TextField(
                                              enabled: false,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 7,
                                                    bottom: 7,
                                                    right: 8),
                                                prefixIcon: Icon(
                                                  Icons.phone,
                                                  color: Colors.green,
                                                  size: 20,
                                                ),
                                                hintText:
                                                    "0${customer.phoneNumber.toString()}", //String Data form DB.
                                              ),
                                            ),
                                          )),

                                      LabelTextFieldCityName(Icons.location_on,
                                          Colors.blue, customer.cityName),

                                      CustomTitle("معلومات الطلبية"),

                                      LabelTextField(Icons.short_text,
                                          Colors.green[700], order.description),
                                      LabelTextFieldPrice(order.price
                                          .toString()), // تغير الايكونات بعد اضافتها على الاجهزة بشكل رسمي
                                      LabelTextField(
                                          Icons.date_range,
                                          Colors.deepPurpleAccent[200],
                                          intl.DateFormat('yyyy-MM-dd')
                                              .format(order.date)),
                                      LabelTextField(Icons.scatter_plot,
                                          Colors.grey, orderType),
                                      Container(
                                        margin: EdgeInsets.all(40.0),
                                        child: RaisedButton(
                                          padding: EdgeInsets.all(10.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0)),
                                          onPressed: () {
                                            OrderServices(uid: uid)
                                                .updateOrderToisReceived;
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminOrders()),
                                            );
                                          },
                                          color: Color(0xff73a16a),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'تم الإستلام',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Amiri',
                                                    fontSize: 24.0),
                                              ),
                                              SizedBox(
                                                width: 40.0,
                                              ),
                                              Icon(
                                                Icons.check_circle,
                                                color: Colors.white,
                                                size: 32.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          } else {
                            return LoadingData();
                          }
                        });
                  } else {
                    return LoadingData();
                  }
                });
          } else {
            return LoadingData();
          }
        });
  }
}
