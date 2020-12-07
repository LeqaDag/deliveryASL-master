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
  int countOrder() {
    int orderCount;
    orderCollection
        .where('isReceived', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) {
      orderCount = value.size;
    });
    return orderCount;
  }

  int countByLocation(String locationID) {
    int countOrder;
    orderCollection
        .where('locationID', isEqualTo: locationID)
        .where('isReceived', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) {
      countOrder = value.size;
    });
    return countOrder;
  }

  void autoDivision() {
    int orderReceivedCount = countOrder();

    StreamBuilder<List<Location>>(
        stream: LocationServices().locations,
        builder: (context, snapshot) {
          // all Locations
          if (snapshot.hasData) {
            List<Location> locations = snapshot.data;
            locations.asMap().forEach((locationIndex, location) {
              int countOrderByLocation = countByLocation(location.uid);
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
                                            .forEach((orderIndex, order) {
                                          orderCollection
                                              .doc(order.uid)
                                              .update({
                                            'inStock': true,
                                            'isReceived': false,
                                            'driverID': driver.uid,
                                            'inStockDate': DateTime.now(),
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
