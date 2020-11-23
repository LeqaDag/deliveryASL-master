import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/admin.dart';

class AdminService {
  final String uid;
  AdminService({this.uid});

  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection('admin');

  Future<void> addAdminData(Admin admin) async {
    return await adminCollection.doc().set({
      'name': admin.name,
      'email': admin.email,
      'phoneNumber': admin.phoneNumber,
      'userID': admin.userID,
      'type': admin.type,
      'isArchived': admin.isArchived
    });
  }

  Future<void> updateData(Admin admin) async {
    return await adminCollection.doc(uid).update({
      'name': admin.name,
      'email': admin.email,
      'phoneNumber': admin.phoneNumber,
      'userID': admin.userID,
      'type': admin.type,
      'isArchived': admin.isArchived
    });
  }

  Admin _adminDataFromSnapshot(DocumentSnapshot snapshot) {
    return Admin(
      uid: snapshot.id,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      phoneNumber: snapshot.data()['phoneNumber'],
      userID: snapshot.data()['userID'],
      type: snapshot.data()['type'],
      isArchived: snapshot.data()['isArchived'],
    );
  }

  List<Admin> _adminListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Admin(
        uid: doc.reference.id,
        name: doc.data()['name'] ?? '',
        email: doc.data()['email'] ?? '',
        phoneNumber: doc.data()['phoneNumber'] ?? '',
        userID: doc.data()['userID'] ?? '',
        type: doc.data()['type'] ?? '',
        isArchived: doc.data()['isArchived'] ?? '',
      );
    }).toList();
  }

  Stream<Admin> get adminByID {
    return adminCollection.doc(uid).snapshots().map(_adminDataFromSnapshot);
  }

  Stream<List<Admin>> get admins {
    return adminCollection
        .where("isArchived", isEqualTo: false)
        .snapshots()
        .map(_adminListFromSnapshot);
  }

  Future<String> get adminName {
    return adminCollection.doc(uid).get().then((value) => value.data()['name']);
  }

  Future<void> deleteAdminData(String uid) async {
    return await adminCollection.doc(uid).update({'isArchived': true});
  }

  Future<String> get adminType {
    return adminCollection.doc(uid).get().then((value) => value.data()['type']);
  }
}
