import 'package:flutter/cupertino.dart';

class Driver {
  String uid;
  String name;
  bool type;
  String email;
  String phoneNumber;
  String address;

  int load;
  int bonus;

  String userID;
  String locationID;

  String cityID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  String searchKey;

  Driver({
    this.uid,
    @required this.name,
    @required this.type,
    @required this.email,
    @required this.phoneNumber,
    @required this.address,
    @required this.cityID,
    @required this.load,
    this.bonus = 0,
    this.userID,
    @required this.locationID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
    this.searchKey,
  });
}
