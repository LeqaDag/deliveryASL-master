import 'package:flutter/cupertino.dart';

class DriverDeliveryCost {
  String uid;
  String driverID;
  int cost;
  int paid;
  String locationID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  DriverDeliveryCost({
    this.uid,
    @required this.driverID,
    this.cost,
    this.paid =0,
    this.locationID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
