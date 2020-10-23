import 'package:flutter/cupertino.dart';

class Driv {
  String uid;
  bool type;
  String address;
  String line;
  String city;
  String userID;
  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  String searchKey;

  Driv({
    this.uid,
    @required this.type,
    @required this.address,
    @required this.city,
    @required this.line,
    @required this.userID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
    this.searchKey,
  });
}
