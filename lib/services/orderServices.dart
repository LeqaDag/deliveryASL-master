import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sajeda_app/classes/order.dart';

class OrderService {
  final String uid;
  final String businesID;
  final String orderState;

  OrderService({this.uid, this.businesID, this.orderState});
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orders');

  Future<void> addOrderData(Order order) async {
    DocumentReference docReference = orderCollection.doc();
    await docReference.set({
      'price': order.price,
      'totalPrice': order.totalPrice,
      'type': order.type,
      'description': order.description,
      'date': order.date,
      'note': order.note,
      'isLoading': order.isLoading,
      'isReceived': order.isReceived,
      'isDelivery': order.isDelivery,
      'isUrgent': order.isUrgent,
      'isCancelld': order.isCancelld,
      'isReturn': order.isReturn,
      'isDone': order.isDone,
      'customerID': order.customerID,
      'businesID': order.businesID,
      'driverID': order.driverID,
      'isArchived': order.isArchived,
    });
  }

  Order _orderDataFromSnapshot(DocumentSnapshot snapshot) {
    return Order(
      uid: snapshot.id,
      price: snapshot.data()['price'],
      totalPrice: snapshot.data()['totalPrice'].cast<int>(),
      type: snapshot.data()['type'],
      description: snapshot.data()['description'],
      date: snapshot.data()['date'].toDate(),
      note: snapshot.data()['note'],
      isLoading: snapshot.data()['isLoading'],
      isReceived: snapshot.data()['isReceived'],
      isDelivery: snapshot.data()['isDelivery'],
      isUrgent: snapshot.data()['isUrgent'],
      isCancelld: snapshot.data()['isCancelld'],
      isReturn: snapshot.data()['isReturn'],
      isDone: snapshot.data()['isDone'],
      customerID: snapshot.data()['customerID'],
      businesID: snapshot.data()['businesID'],
      driverID: snapshot.data()['driverID'],
      isArchived: snapshot.data()['isArchived'],
    );
  }

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Order(
        uid: doc.reference.id,
        price: doc.data()['price'] ?? '',
        totalPrice: doc.data()['totalPrice'].cast<int>() ?? '',
        type: doc.data()['type'] ?? '',
        description: doc.data()['description'] ?? '',
        date: doc.data()['date'].toDate() ?? '',
        note: doc.data()['note'] ?? '',
        isLoading: doc.data()['isLoading'] ?? '',
        isReceived: doc.data()['isReceived'] ?? '',
        isDelivery: doc.data()['isDelivery'] ?? '',
        isUrgent: doc.data()['isUrgent'] ?? '',
        isCancelld: doc.data()['isCancelld'] ?? '',
        isReturn: doc.data()['isReturn'] ?? '',
        isDone: doc.data()['isDone'] ?? '',
        customerID: doc.data()['customerID'] ?? '',
        businesID: doc.data()['businesID'] ?? '',
        driverID: doc.data()['driverID'] ?? '',
        isArchived: doc.data()['isArchived'] ?? '',
      );
    }).toList();
  }

  Stream<Order> get orderData {
    return orderCollection.doc(uid).snapshots().map(_orderDataFromSnapshot);
  }

  Future<int> get orderLoading async {
    return await orderCollection
        .where('isLoading', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Future<int> get orderReceived {
    return orderCollection
        .where('isReceived', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Future<int> get orderUrgent {
    return orderCollection
        .where('isUrgent', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Future<int> get orderCancelld {
    return orderCollection
        .where('isCancelld', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Future<int> get orderDone {
    return orderCollection
        .where('isDone', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Future<int> get orderReturn {
    return orderCollection
        .where('isReturn', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Future<int> get orderDelivery {
    return orderCollection
        .where('isDelivery', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Stream<List<Order>> get orders {
    return orderCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<Order>> businessOrders(String businessID) {
    return orderCollection
        .where('userID', isEqualTo: businessID)
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<Order>> ordersByState(String orderState) {
    switch (orderState) {
      case 'isLoading':
        {
          return orderCollection
              .where('isLoading', isEqualTo: true)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isReceived':
        {
          return orderCollection
              .where('isReceived', isEqualTo: true)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isUrgent':
        {
          return orderCollection
              .where('isUrgent', isEqualTo: true)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isCancelld':
        {
          return orderCollection
              .where('isCancelld', isEqualTo: true)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;

      case 'isDelivery':
        {
          return orderCollection
              .where('isDelivery', isEqualTo: true)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isDone':
        {
          return orderCollection
              .where('isDone', isEqualTo: true)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isReturn':
        {
          return orderCollection
              .where('isReturn', isEqualTo: true)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      default:
        {
          return null;
        }
        break;
    }
  }

//get Count Business Order By State Order
  Future<int> countBusinessOrderByStateOrder(String orderState) {
    switch (orderState) {
      case 'isLoading':
        {
          return orderCollection
              .where('isLoading', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isReceived':
        {
          return orderCollection
              .where('isReceived', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isUrgent':
        {
          return orderCollection
              .where('isUrgent', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isCancelld':
        {
          return orderCollection
              .where('isCancelld', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isDelivery':
        {
          return orderCollection
              .where('isDelivery', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isDone':
        {
          return orderCollection
              .where('isDone', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isReturn':
        {
          return orderCollection
              .where('isReturn', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      default:
        {
          return null;
        }
        break;
    }
  }

  Stream<List<Order>> get ordersBusinessByState {
    switch (orderState) {
      case 'isLoading':
        {
          return orderCollection
              .where('isLoading', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isReceived':
        {
          return orderCollection
              .where('isReceived', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isUrgent':
        {
          return orderCollection
              .where('isUrgent', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isCancelld':
        {
          return orderCollection
              .where('isCancelld', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isDelivery':
        {
          return orderCollection
              .where('isDelivery', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isDone':
        {
          return orderCollection
              .where('isDone', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isReturn':
        {
          return orderCollection
              .where('isReturn', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      default:
        {
          return null;
        }
        break;
    }
  }

  Future<void> deleteOrderData(String uid) async {
    return await orderCollection.doc(uid).update({'isArchived': true});
  }

  Future<void> get updateOrderToisReceived {
    return orderCollection
        .doc(uid)
        .update({'isReceived': true, 'isLoading': false});
  }

  //get Business Orders
  Future<int> countBusinessOrders(String businessID) {
    return orderCollection
        .where('businesID', isEqualTo: businessID)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }
}