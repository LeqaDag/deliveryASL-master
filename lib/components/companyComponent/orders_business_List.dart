import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';

class OrdersBusinessList extends StatefulWidget {
  final orderState;
  final String name;
  OrdersBusinessList({this.orderState, this.name});

  @override
  _OrdersBusinessListState createState() => _OrdersBusinessListState();
}

class _OrdersBusinessListState extends State<OrdersBusinessList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context) ?? [];
    print(widget.orderState);
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return CustomCompanyOrdersStatus(
            order: orders[index],
            orderState: widget.orderState,
            name: widget.name,
          );
        });
  }
}
