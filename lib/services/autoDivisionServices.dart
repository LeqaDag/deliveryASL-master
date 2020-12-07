import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';

class AutoDivisiovServices {
  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection('locations');

  final CollectionReference deiverCollection =
      FirebaseFirestore.instance.collection('drivers');

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orders');

  final CollectionReference mainLineCollection =
      FirebaseFirestore.instance.collection('mainLines');

  final CollectionReference subLineCollection =
      FirebaseFirestore.instance.collection('subLines');
  int orderCount = 0;
  int countOrderByLocation = 0;
  Future<void> countOrder() async {
    await orderCollection
        .where('isReceived', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) {
      orderCount = value.size;
    });
  }

  Future<void> countByLocation(String locationID) async {
    await orderCollection
        .where('locationID', isEqualTo: locationID)
        .where('isReceived', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) {
      countOrderByLocation = value.size;
    });
  }

  List<Location> _locationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Location(
        uid: doc.reference.id,
        name: doc.data()['name'] ?? '',
        isArchived: doc.data()['isArchived'] ?? '',
      );
    }).toList();
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

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Order(
          uid: doc.reference.id,
          price: doc.data()['price'] ?? '',
          totalPrice: doc.data()['totalPrice'].cast<int>() ?? '',
          type: doc.data()['type'] ?? '',
          description: doc.data()['description'] ?? '',
          date: doc.data()['date'].toDate() ?? '',
          note: doc.data()['note'] ?? '',
          isLoading: doc.data()['isLoading'] ?? '',
          isReceived: doc.data()['isReceived'] ?? '',
          isDelivery: doc.data()['isDelivery'] ?? '',
          isUrgent: doc.data()['isUrgent'] ?? '',
          isCancelld: doc.data()['isCancelld'] ?? '',
          isReturn: doc.data()['isReturn'] ?? '',
          isDone: doc.data()['isDone'] ?? '',
          isPaid: doc.data()['isPaid'] ?? '',
          inStock: doc.data()['inStock'] ?? '',
          customerID: doc.data()['customerID'] ?? '',
          businesID: doc.data()['businesID'] ?? '',
          driverID: doc.data()['driverID'] ?? '',
          isArchived: doc.data()['isArchived'] ?? '',
          driverPrice: doc.data()['driverPrice'] ?? '',
          indexLine: doc.data()['indexLine'] ?? '',
          locationID: doc.data()['locationID'] ?? '',
          sublineID: doc.data()['sublineID'] ?? '');
    }).toList();
  }

  void autoDivision() async {
    await countOrder();
    print('locationwwww');

    int orderReceivedCount = orderCount;
    print(orderReceivedCount);

    locationCollection
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) {
      print('locationrrDDDDrr ');
      List<Location> locations = _locationListFromSnapshot(value);
      print(locations);
      locations.asMap().forEach((locationIndex, location) async {
        await countByLocation(location.uid);
        print(location.uid);
        if (orderReceivedCount != 0) {
          deiverCollection
              .where('locationID', isEqualTo: location.uid)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) {
            List<Driver> drivers = _driverListFromSnapshot(value);
            // print(drivers);

            drivers.asMap().forEach((driverIndex, driver) async {
              if ( driver.pLoad <= driver.load) {
                int availableLoad = driver.load - driver.pLoad;
                print(driver.load - driver.pLoad);

                if (availableLoad != 0) {
                  for (var i = 0; i < orderCount; i++) {
                  print('locationrrDDDDrسسسسrييي ');
                    orderCollection
                        .where('isReceived', isEqualTo: true)
                        .where('locationID', isEqualTo: location.uid)
                        .where('isArchived', isEqualTo: false)
                        .get()
                        .then((value) {
                      List<Order> orders = _orderListFromSnapshot(value);
                      orders.asMap().forEach((orderIndex, order) async {
                        await orderCollection.doc(order.uid).update({
                          'inStock': true,
                          'isReceived': false,
                          'driverID': driver.uid,
                          'inStockDate': DateTime.now(),
                        });
                        await deiverCollection.doc(driver.uid).update({
                          'pLoad': driver.pLoad + 1,
                        });
                      });
                    });
                    await countOrder();
                  }
                } else {}
              } else {}
            });
          });
        } else {}
      });
    });
  }
}
