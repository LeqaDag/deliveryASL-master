import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/invoice.dart';

class InvoiceService {
  final String uid, businessId;
  InvoiceService({this.uid, this.businessId});

  final CollectionReference invoiceCollection =
      FirebaseFirestore.instance.collection('invoice');

  Future<void> addInvoiceData(Invoice invoice) async {
    return await invoiceCollection.doc().set({
      'adminID': invoice.adminID,
      'businessID': invoice.businessID,
      'note': invoice.note,
      'paidPrice': invoice.paidPrice,
      'totalPrice': invoice.totalPrice,
    });
  }

  Future<void> updateData(Invoice invoice) async {
    return await invoiceCollection.doc(uid).update({
      'adminID': invoice.adminID,
      'businessID': invoice.businessID,
      'note': invoice.note,
      'paidPrice': invoice.paidPrice,
      'totalPrice': invoice.totalPrice,
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
        .where("isArchived", isEqualTo: false)
        .where("businessID", isEqualTo: businessId)
        .snapshots()
        .map(_invoiceListFromSnapshot);
  }

  
}
