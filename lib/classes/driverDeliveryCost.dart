import 'package:flutter/cupertino.dart';

class DriverDeliveryCost {
  String uid;
  String driverID;
  int cost;
  String locationID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  DriverDeliveryCost({
    this.uid,
    @required this.driverID,
    this.cost,
    this.locationID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
