import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/classes/customer.dart';
import 'package:sajeda_app/classes/deliveryStatus.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/classes/mainLine.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/components/pages/loadingData.dart';
import 'package:sajeda_app/services/businessServices.dart';
import 'package:sajeda_app/services/cityServices.dart';
import 'package:sajeda_app/services/customerServices.dart';
import 'package:sajeda_app/services/deliveryStatusServices.dart';
import 'package:sajeda_app/services/driverServices.dart';
import 'package:sajeda_app/services/mainLineServices.dart';
import 'package:sajeda_app/services/orderServices.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class CancelldInfo extends StatelessWidget {
  final String uid, name;
  CancelldInfo({Key key, this.uid, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Order>(
        stream: OrderService(uid: uid).orderData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Order order = snapshot.data;
            String orderType = '';
            if (!order.type) {
              orderType = "عادي";
            } else {
              orderType = "مستعجل";
            }
            print(order.customerID);
            return StreamBuilder<Customer>(
                stream: CustomerService(uid: order.customerID).customerData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Customer customer = snapshot.data;
                    return StreamBuilder<Business>(
                        stream:
                            BusinessService(uid: order.businesID).businessByID,
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
                                      _customTitle(
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
                                      _labelTextField(Icons.email,
                                          Colors.red[600], business.email),

                                      _customTitle("معلومات الزبون"),

                                      _labelTextField(Icons.person,
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
                                      _labelTextField(Icons.location_on,
                                          Colors.blue, customer.cityID),

                                      _customTitle("معلومات الطلبية"),

                                      _labelTextField(Icons.short_text,
                                          Colors.green[700], order.description),
                                      _labelTextFieldPrice(order.price
                                          .toString()), // تغير الايكونات بعد اضافتها على الاجهزة بشكل رسمي
                                      _labelTextField(
                                          Icons.date_range,
                                          Colors.deepPurpleAccent[200],
                                          intl.DateFormat('yyyy-MM-dd')
                                              .format(order.date)),
                                      _labelTextField(Icons.scatter_plot,
                                          Colors.grey, orderType),

                                      StreamBuilder<Driver>(
                                        stream:
                                            DriverService(uid: order.driverID)
                                                .driverByID,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Column(
                                              children:
                                                  _driverInfo(snapshot.data),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                      StreamBuilder<List<DeliveryStatus>>(
                                        stream: DeliveriesStatusServices(
                                                orderID: order.uid)
                                            .deliveryStatusData,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Column(
                                              children: _deliveryStatus(
                                                  snapshot.data[0]),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
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

  List<Widget> _driverInfo(Driver driver) {
    return [
      _customTitle("معلومات السائق"),
      _labelTextField(Icons.person, Colors.amber[600], driver.name),
      _labelTextField(Icons.phone, Colors.green, driver.phoneNumber),
      _labelTextFieldCity(Icons.person_pin, Colors.blue, driver.cityID),
      _labelTextFieldMainLine(
          Icons.location_on, Colors.grey, driver.mainLineID),
    ];
  }

  List<Widget> _deliveryStatus(DeliveryStatus deliveryStatus) {
    return [
      _customTitle("معلومات التوصيل"),
      _labelTextField(
          Icons.block, Colors.red[700], _orderState(deliveryStatus.status)),
      _labelTextField(Icons.date_range, Colors.green,
          intl.DateFormat('yyyy-MM-dd').format(deliveryStatus.date)),
    ];
  }

  String _orderState(String status) {
    switch (status) {
      case '5':
        {
          return 'ملغية لاسباب شخصية';
        }
        break;
      case '6':
        {
          return 'ملغية لاسباب أخرى';
        }
        break;
      case '4':
        {
          return 'ملغية بسبب خطأ في المنتج';
        }
        break;
      default:
        {
          return "";
        }
        break;
    }
  }

  Widget _customTitle(String title) {
    return Container(
      width: double.infinity,
      height: 40,
      color: KCustomCompanyOrdersStatus,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Amiri",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _labelTextFieldPhone(IconData icon, Color color, String text) {
    return Container(
      width: double.infinity,
      height: 35,
      child: TextField(
        onTap: () {
          launch("tel:" + Uri.encodeComponent(text));
        },
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
          prefixIcon: Icon(
            icon,
            color: color,
            size: 20,
          ),
          hintText: text, //String Data form DB.
        ),
      ),
    );
  }

  Widget _labelTextFieldPrice(String text) {
    return Container(
      width: double.infinity,
      height: 35,
      // margin: EdgeInsets.only(right:width*0.04 ,left:width*0.04 ),
      // color: KCustomCompanyOrdersStatus,

      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
          prefixIcon: Image.asset('assets/price.png'),
          hintText: text, //String Data form DB.
        ),
      ),
    );
  }

  Widget _labelTextField(IconData icon, Color color, String text) {
    return Container(
      width: double.infinity,
      height: 35,
      // margin: EdgeInsets.only(right:width*0.04 ,left:width*0.04 ),
      // color: KCustomCompanyOrdersStatus,

      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
          prefixIcon: Icon(
            icon,
            color: color,
            size: 20,
          ),
          hintText: text, //String Data form DB.
        ),
      ),
    );
  }

  Widget _labelTextFieldCity(IconData icon, Color color, String text) {
    return Container(
      width: double.infinity,
      height: 35,
      child: StreamBuilder<City>(
        stream: CityService(uid: text).cityByID,
        builder: (context, snapshot) {
          City city = snapshot.data;
          return TextField(
            enabled: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
              prefixIcon: Icon(
                icon,
                color: color,
                size: 20,
              ),
              hintText: city.name, //String Data form DB.
            ),
          );
        },
      ),
    );
  }

  Widget _labelTextFieldMainLine(IconData icon, Color color, String text) {
    return Container(
      width: double.infinity,
      height: 35,
      child: StreamBuilder<MainLine>(
        stream: MainLineServices(uid: text).mainLineByID,
        builder: (context, snapshot) {
          MainLine mainLine = snapshot.data;
          return TextField(
            enabled: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
              prefixIcon: Icon(
                icon,
                color: color,
                size: 20,
              ),
              hintText: mainLine.name, //String Data form DB.
            ),
          );
        },
      ),
    );
  }
}
