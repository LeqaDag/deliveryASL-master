import 'package:flutter/cupertino.dart';

class Users {
  String uid;
  String name;
  int phoneNumber;
  String email;
  int usertype;
  String userID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  Users({
    this.uid,
    @required this.name,
    @required this.phoneNumber,
    @required this.email,
    @required this.usertype,
    @required this.userID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
