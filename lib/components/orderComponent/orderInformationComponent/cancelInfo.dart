import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/deliveryStatus.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/classes/mainLine.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/components/pages/loadingData.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/deliveryStatusServices.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';
import 'shared_information.dart';

class CancelldInfo extends StatelessWidget {
  final String uid, name;
  CancelldInfo({Key key, this.uid, this.name}) : super(key: key);

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
                                      LabelTextField(Icons.location_on,
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
      CustomTitle("معلومات السائق"),
      LabelTextField(Icons.person, Colors.amber[600], driver.name),
      LabelTextField(Icons.phone, Colors.green, driver.phoneNumber),
      LabelTextFieldCity(Icons.person_pin, Colors.blue, driver.cityID),
      LabelTextFieldMainLine(Icons.location_on, Colors.grey, driver.locationID),
    ];
  }

  List<Widget> _deliveryStatus(DeliveryStatus deliveryStatus) {
    return [
      CustomTitle("معلومات التوصيل"),
      LabelTextField(
          Icons.block, Colors.red[700], _orderState(deliveryStatus.status)),
      LabelTextField(Icons.date_range, Colors.green,
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
          return "لا يوجد ملاحظات";
        }
        break;
    }
  }
}
