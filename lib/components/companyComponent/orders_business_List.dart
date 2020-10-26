import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';

class OrdersBusinessList extends StatelessWidget {
  final orderState;
  final String name;
  OrdersBusinessList({this.orderState, this.name});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context) ?? [];
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return CustomCompanyOrdersStatus(
              order: orders[index], orderState: orderState, name: name,);
        });
  }
}
