import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/user.dart';

class UserService {
  final String uid;
  UserService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUserData(Users user) async {
    return await userCollection.doc().set({
      'name': user.name,
      'userType': user.usertype,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'userID': user.userID,
    });
  }

  Future<void> updateUserData(Users user) async {
    return await userCollection.doc(uid).update({
      'name': user.name,
      'userType': user.usertype,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'userID': user.userID,
    });
  }

  Users _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Users(
      uid: snapshot.id,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      phoneNumber: snapshot.data()['phoneNumber'],
      usertype: snapshot.data()['userType'],
      userID: snapshot.data()['userID'],
    );
  }

  List<Users> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Users(
        uid: doc.reference.id,
        name: doc.data()['name'] ?? '',
        usertype: doc.data()['userType'] ?? '',
        email: doc.data()['email'] ?? '',
        phoneNumber: doc.data()['phoneNumber'] ?? '',
        userID: doc.data()['userID'] ?? '',
      );
    }).toList();
  }

  Stream<Users> get userByID {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }


  Stream<List<Users>> get users {
    return userCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_userListFromSnapshot);
  }

  Future<void> deleteUserData(String uid) async {
    return await userCollection.doc(uid).update({'isArchived': true});
  }
}
