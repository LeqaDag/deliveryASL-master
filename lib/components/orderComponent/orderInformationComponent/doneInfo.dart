import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/deliveryStatus.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/components/pages/loadingData.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import '../../../classes/city.dart';
import '../../../classes/location.dart';
import '../../../constants.dart';
import '../../../services/cityServices.dart';
import '../../../services/locationServices.dart';

class DoneInfo extends StatelessWidget {
  final String uid, name;
  DoneInfo({Key key, this.uid, this.name}) : super(key: key);

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
                                          Colors.blue, customer.cityName),

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
                                            DriverServices(uid: order.driverID)
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
                                      // StreamBuilder<List<DeliveryStatus>>(
                                      //   stream: DeliveriesStatusServices(
                                      //           orderID: order.uid)
                                      //       .deliveryStatusData,
                                      //   builder: (context, snapshot) {
                                      //     if (snapshot.hasData) {
                                      //       return Column(
                                      //         children: _deliveryStatus(
                                      //             snapshot.data[0]),
                                      //       );
                                      //     } else {
                                      //       return Container();
                                      //     }
                                      //   },
                                      // ),
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
      GestureDetector(
          onTap: () {
            launch("tel:" +
                Uri.encodeComponent("${driver.phoneNumber.toString()}"));
          },
          child: Container(
            width: double.infinity,
            height: 35,
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.green,
                  size: 20,
                ),
                hintText: driver.phoneNumber.toString(), //String Data form DB.
              ),
            ),
          )),
      _labelTextFieldCity(Icons.person_pin, Colors.blue, driver.cityID),
      _labelTextFieldMainLine(
          Icons.location_on, Colors.grey, driver.locationID),
    ];
  }

  List<Widget> _deliveryStatus(DeliveryStatus deliveryStatus) {
    return [
      _customTitle("معلومات التوصيل"),
      _labelTextField(Icons.done_outline, Colors.green[700],
          _orderState(deliveryStatus.status)),
      _labelTextField(Icons.date_range, Colors.green,
          intl.DateFormat('yyyy-MM-dd').format(deliveryStatus.date)),
    ];
  }

  String _orderState(String status) {
    switch (status) {
      case '1':
        {
          return 'تم التوصيل';
        }
        break;
      case '3':
        {
          return 'تم التوصيل مع تغيير السعر';
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
      // margin: EdgeInsets.only(right:width*0.04 ,left:width*0.04 ),
      // color: KCustomCompanyOrdersStatus,

      child: TextField(
        onTap: () => launch("tel:0595114481"),
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
        stream: CityServices(uid: text).cityByID,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            
          return TextField(
            enabled: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
              prefixIcon: Icon(
                icon,
                color: color,
                size: 20,
              ),
              hintText: snapshot.data.name, //String Data form DB.
            ),
          );
          } else {
            return TextField(
            enabled: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
              prefixIcon: Icon(
                icon,
                color: color,
                size: 20,
              ),
              hintText: "", //String Data form DB.
            ),
          );
          }
        }
      ),
    );
  }

  Widget _labelTextFieldMainLine(IconData icon, Color color, String text) {
    return Container(
      width: double.infinity,
      height: 35,
      child: StreamBuilder<Location>(
        stream: LocationServices(uid: text).locationByID,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Location location = snapshot.data;
          return TextField(
            enabled: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
              prefixIcon: Icon(
                icon,
                color: color,
                size: 20,
              ),
              hintText: location.name ?? "", //String Data form DB.
            ),
          );
          } else {
          return TextField(
            enabled: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
              prefixIcon: Icon(
                icon,
                color: color,
                size: 20,
              ),
              hintText:  "loading ...", //String Data form DB.
            ),
          );
          }
          
          
        },
      ),
    );
  }
}
