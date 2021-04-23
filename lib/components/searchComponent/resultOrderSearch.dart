import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/orderComponent/organizeOrderInfo.dart';
import 'package:flutter/material.dart';

class ResultOrderSearch extends StatelessWidget {
  final name;

  final Order order;
  ResultOrderSearch({this.name, this.order});

  @override
  Widget build(BuildContext context) {
    String orderState = "";
    if (order.isReceived == true) {
      orderState = 'isReceived';
    } else if (order.inStock == true) {
      orderState = 'inStock';
    } else if (order.isLoading == true) {
      orderState = 'isLoading';
    } else if (order.isDelivery == true) {
      orderState = 'isDelivery';
    } else if (order.isDone == true && order.isPaid == false) {
      orderState = 'isDone';
    } else if (order.isPaid == true && order.isDone == true) {
      orderState = 'isPaid';
    } else if (order.isCancelld == true) {
      orderState = 'isCancelld';
    } else if (order.isReturn == true) {
      orderState = 'isReturn';
    }

    return OrganizeOrderInfo(
      name: name,
      orderState: orderState,
      uid: order.uid,
    );
  }
}
