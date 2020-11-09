import 'package:flutter/cupertino.dart';

class Admin {
  String uid;
  String userID;
  bool type;
  String email;
  String name;
  int phoneNumber;
  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  Admin({
    this.uid,
    @required this.type,
    @required this.userID,
    this.email,
    this.name,
    this.phoneNumber,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
