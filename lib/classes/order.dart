import 'package:flutter/cupertino.dart';

class Order {
  String uid;
  int price;
  List<int> totalPrice;
  bool type;
  String description;
  DateTime date;
  String note;

  int driverPrice;

  bool isLoading;
  bool isReceived;
  bool isDelivery;
  bool isUrgent;
  bool isCancelld;
  bool isReturn;
  bool isDone;
  bool isPaid;

  String businesID;
  String driverID;
  String customerID;
  bool isArchived;
  DateTime deleteDate;
  String deleteUser;
  int indexLine;
  String sublineID;

  Order(
      {this.uid,
      @required this.price,
      @required this.totalPrice,
      @required this.type,
      this.description,
      @required this.date,
      @required this.note,
      this.isLoading = true,
      this.isReceived = false,
      this.isDelivery = false,
      this.isUrgent = false,
      this.isCancelld = false,
      this.isReturn = false,
      this.isDone = false,
      this.isPaid = false,
      this.businesID,
      this.driverID = '',
      this.driverPrice = 0,
      this.indexLine = 0,
      @required this.customerID,
      this.isArchived = false,
      this.deleteDate,
      this.deleteUser,
      this.sublineID});
}
