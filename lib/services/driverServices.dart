import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/driver.dart';

class DriverServices {
  final String uid;
  final String mainLineID;
  DriverServices({this.uid, this.mainLineID});

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
      'load': driver.load
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

  Stream<List<Driver>> get driversBymainLineID {
    return deiverCollection
        .where('locationID', isEqualTo: mainLineID)
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
