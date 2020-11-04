import 'package:flutter/cupertino.dart';

class DeliveryStatus {
  String uid;

  // bool isDelivered;
  // bool isDeliveredWithChangePrice;
  // bool isCancalledBecauseOfFaultProduct;
  // bool isCancalledBecauseOfSpecialReasons;
  // bool isCancalledBecauseOfOtherReasons;
  // bool isReturnedBecauseOfOtherReasons;
  // bool isReturnedBecauseOfSpecialReasons;
  // bool isReturnedBecauseOfNotAnswering;
  // bool isPostpone;
  // bool isStucked;
  // bool isMissing;
  // bool isFound;
  // bool isSearchingFor;

  String note;
  String orderID;
  String driverID;
  String businessID;
  String status;
  DateTime date;
  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  DeliveryStatus({
    this.uid,
    this.note,
    @required this.orderID,
    @required this.driverID,
    @required this.businessID,
    @required this.status,
    this.date,
    // this.isDelivered = false,
    // this.isDeliveredWithChangePrice = false,
    // this.isCancalledBecauseOfFaultProduct = false,
    // this.isCancalledBecauseOfSpecialReasons = false,
    // this.isCancalledBecauseOfOtherReasons = false,
    // this.isReturnedBecauseOfOtherReasons = false,
    // this.isReturnedBecauseOfSpecialReasons = false,
    // this.isReturnedBecauseOfNotAnswering = false,
    // this.isPostpone = false,
    // this.isStucked = false,
    // this.isMissing = false,
    // this.isFound = false,
    // this.isSearchingFor = false,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
  });
}
