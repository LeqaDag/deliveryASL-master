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
  bool inStock;

  DateTime isLoadingDate;
  DateTime isReceivedDate;
  DateTime isDeliveryDate;
  DateTime isUrgentDate;
  DateTime isCancelldDate;
  DateTime isReturnDate;
  DateTime isDoneDate;
  DateTime isPaidDate;
  DateTime inStockDate;

  String businesID;
  String driverID;
  String customerID;
  int indexLine;
  int mainLineIndex;
  String sublineID;
  String locationID;
  String mainlineID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  Order({
    this.uid,
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
    this.inStock = false,
    this.businesID,
    this.driverID = '',
    this.driverPrice = 0,
    this.indexLine = 0,
    this.mainLineIndex = 0,
    this.mainlineID,
    @required this.customerID,
    this.locationID,
    this.isArchived = false,
    this.deleteDate,
    this.deleteUser,
    this.sublineID,
    this.isLoadingDate,
    this.isReceivedDate,
    this.isDeliveryDate,
    this.isUrgentDate,
    this.isCancelldDate,
    this.isReturnDate,
    this.isDoneDate,
    this.isPaidDate,
    this.inStockDate,
  });
}
