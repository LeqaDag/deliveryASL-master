import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'business_invoice.dart';
import 'drivers_invoice.dart';
import 'orders_invoice.dart';
import 'shared_data.dart';

class PlaceholderWidget extends StatefulWidget {
  final String invoiceType, name;

  PlaceholderWidget({this.invoiceType, this.name});

  @override
  _PlaceholderWidgetState createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.invoiceType == "order") {
      return Container(
          color: Colors.grey[350],
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                OrderCountByState(),
                SizedBox(
                  height: 15,
                ),
                StreamProvider<List<Order>>.value(
                  value: OrderServices(invoiceType: widget.invoiceType)
                      .ordersByInvoiceType,
                  child: AllInvoice(invoiceType: widget.invoiceType, name: widget.name),
                )
              ])));
    } else if (widget.invoiceType == "driver") {
      return Container(
          color: Colors.grey[350],
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                OrderCountByStateDriver(),
                SizedBox(
                  height: 15,
                ),
                StreamProvider<List<Order>>.value(
                  value: OrderServices(invoiceType: widget.invoiceType)
                      .ordersByInvoiceType,
                  child: AllInvoice(invoiceType: widget.invoiceType, name: widget.name),
                )
              ])));
    } else if (widget.invoiceType == "business") {
      return Container(
          color: Colors.grey[350],
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                // OrderCountByStateDriver(),
                SizedBox(
                  height: 15,
                ),
                StreamProvider<List<Business>>.value(
                  value: BusinessServices().business,
                  child: AllInvoice(invoiceType: widget.invoiceType, name: widget.name),
                )
              ])));
    }
  }
}

class AllInvoice extends StatefulWidget {
  final String invoiceType, name;

  AllInvoice({
    @required this.invoiceType, this.name
  });

  @override
  _AllInvoiceState createState() => _AllInvoiceState();
}

class _AllInvoiceState extends State<AllInvoice> {
  List<Order> orders;

  int total = 0;
  int isDoneOrders = 0, totalSalary = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.invoiceType == "driver" || widget.invoiceType == "order") {
      final orders = Provider.of<List<Order>>(context) ?? [];
      if (orders != []) {
        return ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return CustomCard(
              invoiceType: widget.invoiceType,
              uid: orders[index].uid,
              name: widget.name
            );
          },
        );
      } else {
        return Center(child: Image.asset("assets/EmptyOrder.png"));
      }
    } else if (widget.invoiceType == "business") {
      final business = Provider.of<List<Business>>(context) ?? [];
      if (business != []) {
        return ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: business.length,
          itemBuilder: (context, index) {
            return CustomCard(
              invoiceType: widget.invoiceType,
              uid: business[index].uid,
               name: widget.name
            );
          },
        );
      } else {
        return Center(child: Image.asset("assets/EmptyOrder.png"));
      }
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
    if (invoiceType == "order") {
      return StreamBuilder<Order>(
        stream: OrderServices(uid: uid).orderByID,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            Order order = snapshot.data;
            return OrdersInvoice(order: order, name: name);
          }
        },
      );
    } else if (invoiceType == "driver") {
      return StreamBuilder<Order>(
        stream: OrderServices(uid: uid).orderByID,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            Order order = snapshot.data;
            return DriversInvoice(order: order, name: name);
          }
        },
      );
    } else if (invoiceType == "business") {
      return StreamBuilder<Business>(
        stream: BusinessServices(uid: uid).businessByID,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            Business business = snapshot.data;
            return BusinessInvoice(business: business, name: name);
          }
        },
      );
    }
  }
}
