import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/customer.dart';

class CustomerServices {
  final String uid;
  String cityId;

  CustomerServices({this.uid, this.cityId});
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customers');

  final CollectionReference cityCollection =
      FirebaseFirestore.instance.collection('citys');

  Future<String> addcustomerData(Customer customer) async {
    DocumentReference docReference = customerCollection.doc();
    await docReference.set({
      'name': customer.name,
      'phoneNumber': customer.phoneNumber,
      'phoneNumberAdditional': customer.phoneNumberAdditional,
      'cityID': customer.cityID,
      'address': customer.address,
      'businesID': customer.businesID,
      'cityName': customer.cityName,
      'isArchived': customer.isArchived,
    });
    return docReference.id;
  }

  Customer _customerDataFromSnapshot(DocumentSnapshot snapshot) {
    return Customer(
        uid: snapshot.id,
        name: snapshot.data()['name'],
        phoneNumber: snapshot.data()['phoneNumber'],
        phoneNumberAdditional: snapshot.data()['phoneNumberAdditional'],
        cityID: snapshot.data()['cityID'],
        address: snapshot.data()['address'],
        businesID: snapshot.data()['businesID'],
        isArchived: snapshot.data()['isArchived'],
        cityName: snapshot.data()['cityName']);
  }

  List<Customer> _customerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Customer(
          uid: doc.reference.id,
          name: doc.data()['name'] ?? '',
          phoneNumber: doc.data()['phoneNumber'] ?? '',
          phoneNumberAdditional: doc.data()['phoneNumberAdditional'] ?? '',
          cityID: doc.data()['cityID'] ?? '',
          address: doc.data()['address'] ?? '',
          businesID: doc.data()['businesID'] ?? '',
          isArchived: doc.data()['isArchived'] ?? '',
          cityName: doc.data()['cityName'] ?? '');
    }).toList();
  }

  Stream<Customer> get customerData {
    return customerCollection
        .doc(uid)
        .snapshots()
        .map(_customerDataFromSnapshot);
  }

  Future<String> get customerName {
    return customerCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['name']);
  }

  Future<int> get customerPhoneNumber {
    return customerCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['phoneNumber']);
  }

  Future<int> get customerAdditionalPhoneNumber {
    return customerCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['phoneNumberAdditional']);
  }

  Future<String> get customerAdress {
    return customerCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['address']);
  }

  Future<String> get customerCity {
    return customerCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['cityName']);
  }

  Stream<List<Customer>> get customers {
    return customerCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_customerListFromSnapshot);
  }

  Future<void> deleteUserData(String uid) async {
    return await customerCollection.doc(uid).update({'isArchived': true});
  }

  // Future<String> get customerCity {
  //   return customerCollection
  //       .doc(uid)
  //       .get()
  //       .then((value) => cityId = value.data()['cityName']);
  //   // print(cityId);
  //   // return cityCollection
  //   //     .doc(cityId)
  //   //     .get()
  //   //     .then((value) => value.data()['name']);
  // }

  Stream<Customer> get customerByID {
    return customerCollection
        .doc(uid)
        .snapshots()
        .map(_customerDataFromSnapshot);
  }
}
