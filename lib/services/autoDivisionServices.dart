import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/classes/order.dart';

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
          totalPrice: doc.data()['totalPrice'] ?? '',
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
         // driverPrice: doc.data()['driverPrice'] ?? '',
          indexLine: doc.data()['indexLine'] ?? '',
          mainLineIndex: doc.data()['mainLineIndex'] ?? '',
          locationID: doc.data()['locationID'] ?? '',
          isPaidDriver: doc.data()['isPaidDriver'] ?? '',
          mainlineID: doc.data()['mainlineID'] ?? '',
          sublineID: doc.data()['sublineID'] ?? '');
    }).toList();
  }

  void autoDivision() async {
    await countOrder();

    int orderReceivedCount = orderCount;

    locationCollection
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) async {
      List<Location> locations = _locationListFromSnapshot(value);
      for (Location location in locations) {
        await countByLocation(location.uid);
        if (orderReceivedCount != 0) {
          deiverCollection
              .where('locationID', isEqualTo: location.uid)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) async {
            List<Driver> drivers = _driverListFromSnapshot(value).toList();
            for (Driver driver in drivers) {
              int availableLoad = driver.load - driver.pLoad;

              if (driver.pLoad < driver.load) {
                for (var i = 0; i < availableLoad; i++) {
                  print(availableLoad);
                  await orderCollection
                      .where('isReceived', isEqualTo: true)
                      .where('locationID', isEqualTo: location.uid)
                      .where('isArchived', isEqualTo: false)
                      // .limit(availableLoad)
                      .get()
                      .then((value) async {
                    List<Order> orders = _orderListFromSnapshot(value);
                    orders = orders.take(availableLoad).toList();
                    print(orders);
                    for (Order order in orders) {
                      if (driver.pLoad < driver.load) {
                        await orderCollection.doc(order.uid).update({
                          'inStock': true,
                          'isReceived': false,
                          'driverID': driver.uid,
                          'inStockDate': DateTime.now(),
                        });
                        await deiverCollection.doc(driver.uid).update({
                          'pLoad': (driver.pLoad++),
                        });
                      }
                      // else if (driver.pLoad < driver.load) {
                      //   await deiverCollection.doc(driver.uid).update({
                      //     'pLoad': (driver.pLoad++),
                      //   });
                      // }
                      //  else if (driver.pLoad == driver.load) {
                      //   await deiverCollection.doc(driver.uid).update({
                      //     'pLoad': (driver.pLoad++),
                      //   });
                      // } else {}
                    }
                  });
                  if (driver.pLoad < driver.load) {
                    await deiverCollection.doc(driver.uid).update({
                      'pLoad': driver.pLoad +1,
                    });
                  } else if (driver.pLoad <= driver.load) {
                    await deiverCollection.doc(driver.uid).update({
                      'pLoad': ((driver.pLoad + 1) - 1),
                    });
                  }
                  await countOrder();
                }
              }
            }
          });
        } else {}
      }
    });
  }

  void returnOrder() async {
    orderCollection.get().then((value) {
      List<Order> orders = _orderListFromSnapshot(value);
      orders.asMap().forEach((orderIndex, order) async {
        await orderCollection.doc(order.uid).update({
          'inStock': false,
          'isReceived': true,
          'driverID': "",
        });
      });
    });
  }
}
