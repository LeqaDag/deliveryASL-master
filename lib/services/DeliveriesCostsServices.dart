import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AsyadLogistic/classes/deliveriesCost.dart';

class DeliveriesCostsServices {
  final String uid, businessId;
  DeliveriesCostsServices({this.uid, this.businessId});

  final CollectionReference deliveryCostCollection =
      FirebaseFirestore.instance.collection('delivery_costs');

  Future<void> addDeliveryCostData(DeliveriesCosts deliveryCost) async {
    return await deliveryCostCollection.doc().set({
      'deliveryPrice': deliveryCost.deliveryPrice,
      'adminID': deliveryCost.adminID,
      'locationID': deliveryCost.locationID,
      'businesID': deliveryCost.businesID,
      'isArchived': deliveryCost.isArchived,
      'locationName': deliveryCost.locationName
    });
  }

  Future<void> updateData(DeliveriesCosts deliveryCost) async {
    return await deliveryCostCollection.
    doc(uid).update({
      'deliveryPrice': deliveryCost.deliveryPrice,
    });
  }

  DeliveriesCosts _deliveryCostDataFromSnapshot(DocumentSnapshot snapshot) {
    return DeliveriesCosts(
        uid: snapshot.id,
        deliveryPrice: snapshot.data()['deliveryPrice'],
        note: snapshot.data()['note'],
        adminID: snapshot.data()['adminID'],
        locationID: snapshot.data()['locationID'],
        businesID: snapshot.data()['businesID'],
        isArchived: snapshot.data()['isArchived'],
        locationName: snapshot.data()['locationName']);
  }

  List<DeliveriesCosts> _deliveryCostListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DeliveriesCosts(
          uid: doc.reference.id,
          deliveryPrice: doc.data()['deliveryPrice'] ?? '',
          note: doc.data()['note'] ?? '',
          adminID: doc.data()['adminID'] ?? '',
          locationID: doc.data()['locationID'] ?? '',
          businesID: doc.data()['businesID'] ?? '',
          isArchived: doc.data()['isArchived'] ?? '',
          locationName: doc.data()['locationName'] ?? '');
    }).toList();
  }

  Stream<DeliveriesCosts> get deliveryCostByID {
    return deliveryCostCollection
        .doc(uid)
        .snapshots()
        .map(_deliveryCostDataFromSnapshot);
  }

  Stream<List<DeliveriesCosts>> get deliveryCosts {
    return deliveryCostCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_deliveryCostListFromSnapshot);
  }

  Stream<List<DeliveriesCosts>> get deliveryCostsBusiness {
    return deliveryCostCollection
        .where('isArchived', isEqualTo: false)
        .where('businesID', isEqualTo: businessId)
        .snapshots()
        .map(_deliveryCostListFromSnapshot);
  }

  Future<void> deleteDeliveryCostData(String uid) async {
    return await deliveryCostCollection.doc(uid).update({'isArchived': true});
  }

  Future<String> get locatinName {
    return deliveryCostCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['locationName']);
  }

  Future<String> get deliveryPrice {
    return deliveryCostCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['deliveryPrice']);
  }
}
