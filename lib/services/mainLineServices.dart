import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/mainLine.dart';

class MainLineServices {
  final String uid;
  final String cityID;
  MainLineServices({this.uid, this.cityID});

  final CollectionReference mainLineCollection =
      FirebaseFirestore.instance.collection('mainLines');

  Future<String> addMainLineData(MainLine mainLine) async {
    DocumentReference docReference = mainLineCollection.doc();

    await docReference.set({
      'name': mainLine.name,
      'cityID': mainLine.cityID,
      'isArchived': mainLine.isArchived,
    });

    return docReference.id;
  }

  Future<void> updateData(MainLine mainLine) async {
    return await mainLineCollection.doc(uid).update({
      'name': mainLine.name,
      'cityID': mainLine.cityID,
    });
  }

  MainLine _mainLineDataFromSnapshot(DocumentSnapshot snapshot) {
    return MainLine(
      uid: snapshot.id,
      name: snapshot.data()['name'],
      cityID: snapshot.data()['cityID'],
      isArchived: snapshot.data()['isArchived'],
    );
  }

  List<MainLine> _mainLineListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MainLine(
        uid: doc.reference.id,
        name: doc.data()['name'] ?? '',
        cityID: doc.data()['cityID'] ?? '',
        isArchived: doc.data()['isArchived'] ?? '',
      );
    }).toList();
  }

  Stream<MainLine> get mainLineByID {
    return mainLineCollection
        .doc(uid)
        .snapshots()
        .map(_mainLineDataFromSnapshot);
  }
 
 Stream<List<MainLine>> get mainLineByCityID {
    return mainLineCollection
        .where('cityID', isEqualTo: cityID)
        .snapshots()
        .map(_mainLineListFromSnapshot);
  }

  Stream<List<MainLine>> get mainLines {
    return mainLineCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_mainLineListFromSnapshot);
  }

  Future<void> deleteMainLineData(String uid) async {
    return await mainLineCollection.doc(uid).update({'isArchived': true});
  }
}
