import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/driverDeliveryCost.dart';

class DriverDeliveryCostServices {
  final String uid, driverId;
  DriverDeliveryCostServices({this.uid, this.driverId});

  final CollectionReference driverDeliveryCostCollection =
      FirebaseFirestore.instance.collection('driver_delivery_costs');

  Future<void> addDriverDeliveryCostData(
      DriverDeliveryCost driverDeliveryCost) async {
    return await driverDeliveryCostCollection.doc().set({
      'cost': driverDeliveryCost.cost,
      'driverID': driverDeliveryCost.driverID,
      'locationID': driverDeliveryCost.locationID,
      'isArchived': driverDeliveryCost.isArchived,
    });
  }

  DriverDeliveryCost _driverDeliveryCostDataFromSnapshot(
      DocumentSnapshot snapshot) {
    return DriverDeliveryCost(
        uid: snapshot.id,
        cost: snapshot.data()['cost'],
        locationID: snapshot.data()['locationID'],
        driverID: snapshot.data()['driverID'],
        isArchived: snapshot.data()['isArchived']);
  }

  List<DriverDeliveryCost> _deliveryCostListFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DriverDeliveryCost(
          uid: doc.reference.id,
          cost: doc.data()['cost'] ?? '',
          locationID: doc.data()['locationID'] ?? '',
          driverID: doc.data()['driverID'] ?? '',
          isArchived: doc.data()['isArchived'] ?? '');
    }).toList();
  }

  Stream<DriverDeliveryCost> get driverDeliveryCostByID {
    return driverDeliveryCostCollection
        .doc(uid)
        .snapshots()
        .map(_driverDeliveryCostDataFromSnapshot);
  }

  Stream<List<DriverDeliveryCost>> get driverDeliveryCosts {
    return driverDeliveryCostCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_deliveryCostListFromSnapshot);
  }

  Future<void> deleteDriverDeliveryCostData(String uid) async {
    return await driverDeliveryCostCollection
        .doc(uid)
        .update({'isArchived': true});
  }

  Future<int> driverPriceData(String driverId) {
    return driverDeliveryCostCollection
        .where('driverID', isEqualTo: driverId)
        .get()
        .then((value) => value.docs[0]['cost']);
  }

Future<String> driverDeliveryCostId(String driverId) {
    return driverDeliveryCostCollection
        .where('driverID', isEqualTo: driverId)
        .get()
        .then((value) => value.docs[0].id);
  }

  Future<void> updateData(DriverDeliveryCost driverDeliveryCost) async {
    return await driverDeliveryCostCollection.doc(uid).update({
      'cost': driverDeliveryCost.cost,
    });
  }

  Future<int> get driverDeliveryCost {
    return driverDeliveryCostCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['cost']);
  }
}
