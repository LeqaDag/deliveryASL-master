import 'package:flutter/cupertino.dart';

class DeliveriesCosts {
  String uid;
  List<int> deliveryPrice;
  String note;
  String adminID;
  String cityID;
  String businesID;



  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  DeliveriesCosts({
    this.uid,
    @required this.deliveryPrice,
    @required this.note,
    @required this.adminID,
    @required this.cityID,
    @required this.businesID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
