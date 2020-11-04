import 'package:flutter/material.dart';
import 'not_ready_orders.dart';

class OrderDetails extends StatelessWidget {
  final String orderState, name, uid;
  OrderDetails({Key key, this.orderState, this.name, this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orderState == "pending") {
      return NotReadyOrderDetails(
        name: name,
        uid: uid,
        orderState: orderState,
      );
    } else {
      return Text(
        orderState,
        style: TextStyle(
          fontSize: 18,
          fontFamily: "Amiri",
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  setState(Function() param0) {}
}
