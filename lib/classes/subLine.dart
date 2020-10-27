import 'package:flutter/cupertino.dart';

class SubLine {
  String uid;
  String name;
  int index;
  String mainLineID;
  String cityID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  SubLine({
    this.uid,
    @required this.name,
    @required this.index,
    @required this.mainLineID,
    @required this.cityID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
