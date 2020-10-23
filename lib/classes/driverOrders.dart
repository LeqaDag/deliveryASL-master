import 'package:flutter/cupertino.dart';

class DriverOrders {
  String uid;

  String orderID;
  String driverID;
  String adminID;
  String mainLineID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  DriverOrders({
    this.uid,
    @required this.orderID,
    @required this.driverID,
    @required this.adminID,
    @required this.mainLineID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
