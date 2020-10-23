import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/customer.dart';

class CustomerService {
  final String uid;
  CustomerService({this.uid});
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customers');

  Future<String> addcustomerData(Customer customer) async {
    DocumentReference docReference = customerCollection.doc();
    await docReference.set({
      'name': customer.name,
      'phoneNumber': customer.phoneNumber,
      'phoneNumberAdditional': customer.phoneNumberAdditional,
      'cityID': customer.cityID,
      'address': customer.address,
      'businesID': customer.businesID,
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
    );
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
      );
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

  Stream<List<Customer>> get customers {
    return customerCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_customerListFromSnapshot);
  }

  Future<void> deleteUserData(String uid) async {
    return await customerCollection.doc(uid).update({'isArchived': true});
  }
}
