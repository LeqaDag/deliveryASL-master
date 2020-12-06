import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AsyadLogistic/classes/location.dart';

class LocationServices {
  final String uid;
  final String name;
  LocationServices({this.uid, this.name});

  final CollectionReference locationCollection =
      FirebaseFirestore.instance.collection('locations');

  Future<void> addLocationData(Location location) async {
    return await locationCollection.doc().set({
      'name': location.name,
      'isArchived': location.isArchived,
    });
  }

  Future<void> updateData(Location location) async {
    return await locationCollection.doc(uid).update({
      'name': location.name,
    });
  }

  Location _locationDataFromSnapshot(DocumentSnapshot snapshot) {
    return Location(
      uid: snapshot.id,
      name: snapshot.data()['name'],
      isArchived: snapshot.data()['isArchived'],
    );
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

  Stream<Location> get locationByID {
    return locationCollection
        .doc(uid)
        .snapshots()
        .map(_locationDataFromSnapshot);
  }

  Stream<List<Location>> get locationIDByName {
    return locationCollection
        .where('name', isEqualTo: name)
        .snapshots()
        .map(_locationListFromSnapshot);
  }

  Stream<List<Location>> get locations {
    return locationCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_locationListFromSnapshot);
  }

  Future<void> deleteLocationData(String uid) async {
    return await locationCollection.doc(uid).update({'isArchived': true});
  }

  Future<String> cityName(String id) {
    return locationCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['name']);
  }
}
