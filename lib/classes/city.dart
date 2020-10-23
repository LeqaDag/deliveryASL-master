import 'package:flutter/cupertino.dart';

class City {
  String uid;
  String name;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  City({
    this.uid,
    @required this.name,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
