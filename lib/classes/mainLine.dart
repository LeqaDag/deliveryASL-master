import 'package:flutter/cupertino.dart';

class MainLine {
  String uid;
  String name;
  String cityID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  MainLine({
    this.uid,
    @required this.name,
    @required this.cityID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
