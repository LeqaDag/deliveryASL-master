import 'package:flutter/cupertino.dart';

class DriverPayment {
  String uid;

  String payment;
  String driverID;
  String adminID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  DriverPayment({
    this.uid,
    @required this.payment,
    @required this.driverID,
    @required this.adminID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
