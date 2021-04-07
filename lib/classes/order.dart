import 'package:flutter/cupertino.dart';

class Order {
  String uid;
  int price;
  int totalPrice;
  bool type;
  String description;
  DateTime date;
  String note;

  int driverPrice;
  String barcode;
  //this all order state in application
  bool isLoading;
  bool isReceived;
  bool inStock;
  bool isDelivery;
  bool isUrgent;
  bool isCancelld;
  bool isReturn;
  bool isDone;
  bool isPaid;
  bool isPaidDriver;

  //this all DateTime for order state in application
  DateTime isLoadingDate;
  DateTime isReceivedDate;
  DateTime isDeliveryDate;
  DateTime isUrgentDate;
  DateTime isCancelldDate;
  DateTime isReturnDate;
  DateTime isDoneDate;
  DateTime isPaidDate;
  DateTime inStockDate;
  DateTime paidDriverDate;

  int indexLine; //this indexing in firebase that will readed orderBy ... indexLine
  int mainLineIndex; //also this :)

  String businesID;
  String driverID;
  String customerID;
  String sublineID;
  String locationID;
  String mainlineID;
  String invoiceDriverID;
  String invoiceID;

  bool isArchived;
  DateTime deleteDate;
  String deleteUser;

  Order({
    this.uid,
    this.price,
    this.totalPrice,
    this.type,
    this.description,
    this.date,
    this.note,
    this.isLoading = true,
    this.isReceived = false,
    this.isDelivery = false,
    this.isUrgent = false,
    this.isCancelld = false,
    this.isReturn = false,
    this.isDone = false,
    this.isPaid = false,
    this.inStock = false,
    this.isPaidDriver = false,
    this.businesID,
    this.driverID = "",
    //this.driverPrice = 0,
    this.indexLine = 0,
    this.mainLineIndex = 0,
    this.mainlineID,
    this.invoiceDriverID = "",
    this.invoiceID = "",
    this.customerID,
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
    this.paidDriverDate,
    this.barcode,
  });
}
