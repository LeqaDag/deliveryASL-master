import 'package:flutter/cupertino.dart';

class MainLine {
  String uid;
  String name;
  String locationID;
  String cityName;
  String cityID;
  bool isArchived;
  DateTime deleteDate;
  String deleteUser;
  int index;

  MainLine({
    this.uid,
    @required this.name,
    @required this.locationID,
    @required this.cityName,
    @required this.cityID,
    this.isArchived = false,
    this.index = 0,
    this.deleteDate,
    this.deleteUser,
  });
}
