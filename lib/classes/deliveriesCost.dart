import 'package:flutter/cupertino.dart';

class DeliveriesCosts {
  String uid;
  String deliveryPrice;
  String note;
  String adminID;
  String city;
  String businesID;
  String name;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  DeliveriesCosts(
      {this.uid,
      @required this.deliveryPrice,
      this.note,
      @required this.adminID,
      @required this.city,
      @required this.businesID,
      this.isArchived = false,
      this.deleteDate,
      this.deleteUser,
      this.name});
}
