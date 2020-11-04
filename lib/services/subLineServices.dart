import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/subLine.dart';

class SubLineServices {
  final String uid;
  final String mainLineID;

  SubLineServices({this.uid, this.mainLineID});

  final CollectionReference subLineCollection =
      FirebaseFirestore.instance.collection('subLines');

  Future<void> addSubLineData(SubLine subLine) async {
    return await subLineCollection.doc().set({
      'name': subLine.name,
      'indexLine': subLine.indexLine,
      'mainLineID': subLine.mainLineID,
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
      uid: snapshot.id,
      name: snapshot.data()['name'],
      indexLine: snapshot.data()['indexLine'],
      mainLineID: snapshot.data()['mainLineID'],
      isArchived: snapshot.data()['isArchived'],
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
      );
    }).toList();
  }

  Stream<SubLine> get subLineByID {
    return subLineCollection.doc(uid).snapshots().map(_subLineDataFromSnapshot);
  }

  Stream<List<SubLine>> get subLines {
    return subLineCollection
        .where('isArchived', isEqualTo: false)
        .where('mainLineID', isEqualTo: mainLineID)
        .snapshots()
        .map(_subLineListFromSnapshot);
  }

  Future<void> deletesubLineData(String uid) async {
    return await subLineCollection.doc(uid).update({'isArchived': true});
  }
}
