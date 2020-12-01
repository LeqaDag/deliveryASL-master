import 'package:flutter/cupertino.dart';

class MainLine {
  String uid;
  String name;
  String locationID;
  String cityName;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  MainLine({
    this.uid,
    @required this.name,
    @required this.locationID,
    @required this.cityName,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
