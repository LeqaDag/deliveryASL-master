class Invoice {
  String uid;
  String adminID;
  String businessID;
  String note;
  int paidPrice;
  int totalPrice;
  String driverID;
  int paidPriceDriver;
  int totalPriceDriver;

  bool isArchived;
  DateTime deleteDate;

  Invoice(
      {this.uid,
      this.adminID,
      this.businessID,
      this.paidPrice,
      this.note,
      this.totalPrice,
      this.isArchived = false,
      this.deleteDate,
      this.driverID,
      this.paidPriceDriver,
      this.totalPriceDriver});
}
