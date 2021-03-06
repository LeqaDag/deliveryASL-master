import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';


class SheetList extends StatefulWidget {
  final String name;
  SheetList({this.name});

  @override
  _SheetListState createState() => _SheetListState();
}

class _SheetListState extends State<SheetList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context) ?? [];
    if (orders != [] && orders != null) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: orders.length,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return CustomCompanyOrdersStatus(
            order: orders[index],
            orderState: 'sheet',
            name: widget.name,
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
    } else {
      return Center(
        child: Container(
          child: Image.asset("assets/EmptyOrder.png"),
        ),
      );
    }
  }
}
