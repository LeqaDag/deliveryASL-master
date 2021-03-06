import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/components/pages/loadingData.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:AsyadLogistic/components/orderComponent/orderInformationComponent/shared_information.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class DeliveryInfo extends StatelessWidget {
  final String uid, name;
  DeliveryInfo({Key key, this.uid, this.name}) : super(key: key);

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
                                      LabelTextFieldPrice(
                                          order.price.toString()),
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
                                      CustomTitle("معلومات التوصيل"),
                                      LabelTextField(
                                          Icons.blur_on,
                                          Colors.black,
                                          "لا يوجد معلومات حالياً"),
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
      LabelTextFieldCity(Icons.person_pin, Colors.blue, driver.cityID),
      LabelTextFieldMainLine(Icons.location_on, Colors.grey, driver.locationID),
    ];
  }
}
