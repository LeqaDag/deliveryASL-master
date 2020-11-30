import 'package:flutter/cupertino.dart';

class Business {
  String uid;
  String name;
  String email;
  String phoneNumber;
  String userID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  String searchKey;

  Business({
    this.uid,
    @required this.name,
    @required this.phoneNumber,
    @required this.email,
    @required this.userID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
