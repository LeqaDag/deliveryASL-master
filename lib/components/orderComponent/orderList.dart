import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/companyComponent/company_orders_admin_side.dart';
import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';

import '../../constants.dart';

class OrderList extends StatefulWidget {
  final String orderState, name;
  OrderList({@required this.orderState, this.name});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context) ?? [];
    if (orders != []) {
      final ids = orders.map((e) => e.businesID).toSet();
      orders.retainWhere((x) => ids.remove(x.businesID));
      return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return CustomCardAndListTile(
              color: KCustomCompanyOrdersStatus,
              businessID: orders[index].businesID,
              orderState: widget.orderState,
              name: widget.name,
              onTapBox: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompanyOrdersAdminSide(
                            uid: orders[index].businesID,
                            orderState: widget.orderState,
                            name: widget.name,
                          )),
                );
              });
        },
      );
    } else {
      return Center(child: Image.asset("assets/EmptyOrder.png"));
    }
  }
}
