import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/city.dart';

class CityServices {
  final String uid;
  final String name;
  final String mainLineID;
  CityServices({this.uid, this.name,this.mainLineID});

  final CollectionReference cityCollection =
      FirebaseFirestore.instance.collection('cities');

  Future<void> addCityData(City city) async {
    return await cityCollection.doc().set({
      'name': city.name,
      'isArchived': city.isArchived,
      'mainLineID': city.mainLineID,
    });
  }

  Future<void> updateData(City city) async {
    return await cityCollection.doc(uid).update({
      'name': city.name,
    });
  }

  
  Future<void> updateMainLine(String mainLineID) async {
    return await cityCollection.doc(uid).update({
      'mainLineID': mainLineID,
    });
  }

  City _cityDataFromSnapshot(DocumentSnapshot snapshot) {
    return City(
      uid: snapshot.id,
      name: snapshot.data()['name'],
      isArchived: snapshot.data()['isArchived'],
    );
  }

  List<City> _cityListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return City(
        uid: doc.reference.id,
        name: doc.data()['name'] ?? '',
        isArchived: doc.data()['isArchived'] ?? '',
        mainLineID: doc.data()['mainLineID'] ?? '',
      );
    }).toList();
  }

  Stream<City> get cityByID {
    return cityCollection.doc(uid).snapshots().map(_cityDataFromSnapshot);
  }

  Stream<List<City>> get cityIDByName {
    return cityCollection
        .where('name', isEqualTo: name)
        .snapshots()
        .map(_cityListFromSnapshot);
  }

  Stream<List<City>> get citys {
    return cityCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_cityListFromSnapshot);
  }

  Stream<List<City>> get citiesByMainLineID {
    return cityCollection
        .where('isArchived', isEqualTo: false)
        .where('mainLineID', isEqualTo: mainLineID)
        .snapshots()
        .map(_cityListFromSnapshot);
  }

  Stream<List<City>> get citysf {
    return cityCollection
        .where('isArchived', isEqualTo: false)
        .get()
        .asStream()
        .map(_cityListFromSnapshot);
  }

  Future<void> deletecityData(String uid) async {
    return await cityCollection.doc(uid).update({'isArchived': true});
  }

  Future<String> get cityName {
    return cityCollection.doc(uid).get().then((value) => value.data()['name']);
  }
}
