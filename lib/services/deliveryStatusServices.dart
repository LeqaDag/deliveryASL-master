import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/deliveryStatus.dart';

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

  
}
