import 'package:flutter/material.dart';
import 'done_orders.dart';
import 'instoke_orders.dart';
import 'not_ready_orders.dart';
import 'stuck_orders.dart';

class OrderDetails extends StatelessWidget {
  final String orderState, name, uid;
  OrderDetails({Key key, this.orderState, this.name, this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orderState == "inStoke") {
      return InStokeOrderDetails(
        name: name,
        uid: uid,
        orderState: orderState,
      );
    }
    if (orderState == "pending") {
      return NotReadyOrderDetails(
        name: name,
        uid: uid,
        orderState: orderState,
      );
    } else if (orderState == "done") {
      return NotReadyOrderDetails(
        name: name,
        uid: uid,
        orderState: orderState,
      );
    } else {
      return NotReadyOrderDetails(
        name: name,
        uid: uid,
        orderState: orderState,
      );
    }
  }

  setState(Function() param0) {}
}
