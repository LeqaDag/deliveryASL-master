import 'package:flutter/cupertino.dart';

class DriversLines {
  String uid;

  String subLineID;
  String driverID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  DriversLines({
    this.uid,
    @required this.subLineID,
    @required this.driverID,

    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
