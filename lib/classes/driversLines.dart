import 'package:flutter/cupertino.dart';

class DriversLines {
  String uid;
  String name;
  String driverID;
  String subLineID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  DriversLines({
    this.uid,
    @required this.name,
    @required this.driverID,
    @required this.subLineID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
