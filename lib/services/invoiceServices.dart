import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AsyadLogistic/classes/invoice.dart';

class InvoiceServices {
  final String uid, businessId, driverId;
  InvoiceServices({this.uid, this.businessId, this.driverId});

  final CollectionReference invoiceCollection =
      FirebaseFirestore.instance.collection('invoices');

  Future<void> addInvoiceData(Invoice invoice) async {
    return await invoiceCollection.doc().set({
      'adminID': invoice.adminID,
      'businessID': invoice.businessID,
      'note': invoice.note,
      'paidPrice': invoice.paidPrice,
      'totalPrice': invoice.totalPrice,
      'driverID': invoice.driverID,
      'totalPriceDriver': invoice.totalPriceDriver,
      'paidPriceDriver': invoice.paidPriceDriver,
    });
  }

  Future<void> updateData(Invoice invoice) async {
    return await invoiceCollection.doc(uid).update({
      'adminID': invoice.adminID,
      'businessID': invoice.businessID,
      'note': invoice.note,
      'paidPrice': invoice.paidPrice,
      'totalPrice': invoice.totalPrice,
      'driverID': invoice.driverID,
      'totalPriceDriver': invoice.totalPriceDriver,
      'paidPriceDriver': invoice.paidPriceDriver,
    });
  }

  Invoice _invoiceDataFromSnapshot(DocumentSnapshot snapshot) {
    return Invoice(
      uid: snapshot.id,
      adminID: snapshot.data()['adminID'],
      businessID: snapshot.data()['businessID'],
      note: snapshot.data()['note'],
      paidPrice: snapshot.data()['paidPrice'],
      totalPrice: snapshot.data()['totalPrice'],
      driverID: snapshot.data()['driverID'],
      totalPriceDriver: snapshot.data()['totalPriceDriver'],
      paidPriceDriver: snapshot.data()['paidPriceDriver'],
    );
  }

  List<Invoice> _invoiceListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Invoice(
        uid: doc.reference.id,
        adminID: doc.data()['adminID'] ?? '',
        businessID: doc.data()['businessID'] ?? '',
        note: doc.data()['note'] ?? '',
        paidPrice: doc.data()['paidPrice'] ?? '',
        totalPrice: doc.data()['totalPrice'] ?? '',
        driverID: doc.data()['driverID'] ?? '',
        totalPriceDriver: doc.data()['totalPriceDriver'] ?? '',
        paidPriceDriver: doc.data()['paidPriceDriver'] ?? '',
      );
    }).toList();
  }

  Stream<Invoice> get invoiceByID {
    return invoiceCollection.doc(uid).snapshots().map(_invoiceDataFromSnapshot);
  }

  Stream<List<Invoice>> get invoices {
    return invoiceCollection
        .where("isArchived", isEqualTo: false)
        .snapshots()
        .map(_invoiceListFromSnapshot);
  }

  Future<void> deleteInvoiceData(String uid) async {
    return await invoiceCollection.doc(uid).update({'isArchived': true});
  }

  Stream<List<Invoice>> get totalPrice {
    return invoiceCollection
        .where("businessID", isEqualTo: businessId)
        .snapshots()
        .map(_invoiceListFromSnapshot);
  }

  Future<int> total(String businessId) {
    return invoiceCollection
        .where("businessID", isEqualTo: businessId)
        .get()
        .then((value) => value.docs[0]["totalPrice"]);
  }

  Future<int> totalPriceDriver(String driverId) {
    return invoiceCollection
        .where("driverID", isEqualTo: driverId)
        .get()
        .then((value) => value.docs[0]["totalPriceDriver"]);
  }

  Future<int> paidPrice(String businessId) {
    return invoiceCollection
        .where("businessID", isEqualTo: businessId)
        .get()
        .then((value) => value.docs[0]["paidPrice"]);
  }
}
