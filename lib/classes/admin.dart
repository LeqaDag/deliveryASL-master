import 'package:flutter/cupertino.dart';

class Admin {
  String uid;
  String userID;
  bool type;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  Admin({
    this.uid,
    @required this.type,
    @required this.userID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
