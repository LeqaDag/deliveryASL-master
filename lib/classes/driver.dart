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
  int pLoad;

  String userID;
  String locationID;

  String cityID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  int paidSalary;
  String searchKey;
  DateTime paidDate;

  Driver({
    this.uid,
    @required this.name,
    @required this.type,
    @required this.email,
    @required this.phoneNumber,
    @required this.address,
    @required this.cityID,
    @required this.load,
    this.pLoad = 0,
    this.bonus = 0,
    this.userID,
    this.paidSalary = 0,
    @required this.locationID,
    this.isArchived = false,
    this.paidDate,
    this.deleteDate,
    this.deleteUser,
    this.searchKey,
  });
}
