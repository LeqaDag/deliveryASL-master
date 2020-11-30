import 'package:flutter/cupertino.dart';

class City {
  String uid;
  String name;

  String mainLineID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  City({
    this.uid,
    @required this.name,
    this.isArchived = false,
    this.mainLineID = '',
    this.deleteDate,
    this.deleteUser,
  });
}
