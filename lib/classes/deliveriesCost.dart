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
      this.adminID,
       this.locationID,
       this.businesID,
      this.locationName,
      this.isArchived = false,
      this.deleteDate,
      this.deleteUser});
}
