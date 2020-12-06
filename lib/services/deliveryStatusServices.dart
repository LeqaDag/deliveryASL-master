import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AsyadLogistic/classes/deliveryStatus.dart';

class DeliveriesStatusServices {
  final String uid, orderID, driverID;
  DeliveriesStatusServices({this.uid, this.driverID, this.orderID});

  final CollectionReference deliveryStatusCollection =
      FirebaseFirestore.instance.collection('delivery_status');

  Future<void> addDeliveryStatusData(DeliveryStatus deliveryStatus) async {
    return await deliveryStatusCollection.doc().set({
      'status': deliveryStatus.status,
      'businessID': deliveryStatus.businessID,
      'note': deliveryStatus.note,
      'orderID': deliveryStatus.orderID,
      'driverID': deliveryStatus.driverID,
      'isArchived': deliveryStatus.isArchived,
      'date': deliveryStatus.date,
    });
  }

  // DeliveryStatus _deliveryStatusDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return DeliveryStatus(
  //     uid: snapshot.id,
  //     status: snapshot.data()['status'],
  //     businessID: snapshot.data()['businessID'],
  //     note: snapshot.data()['note'],
  //     orderID: snapshot.data()['orderID'],
  //     driverID: snapshot.data()['driverID'],
  //     isArchived: snapshot.data()['isArchived'],
  //     date: snapshot.data()['date'].toDate(),
  //   );
  // }

  List<DeliveryStatus> _deliveryStatusListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DeliveryStatus(
        uid: doc.reference.id,
        status: doc.data()['status'] ?? '',
        businessID: doc.data()['businessID'] ?? '',
        note: doc.data()['note'] ?? '',
        orderID: doc.data()['orderID'] ?? '',
        driverID: doc.data()['driverID'] ?? '',
        isArchived: doc.data()['isArchived'] ?? '',
        date: doc.data()['date'].toDate() ?? '',
      );
    }).toList();
  }

  Stream<List<DeliveryStatus>> get deliveryStatusData {
    return deliveryStatusCollection
        .where('orderID', isEqualTo: orderID)
        .snapshots()
        .map(_deliveryStatusListFromSnapshot);
  }
}
