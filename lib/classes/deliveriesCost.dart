import 'package:flutter/cupertino.dart';

class DeliveriesCosts {
  String uid;
  String deliveryPrice;
  String note;
  String adminID;
  String locationID;
  String businesID;
  String locationName;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  DeliveriesCosts(
      {this.uid,
      @required this.deliveryPrice,
      this.note,
      @required this.adminID,
      @required this.locationID,
      @required this.businesID,
      @required this.locationName,
      this.isArchived = false,
      this.deleteDate,
      this.deleteUser});
}
