import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/deliveriesCost.dart';

class DeliveriesCostsServices {
  final String uid;
  DeliveriesCostsServices({this.uid});

  final CollectionReference deliveryCostCollection =
      FirebaseFirestore.instance.collection('deliveries_costs');

  Future<void> addDeliveryCostData(DeliveriesCosts deliveryCost) async {
    return await deliveryCostCollection.doc().set({
      'deliveryPrice': deliveryCost.deliveryPrice,
      'note': deliveryCost.note,
      'adminID': deliveryCost.adminID,
      'city': deliveryCost.city,
      'businesID': deliveryCost.businesID,
      'isArchived': deliveryCost.isArchived,
    });
  }

  // Future<void> updateData(DeliveriesCosts subLine) async {
  //   return await deliveryCostCollection.doc(uid).update({
  //
  //   });
  // }

  DeliveriesCosts _deliveryCostDataFromSnapshot(DocumentSnapshot snapshot) {
    return DeliveriesCosts(
      uid: snapshot.id,
      deliveryPrice: snapshot.data()['deliveryPrice'],
      note: snapshot.data()['note'],
      adminID: snapshot.data()['adminID'],
      city: snapshot.data()['city'],
      businesID: snapshot.data()['businesID'],
      isArchived: snapshot.data()['isArchived'],
    );
  }

  List<DeliveriesCosts> _deliveryCostListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DeliveriesCosts(
        uid: doc.reference.id,
        deliveryPrice: doc.data()['deliveryPrice'] ?? '',
        note: doc.data()['note'] ?? '',
        adminID: doc.data()['adminID'] ?? '',
        city: doc.data()['city'] ?? '',
        businesID: doc.data()['businesID'] ?? '',
        isArchived: doc.data()['isArchived'] ?? '',
      );
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

  Future<void> deleteDeliveryCostData(String uid) async {
    return await deliveryCostCollection.doc(uid).update({'isArchived': true});
  }
}
