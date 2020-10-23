import 'package:flutter/cupertino.dart';

class Delivery {
  String uid;
  DateTime deliveryDate;
  String note;
  String orderID;
  String driverID;
  String deliveryStatusID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  Delivery({
    this.uid,
    @required this.deliveryDate,
    @required this.note,
    @required this.orderID,
    @required this.driverID,
    @required this.deliveryStatusID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
