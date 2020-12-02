import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/pages/business_drawer.dart';
import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';

import '../../../constants.dart';

class OrderStatus extends StatelessWidget {
  final Order order;
  final String orderState, name, uid, customerName;

  OrderStatus(
      {this.order, this.orderState, this.name, this.uid, this.customerName});

  @override
  Widget build(BuildContext context) {
    print(order.uid);
    String delivStatusID;
    FirebaseFirestore.instance
        .collection('delivery_status')
        .where('orderID', isEqualTo: order.uid)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => {delivStatusID = value.docs[0].id});
    print(delivStatusID);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("تفاصيل طرد $customerName",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        drawer: BusinessDrawer(name: name, uid: uid),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            CustomTextFieldOrderStatus("assets/OrderStatus.png", orderState),
            SizedBox(
              height: 20,
            ),
            // FutureBuilder<String>(
            //     future: DeliveriesStatusServices(uid: widget.order.customerID)
            //         .customerName,
            //     builder: (context, snapshot) {
            //       customerName = snapshot.data;

            //       return Text(
            //         customerName ?? "",
            //         style: TextStyle(
            //           fontSize: 13,
            //           fontWeight: FontWeight.bold,
            //           fontFamily: "Amiri",
            //         ),
            //       );
            //     }),
            CustomTextFieldOrderStatus("assets/OrderNotes.png", delivStatusID),
            SizedBox(
              height: 20,
            ),
            CustomTextFieldOrderStatus(
                "assets/OrderِAmountStatus.png", "المبلغ المستحق للشركة"),
            SizedBox(
              height: 20,
            ),
            CustomTextFieldOrderStatus(
                "assets/DateOrderDeliveredStatus.png", "تاريخ تسليم الطرد"),
            SizedBox(
              height: 20,
            ),
            CustomTextFieldOrderStatus(
                "assets/DateOrderِAdminAuthenticationStatus.png",
                "تاريخ المصادقة من الادمن"),
          ],
        ),
      ),
    );
  }
}
