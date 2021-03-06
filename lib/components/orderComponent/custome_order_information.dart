import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/components/pages/loadingData.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class CustomerOrderInformation extends StatelessWidget {
  final String uid;
  CustomerOrderInformation({Key key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Order>(
        stream: OrderServices(uid: uid).orderData,
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
                                    child: AdminDrawer()),
                                body: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListView(
                                    children: <Widget>[
                                      _customTitle("معلومات الاتصال بـ ${business.name}"),

                                      _labelTextField(Icons.phone, Colors.green,
                                          business.phoneNumber.toString()),
                                      _labelTextField(Icons.email,
                                          Colors.red[600], business.email),

                                      _customTitle("معلومات الزبون"),

                                      _labelTextField(Icons.person,
                                          Colors.purple, customer.name),
                                      _labelTextFieldPhone(
                                          Icons.phone,
                                          Colors.green,
                                          customer.phoneNumber.toString()),
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

                                      _customTitle("معلومات السائق"),

                                      // مش فاهمها منيح لانو اعتقد بوجوب وجود خيار بعد سؤال هل تود تصنيف الطرد نعم او لا ووجوب خيار تعديل اسم السائق بعد اختيارهز لهذا تركتة فارغا لنقاشه
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
}
