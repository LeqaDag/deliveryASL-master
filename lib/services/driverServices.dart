import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/driver.dart';

class DriverService {
  final String uid;
  DriverService({this.uid});

  final CollectionReference deiverCollection =
      FirebaseFirestore.instance.collection('drivers');

  Future<void> addDriverData(Driver driver) async {
    return await deiverCollection.doc().set({
      'name': driver.name,
      'type': driver.type,
      'email': driver.email,
      'phoneNumber': driver.phoneNumber,
      'line': driver.line,
      'cityID': driver.cityID,
      'passowrd': driver.passowrd,
      'address': driver.address,
    });
  }

  Future<void> updateData(Driver driver) async {
    return await deiverCollection.doc(uid).update({
      'name': driver.name,
      'type': driver.type,
      'email': driver.email,
      'phoneNumber': driver.phoneNumber,
      'line': driver.line,
      'cityID': driver.cityID,
      'passowrd': driver.passowrd,
      'address': driver.address,
    });
  }

  Driver _driverDataFromSnapshot(DocumentSnapshot snapshot) {
    return Driver(
      uid: snapshot.id,
      name: snapshot.data()['name'],
      type: snapshot.data()['type'],
      email: snapshot.data()['email'],
      line: snapshot.data()['line'],
      phoneNumber: snapshot.data()['phoneNumber'],
      passowrd: snapshot.data()['passowrd'],
      cityID: snapshot.data()['cityID'],
      address: snapshot.data()['address'],
    );
  }

  List<Driver> _driverListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Driver(
        uid: doc.reference.id,
        name: doc.data()['name'] ?? '',
        type: doc.data()['type'] ?? '',
        email: doc.data()['email'] ?? '',
        line: doc.data()['line'] ?? '',
        phoneNumber: doc.data()['phoneNumber'] ?? '',
        passowrd: doc.data()['passowrd'] ?? '',
        cityID: doc.data()['cityID'] ?? '',
        address: doc.data()['address'] ?? '',
      );
    }).toList();
  }

  Stream<Driver> get driverByID {
    return deiverCollection.doc(uid).snapshots().map(_driverDataFromSnapshot);
  }

  // Stream<List<Driver>>get driverByuserID(String userId)  {
  //   return deiverCollection
  //       .where('userID', isEqualTo: userId)
  //       .snapshots()
  //       .map(_driverListFromSnapshot);
  // }

  Stream<List<Driver>> get drivers {
    return deiverCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_driverListFromSnapshot);
  }

  Stream<List<Driver>> get driverByuserID {
    return deiverCollection
        .where('userID', isEqualTo: uid)
        .snapshots()
        .map(_driverListFromSnapshot);
  }

  Future<void> deleteDriverData(String uid) async {
    return await deiverCollection.doc(uid).update({'isArchived': true});
  }
}
