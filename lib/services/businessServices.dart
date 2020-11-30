import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/business.dart';

class BusinessServices {
  final String uid;
  BusinessServices({this.uid});

  final CollectionReference businessCollection =
      FirebaseFirestore.instance.collection('business');

  Future<void> addBusinessData(Business business) async {
    return await businessCollection.doc().set({
      'name': business.name,
      'email': business.email,
      'phoneNumber': business.phoneNumber,
      'userID': business.userID,
    });
  }

  Future<void> updateData(Business business) async {
    return await businessCollection.doc(uid).update({
      'name': business.name,
      'email': business.email,
      'phoneNumber': business.phoneNumber,
      'userID': business.userID,
    });
  }

  Business _businessDataFromSnapshot(DocumentSnapshot snapshot) {
    return Business(
      uid: snapshot.id,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      phoneNumber: snapshot.data()['phoneNumber'],
      userID: snapshot.data()['userID'],
    );
  }

  List<Business> _businessListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Business(
        uid: doc.reference.id,
        name: doc.data()['name'] ?? '',
        email: doc.data()['email'] ?? '',
        phoneNumber: doc.data()['phoneNumber'] ?? '',
        userID: doc.data()['userID'] ?? '',
      );
    }).toList();
  }

  Stream<Business> get businessByID {
    return businessCollection
        .doc(uid)
        .snapshots()
        .map(_businessDataFromSnapshot);
  }

  Stream<List<Business>> get business {
    return businessCollection
        .where("isArchived", isEqualTo: false)
        .snapshots()
        .map(_businessListFromSnapshot);
  }

  Future<String> get businessName {
    return businessCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['name']);
  }

  Future<void> deleteBusinessData(String uid, String whoUser) async {
    return await businessCollection.doc(uid).update({
      'isArchived': true,
      'deleteUser': whoUser,
    });
  }

  Future<String> get businessPhoneNumber {
    return businessCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['phoneNumber']);
  }

  Future<String> businessID(String businessId) {
    return businessCollection
        .where("userID", isEqualTo: businessId)
        .get()
        .then((value) => value.docs[0].id);
  }
}
