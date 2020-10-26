import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/subLine.dart';

class SubLineServices {
  final String uid;
  SubLineServices({this.uid});

  final CollectionReference subLineCollection =
      FirebaseFirestore.instance.collection('subLines');

  Future<void> addSubLineData(SubLine subLine) async {
    return await subLineCollection.doc().set({
      'name': subLine.name,
      'index': subLine.index,
      'mainLineID': subLine.mainLineID,
      'cityID': subLine.cityID,
      'isArchived': subLine.isArchived,
    });
  }

  Future<void> updateData(SubLine subLine) async {
    return await subLineCollection.doc(uid).update({
      'name': subLine.name,
    });
  }

  SubLine _subLineDataFromSnapshot(DocumentSnapshot snapshot) {
    return SubLine(
      name: snapshot.data()['name'],
      index: snapshot.data()['index'],
      mainLineID: snapshot.data()['mainLineID'],
      cityID: snapshot.data()['cityID'],
      isArchived: snapshot.data()['isArchived'],
    );
  }

  List<SubLine> _subLineListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SubLine(
        uid: doc.reference.id,
        name: doc.data()['name'] ?? '',
        index: doc.data()['index'] ?? '',
        mainLineID: doc.data()['mainLineID'] ?? '',
        cityID: doc.data()['cityID'] ?? '',
        isArchived: doc.data()['isArchived'] ?? '',
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

  Future<void> deletesubLineData(String uid) async {
    return await subLineCollection.doc(uid).update({'isArchived': true});
  }
}
