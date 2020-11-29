import 'package:flutter/cupertino.dart';

class Location {
  String uid;
  String name;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  Location({
    this.uid,
    @required this.name,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
