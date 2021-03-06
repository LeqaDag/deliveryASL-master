import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AsyadLogistic/classes/driver.dart';

class DriverServices {
  final String uid;
  final String mainLineID;
  final String locationID;
  final int driverBonus;
  DriverServices({
    this.uid,
    this.mainLineID,
    this.locationID,
    this.driverBonus,
  });

  final CollectionReference deiverCollection =
      FirebaseFirestore.instance.collection('drivers');

  Future<void> addDriverData(Driver driver) async {
    return await deiverCollection.doc(driver.uid).set({
      'name': driver.name,
      'type': driver.type,
      'email': driver.email,
      'phoneNumber': driver.phoneNumber,
      'locationID': driver.locationID,
      'cityID': driver.cityID,
      'address': driver.address,
      'bonus': driver.bonus,
      'load': driver.load,
      'pLoad': driver.pLoad,
      'isArchived': driver.isArchived
    });
  }

  Future<void> updateData(Driver driver) async {
    return await deiverCollection.doc(uid).update({
      'name': driver.name,
      'type': driver.type,
      'email': driver.email,
      'phoneNumber': driver.phoneNumber,
      'locationID': driver.locationID,
      'cityID': driver.cityID,
      'address': driver.address,
      'bonus': driver.bonus,
      'load': driver.load,
      'pLoad': driver.pLoad,
    });
  }

  Driver _driverDataFromSnapshot(DocumentSnapshot snapshot) {
    return Driver(
      uid: snapshot.id,
      name: snapshot.data()['name'],
      type: snapshot.data()['type'],
      email: snapshot.data()['email'],
      locationID: snapshot.data()['locationID'],
      phoneNumber: snapshot.data()['phoneNumber'],
      cityID: snapshot.data()['cityID'],
      address: snapshot.data()['address'],
      bonus: snapshot.data()['bonus'],
      load: snapshot.data()['load'],
      pLoad: snapshot.data()['pLoad'],
    );
  }

  List<Driver> _driverListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Driver(
        uid: doc.reference.id,
        name: doc.data()['name'] ?? '',
        type: doc.data()['type'] ?? '',
        email: doc.data()['email'] ?? '',
        locationID: doc.data()['locationID'] ?? '',
        phoneNumber: doc.data()['phoneNumber'] ?? '',
        cityID: doc.data()['cityID'] ?? '',
        address: doc.data()['address'] ?? '',
        bonus: doc.data()['bonus'] ?? '',
        load: doc.data()['load'] ?? '',
        pLoad: doc.data()['pLoad'] ?? '',
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

  Future<String> get driverName {
    return deiverCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['name']);
  }

  Future<String> get driverPhone {
    return deiverCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['phoneNumber']);
  }

  Stream<List<Driver>> get driversBymainLineID {
    return deiverCollection
        .where('locationID', isEqualTo: mainLineID)
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_driverListFromSnapshot);
  }

  Stream<List<Driver>> get driversBylocationID {
    return deiverCollection
        .where('locationID', isEqualTo: locationID)
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

  Future<void> updateDataPaidSalary(Driver driver) async {
    return await deiverCollection.doc(uid).update({
      'paidDate': driver.paidDate,
      'paidSalary': driver.paidSalary,
    });
  }

  Future<int> get driverBonusData {
    return deiverCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['bonus']);
  }
}
