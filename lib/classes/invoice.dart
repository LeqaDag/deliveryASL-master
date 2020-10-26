import 'package:flutter/cupertino.dart';

class Invoice {
  String uid;
  String adminID;
  String businessID;
  String note;
  int paidPrice;
  int totalPrice;

  bool isArchived;
  DateTime deleteDate;

  Invoice({
    this.uid,
    this.adminID,
    @required this.businessID,
    @required this.paidPrice,
    this.note,
    @required this.totalPrice,
    this.isArchived = false,
    this.deleteDate,
  });
}
