import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../classes/subLine.dart';

class SubLineServices {
  final String uid;
  final String mainLineID, cityID;

  SubLineServices({this.uid, this.mainLineID, this.cityID});

  final CollectionReference subLineCollection =
      FirebaseFirestore.instance.collection('subLines');

  Future<void> addSubLineData(SubLine subLine) async {
    return await subLineCollection.doc().set({
      'name': subLine.name,
      'indexLine': subLine.indexLine,
      'mainLineID': subLine.mainLineID,
      'isArchived': subLine.isArchived,
      'cityID': subLine.cityID,
    });
  }

  Future<void> updateData(SubLine subLine) async {
    return await subLineCollection.doc(uid).update({
      'name': subLine.name,
      'cityID': subLine.cityID,
    });
  }

  SubLine _subLineDataFromSnapshot(DocumentSnapshot snapshot) {
    return SubLine(
      uid: snapshot.id,
      name: snapshot.data()['name'],
      indexLine: snapshot.data()['indexLine'],
      mainLineID: snapshot.data()['mainLineID'],
      isArchived: snapshot.data()['isArchived'],
      cityID: snapshot.data()['cityID'],
    );
  }

  List<SubLine> _subLineListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SubLine(
        uid: doc.reference.id,
        name: doc.data()['name'] ?? '',
        indexLine: doc.data()['indexLine'] ?? '',
        mainLineID: doc.data()['mainLineID'] ?? '',
        isArchived: doc.data()['isArchived'] ?? '',
        cityID: doc.data()['cityID'] ?? '',
      );
    }).toList();
  }

  Stream<SubLine> get subLineByID {
    return subLineCollection.doc(uid).snapshots().map(_subLineDataFromSnapshot);
  }

  Stream<List<SubLine>> get subLines {
    return subLineCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_subLineListFromSnapshot);
  }

  Stream<List<SubLine>> get subLines1 {
    return subLineCollection
        .where('isArchived', isEqualTo: false)
        .where('mainLineID', isEqualTo: mainLineID)
        .snapshots()
        .map(_subLineListFromSnapshot);
  }

  Future<void> deletesubLineData(String uid) async {
    return await subLineCollection.doc(uid).update({'isArchived': true});
  }

  Stream<List<SubLine>> get subLinesCustomers {
    return subLineCollection
        .where('isArchived', isEqualTo: false)
        .where('cityID', isEqualTo: cityID)
        .snapshots()
        .map(_subLineListFromSnapshot);
  }

  Future<int> get maxIndex {
    return subLineCollection
        .where('isArchived', isEqualTo: false)
        .where('mainLineID', isEqualTo: mainLineID)
        .get()
        .then((value) {
      return value.docs.map<int>((e) => e['indexLine']).reduce(max);
    });
  }

  Stream<List<SubLine>> get subLinesByMainLineID {
    return subLineCollection
        .where('isArchived', isEqualTo: false)
        .where('mainLineID', isEqualTo: mainLineID)
        .snapshots()
        .map(_subLineListFromSnapshot);
  }

  Future<int> get sublineIndex {
    return subLineCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['indexLine']);
  }

  Future<String> get sublineName {
    return subLineCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['name']);
  }
}
// value.data()['indexLine'].reduce(max);
