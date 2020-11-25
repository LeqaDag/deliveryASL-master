import 'package:flutter/cupertino.dart';

class SubLine {
  String uid;
  String name;
  int indexLine;
  String mainLineID;
  String cityID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  SubLine({
    this.uid,
    @required this.name,
    @required this.indexLine,
    @required this.mainLineID,
    this.cityID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
