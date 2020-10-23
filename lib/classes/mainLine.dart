import 'package:flutter/cupertino.dart';

class MainLine {
  String uid;
  String name;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  MainLine({
    this.uid,
    @required this.name,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
