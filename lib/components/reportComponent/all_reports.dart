import 'package:AsyadLogistic/components/invoiceComponent/orders_invoice.dart';
import 'package:AsyadLogistic/components/invoiceComponent/shared_data.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'report_details.dart';

class ReportsList extends StatefulWidget {
  final Order order;
  final String name;
  List<Order> orders;

  ReportsList({this.order, this.name, this.orders});

  @override
  _ReportsListState createState() => _ReportsListState();
}

class _ReportsListState extends State<ReportsList> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
   // final orders = Provider.of<List<Order>>(context) ?? [];

    if (widget.orders != []) {

    } else {
      return Center(child: Image.asset("assets/EmptyOrder.png"));
    }
  }
}

class CustomCard extends StatelessWidget {
  final String uid, name;
  final String invoiceType;

  CustomCard({this.uid, this.invoiceType, this.name});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

      return StreamBuilder<Order>(
        stream: OrderServices(uid: uid).orderByID,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            Order order = snapshot.data;
            return ReportDetails(order: order, name: name);
          }
        },
      );
  }
}