import 'package:flutter/cupertino.dart';

class DriverClassification {
  String uid;

  String classification;
  String driverID;
  String adminID;
  String orderID;
  String mainLineID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  DriverClassification({
    this.uid,
    @required this.classification,
    @required this.orderID,
    @required this.driverID,
    @required this.adminID,
    @required this.mainLineID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
