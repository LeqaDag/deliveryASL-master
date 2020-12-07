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

  void autoDivision() async {
    await countOrder();
              print('locationwwww');

    int orderReceivedCount = orderCount;
    StreamBuilder<List<Location>>(
        stream: LocationServices().locations,
        builder: (context, snapshot) {
              print('locationrrDDDDrr ');

          // all Locations
          if (snapshot.hasData) {
            List<Location> locations = snapshot.data;
              print(locations);

            locations.asMap().forEach((locationIndex, location) async {
              await countByLocation(location.uid);
              print('locationrrrr ');

              if (orderReceivedCount != 0 && countOrderByLocation != 0) {
                return StreamBuilder<List<Driver>>(
                    stream: DriverServices(locationID: location.uid)
                        .driversBylocationID,
                    builder: (context, snapshot) {
                      // all Drivers By Location
                      if (snapshot.hasData) {
                        List<Driver> drivers = snapshot.data;
                        drivers.asMap().forEach((driverIndex, driver) {
                          if (countOrderByLocation != 0 &&
                              driver.pLoad <= driver.load) {
                            int availableLoad = driver.load - driver.pLoad;
                            if (countOrderByLocation >= availableLoad) {
                              for (var i = 0; i < availableLoad; i++) {
                                return StreamBuilder<List<Order>>(
                                    stream:
                                        OrderServices(locationID: location.uid)
                                            .ordersByLocationAndIsReceived,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<Order> orders = snapshot.data;
                                        orders
                                            .asMap()
                                            .forEach((orderIndex, order) async {
                                          await orderCollection
                                              .doc(order.uid)
                                              .update({
                                            'inStock': true,
                                            'isReceived': false,
                                            'driverID': driver.uid,
                                            'inStockDate': DateTime.now(),
                                          });
                                          await deiverCollection
                                              .doc(driver.uid)
                                              .update({
                                            'pLoad': driver.pLoad + 1,
                                          });
                                        });
                                      } else {}
                                    });
                              }
                            } else {}
                          } else {}
                        });
                      } else {}
                    });
              } else {}
            });
          } else {}
        });
  }
}
