import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:firebase_database/firebase_database.dart';

class OrderServices {
  final String uid;
  final String businesID;
  final String orderState;
  final String driverID;
  final String locationID;
  final int driverPrice;
  final String invoiceType;
// locationID
  OrderServices(
      {this.uid,
      this.businesID,
      this.orderState,
      this.driverID,
      this.locationID,
      this.driverPrice,
      this.invoiceType});

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
      'isLoadingDate': DateTime.now(),
      'isReceived': order.isReceived,
      'isDelivery': order.isDelivery,
      'isUrgent': order.isUrgent,
      'isCancelld': order.isCancelld,
      'isReturn': order.isReturn,
      'isDone': order.isDone,
      'isPaid': order.isPaid,
      'inStock': order.inStock,
      'customerID': order.customerID,
      'businesID': order.businesID,
      'driverID': order.driverID,
      'isArchived': order.isArchived,
      'sublineID': order.sublineID,
      'locationID': order.locationID,
      'indexLine': order.indexLine,
      'mainLineIndex': order.mainLineIndex,
      'mainlineID': order.mainlineID,
      'invoiceDriverID': order.invoiceDriverID,
      'invoiceID': order.invoiceID,
      'isPaidDriver': order.isPaidDriver,
      'paidDriverDate': order.paidDriverDate,
      'isReceivedDate': order.isReceivedDate,
      'isDeliveryDate': order.isDeliveryDate,
      'isCancelldDate': order.isCancelldDate,
      'isReturnDate': order.isReturnDate,
      'isDoneDate': order.isDoneDate,
      'isPaidDate': order.isPaidDate,
      'inStockDate': order.inStockDate,
      'curentState': order.curentState,
    });
  }

  Future<void> updateOrderStatus(Order order) async {
    return await orderCollection.doc(uid).update({
      'isCancelld': order.isCancelld,
      'isReturn': order.isReturn,
      'isDone': order.isDone,
      'isPaid': order.isPaid,
      'isDelivery': order.isDelivery,
      'isReceived': order.isReceived,
      'price': order.price,
      'totalPrice': order.totalPrice,
      'type': order.type,
      'description': order.description,
      'date': order.date,
      'note': order.note,
      'customerID': order.customerID,
      // 'driverPrice': order.driverPrice,
      'isReturnDate': order.isReturnDate,
      'isDoneDate': order.isDoneDate,
      'isCancelldDate': order.isCancelldDate,
      'isDeliveryDate': order.isDeliveryDate,
      'isReceivedDate': order.isReceivedDate,
      'inStock': order.inStock,
    });
  }


  Future<void> updateOrderData(Order order) async {
    return await orderCollection.doc(uid).update({
      'price': order.price,
      'totalPrice': order.totalPrice,
      'isUrgent': order.isUrgent,
      'description': order.description,
      'note': order.note,
     // 'customerID': order.customerID,
      'businesID': order.businesID,
      'sublineID': order.sublineID,
      'locationID': order.locationID,
      'indexLine': order.indexLine,
      //'mainLineIndex': order.mainLineIndex,
      'mainlineID': order.mainlineID,
    });
  }

  Order _orderDataFromSnapshot(DocumentSnapshot snapshot) {
    return Order(
      uid: snapshot.id,
      price: snapshot.data()['price'],
      totalPrice: snapshot.data()['totalPrice'],
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
      isPaid: snapshot.data()['isPaid'],
      inStock: snapshot.data()['inStock'],
      customerID: snapshot.data()['customerID'],
      businesID: snapshot.data()['businesID'],
      driverID: snapshot.data()['driverID'],
      invoiceDriverID: snapshot.data()['invoiceDriverID'],
      invoiceID: snapshot.data()['invoiceID'],
      isArchived: snapshot.data()['isArchived'],
      sublineID: snapshot.data()['sublineID'],
      locationID: snapshot.data()['locationID'],
      indexLine: snapshot.data()['indexLine'],
      curentState: snapshot.data()['curentState'],
      mainLineIndex: snapshot.data()['mainLineIndex'],
      mainlineID: snapshot.data()['mainlineID'],
      isPaidDriver: snapshot.data()['isPaidDriver'],
      paidDriverDate: snapshot.data()['paidDriverDate'].toDate(),
      isReceivedDate: snapshot.data()['isReceivedDate'].toDate(),
      isDeliveryDate: snapshot.data()['isDeliveryDate'].toDate(),
      isCancelldDate: snapshot.data()['isCancelldDate'].toDate(),
      isReturnDate: snapshot.data()['isReturnDate'].toDate(),
      isDoneDate: snapshot.data()['isDoneDate'].toDate(),
      isPaidDate: snapshot.data()['isPaidDate'].toDate(),
      inStockDate: snapshot.data()['inStockDate'].toDate(),
      isLoadingDate: snapshot.data()['isLoadingDate'].toDate(),
    );
  }

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Order(
        uid: doc.reference.id,
        price: doc.data()['price'] ?? '',
        totalPrice: doc.data()['totalPrice'] ?? '',
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
        isPaid: doc.data()['isPaid'] ?? '',
        inStock: doc.data()['inStock'] ?? '',
        customerID: doc.data()['customerID'] ?? '',
        businesID: doc.data()['businesID'] ?? '',
        driverID: doc.data()['driverID'] ?? '',
        invoiceDriverID: doc.data()['invoiceDriverID'] ?? '',
        invoiceID: doc.data()['invoiceID'] ?? '',
        isArchived: doc.data()['isArchived'] ?? '',
        // driverPrice: doc.data()['driverPrice'] ?? '',
        indexLine: doc.data()['indexLine'] ?? '',
        curentState: doc.data()['curentState'] ?? '',
        mainLineIndex: doc.data()['mainLineIndex'] ?? '',
        locationID: doc.data()['locationID'] ?? '',
        isPaidDriver: doc.data()['isPaidDriver'] ?? '',
        mainlineID: doc.data()['mainlineID'] ?? '',
        isLoadingDate: doc.data()['isLoadingDate'].toDate() ?? '',
        isReceivedDate: doc.data()['isReceivedDate'].toDate() ?? '',
        isDeliveryDate: doc.data()['isDeliveryDate'].toDate() ?? '',
        isCancelldDate: doc.data()['isCancelldDate'].toDate() ?? '',
        isReturnDate: doc.data()['isReturnDate'].toDate() ?? '',
        isDoneDate: doc.data()['isDoneDate'].toDate() ?? '',
        isPaidDate: doc.data()['isPaidDate'].toDate() ?? '',
        inStockDate: doc.data()['inStockDate'].toDate() ?? '',
        paidDriverDate: doc.data()['paidDriverDate'].toDate() ?? '',
      );
    }).toList();
  }

  Stream<Order> get orderData {
    return orderCollection.doc(uid).snapshots().map(_orderDataFromSnapshot);
  }

  Stream<Order> get orderByID {
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
        .where('isPaid', isEqualTo: false)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Future<int> get orderInStock {
    return orderCollection
        .where('inStock', isEqualTo: true)
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
              .where('isPaid', isEqualTo: false)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;

      case 'inStock':
        {
          return orderCollection
              .where('inStock', isEqualTo: true)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isPaid':
        {
          return orderCollection
              .where('isDone', isEqualTo: true)
              .where('isPaid', isEqualTo: true)
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
      case 'inStock':
        {
          return orderCollection
              .where('inStock', isEqualTo: true)
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
              .where('isPaid', isEqualTo: false)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isDone1':
        {
          return orderCollection
              .where('isDone', isEqualTo: true)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isPaid':
        {
          return orderCollection
              .where('isDone', isEqualTo: true)
              .where('isPaid', isEqualTo: true)
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
      // case 'driverOrders':
      //   {
      //     return orderCollection
      //         .where('driverID', isEqualTo: driverID)
      //         .orderBy('mainLineIndex', descending: false)
      //         .orderBy('indexLine', descending: false)
      //         .get()
      //         .asStream()
      //         .map(_orderListFromSnapshot);
      //   }
      //   break;
      case 'driverOrders':
        {
          return orderCollection
              .where('driverID', isEqualTo: driverID)
              .where('isPaid', isEqualTo: false)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'all':
        {
          return orderCollection
              .where('businesID', isEqualTo: businesID)
              // .where('cityID', isEqualTo: "APdWKRxcqyKRgrMteEdU")
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
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
      case 'inStock':
        {
          return orderCollection
              .where('inStock', isEqualTo: true)
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
              .where('isPaid', isEqualTo: false)
              .where('businesID', isEqualTo: businesID)
              .where('isArchived', isEqualTo: false)
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'isPaid':
        {
          return orderCollection
              .where('isDone', isEqualTo: true)
              .where('isPaid', isEqualTo: true)
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

  Future<void> deleteOrderData(String uid, String whoUser) async {
    return await orderCollection.doc(uid).update({
      'isArchived': true,
      'deleteUser': whoUser,
    });
  }

  //Update Order State
  //To is Received  isReceivedDate
  Future<void> get updateOrderToisReceived {
    return orderCollection.doc(uid).update({
      'inStock': false,
      'isReceived': true,
      'isLoading': false,
      'isReceivedDate': DateTime.now(),
    });
  }

  //To is Delivery
  Future<void> get updateOrderToisDelivery {
    return orderCollection.doc(uid).update({
      'inStock': true,
      'isReceived': false,
      'driverID': driverID,
      'inStockDate': DateTime.now(),
    });
  }

  Future<void> get updateOrderFromInStokeToisDelivery {
    return orderCollection.doc(uid).update({
      'inStock': false,
      'isDelivery': true,
      'isDeliveryDate': DateTime.now(),
    });
  }

  //To is Urgent
  Future<void> get updateOrderToisUrgent {
    return orderCollection.doc(uid).update({
      'inStock': true,
      'isReceived': false,
      'isUrgent': true,
      'driverID': driverID,
      'isUrgentDate': DateTime.now(),
    });
  }

  Future<int> get driverPriceData {
    return orderCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['driverPrice']);
  }

  //get Business Orders
  Future<int> countBusinessOrders(String businessID) {
    return orderCollection
        .where('businesID', isEqualTo: businessID)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Future<int> countBusinessDoneOrders(String businessID) {
    return orderCollection
        .where('businesID', isEqualTo: businessID)
        .where('isDone', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Future<int> countBusinessReturnOrders(String businessID) {
    return orderCollection
        .where('businesID', isEqualTo: businessID)
        .where('isReturn', isEqualTo: true)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Stream<List<Order>> businessAllOrders(String businessID) {
    return orderCollection
        .where('businesID', isEqualTo: businessID)
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<Order>> driversAllDoneOrders(String driverID) {
    return orderCollection
        .where('driverID', isEqualTo: driverID)
        .where('isArchived', isEqualTo: false)
        .where('isDone', isEqualTo: true)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<Order>> businessIsDoneOrders(String businessID) {
    return orderCollection
        .where('businesID', isEqualTo: businessID)
        .where('isArchived', isEqualTo: false)
        .where('isDone', isEqualTo: true)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<Order>> driversIsDoneOrders(String driverID) {
    return orderCollection
        .where('driverID', isEqualTo: driverID)
        .where('isArchived', isEqualTo: false)
        .where('isDone', isEqualTo: true)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<Order>> driversAllOrders(String driverID) {
    return orderCollection
        .where('driverID', isEqualTo: driverID)
        .where('isArchived', isEqualTo: false)
        .where('isPaidDriver', isEqualTo: false)
        .where('isDone', isEqualTo: true)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  //daily sheet for driver
  Stream<List<Order>> get sheetList {
    var today = new DateTime.now();
    today = new DateTime(today.year, today.month, today.day);
    return orderCollection
        .where('driverID', isEqualTo: driverID)
        // .where("date", isGreaterThan: today)
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  //daily sheet for driver
  Stream<List<Order>> get sheetListDriver {
    var today = new DateTime.now();
    today = new DateTime(today.year, today.month, today.day);
    return orderCollection
        .where('driverID', isEqualTo: driverID)
        .where('isDone', isEqualTo: true)
        .where('isPaidDriver', isEqualTo: false)
        // .where("date", isGreaterThan: today)
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  // Count orders state isDone for Daily sheet
  Future<int> get countIsDoneInDailySheet {
    return orderCollection
        .where('driverID', isEqualTo: driverID)
        .where('isDone', isEqualTo: true)
        .where('isPaidDriver', isEqualTo: false)
        // .where("date", isGreaterThan: today)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  // Future<int> totalDriverPriceDoneOrders(String driverPrice) {
  //   return orderCollection
  //       .where('driverID', isEqualTo: driverID)
  //       .where('isDone', isEqualTo: true)
  //       .where('isArchived', isEqualTo: false)
  //       .where('driverPrice', isEqualTo: driverPrice)
  //       .get()
  //       .then((value) => value.docs[0]['driverPrice']);
  // }

  // Count orders state isReturn for Daily sheet
  Future<int> get countIsReturnInDailySheet {
    return orderCollection
        .where('driverID', isEqualTo: driverID)
        .where('isReturn', isEqualTo: true)
        // .where("date", isGreaterThan: today)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

// Count orders state isCancelld for Daily sheet
  Future<int> get countIsCancelldInDailySheet {
    return orderCollection
        .where('driverID', isEqualTo: driverID)
        .where('isCancelld', isEqualTo: true)
        // .where("date", isGreaterThan: today)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Future<String> get orderDescription {
    return orderCollection
        .doc(uid)
        .get()
        .then((value) => value.data()['description']);
  }

  // Future<int> totalBusinessPrice(String businessID) {
  //   int totalPrice = 0;
  //   return orderCollection
  //       .where('businesID', isEqualTo: businessID)
  //       .where('isArchived', isEqualTo: false)
  //       .get()
  //       .then((value) => value.forEach((key, val) {
  //           totalPrice+= val.data()['price'];
  //         }));
  // }

  Future<int> countDriverOrderByStateOrder(String orderState) {
    switch (orderState) {
      case 'isLoading':
        {
          return orderCollection
              .where('isLoading', isEqualTo: true)
              .where('driverID', isEqualTo: driverID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isReceived':
        {
          return orderCollection
              .where('isReceived', isEqualTo: true)
              .where('driverID', isEqualTo: driverID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isUrgent':
        {
          return orderCollection
              .where('isUrgent', isEqualTo: true)
              .where('driverID', isEqualTo: driverID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isCancelld':
        {
          return orderCollection
              .where('isCancelld', isEqualTo: true)
              .where('driverID', isEqualTo: driverID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isDelivery':
        {
          return orderCollection
              .where('isDelivery', isEqualTo: true)
              .where('driverID', isEqualTo: driverID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'inStock':
        {
          return orderCollection
              .where('inStock', isEqualTo: true)
              .where('driverID', isEqualTo: driverID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isDone':
        {
          return orderCollection
              .where('isDone', isEqualTo: true)
              .where('driverID', isEqualTo: driverID)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isDone1':
        {
          return orderCollection
              .where('isDone', isEqualTo: true)
              .where('driverID', isEqualTo: driverID)
              .where('isArchived', isEqualTo: false)
              .where('isPaidDriver', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isDoneDriver':
        {
          return orderCollection
              .where('isDone', isEqualTo: true)
              .where('driverID', isEqualTo: driverID)
              .where('isPaidDriver', isEqualTo: false)
              .where('isArchived', isEqualTo: false)
              .get()
              .then((value) => value.size);
        }
        break;
      case 'isReturn':
        {
          return orderCollection
              .where('isReturn', isEqualTo: true)
              .where('driverID', isEqualTo: driverID)
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

  Stream<List<Order>> driverAllOrders(String driverId) {
    return orderCollection
        .where('driverID', isEqualTo: driverId)
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  // use in ato division order
  Stream<List<Order>> get ordersByLocationAndIsReceived {
    return orderCollection
        .where('isReceived', isEqualTo: true)
        .where('locationID', isEqualTo: locationID)
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  //get driver Orders
  Future<int> countDriverOrders(String driverId) {
    return orderCollection
        .where('driverID', isEqualTo: driverId)
        .where('isArchived', isEqualTo: false)
        .get()
        .then((value) => value.size);
  }

  Future<void> get updateDriverPrice {
    return orderCollection.doc(uid).update({'driverPrice': driverPrice});
  }

  void loadingToReceivedBusinessOrders(String businesID) async {
    orderCollection
        .where('businesID', isEqualTo: businesID)
        .where('isArchived', isEqualTo: false)
        .where('isLoading', isEqualTo: true)
        .get()
        .then((value) async {
      List<Order> orders = _orderListFromSnapshot(value);
      for (Order order in orders) {
        await orderCollection.doc(order.uid).update({
          'isLoading': false,
          'isReceived': true,
        });
      }
    });
  }

  Stream<List<Order>> get ordersByInvoiceType {
    switch (invoiceType) {
      case 'order':
        {
          return orderCollection
              .where('isArchived', isEqualTo: false)
              .where('driverID', isNotEqualTo: "")
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'driver':
        {
          return orderCollection
              .where('isArchived', isEqualTo: false)
              .where('driverID', isNotEqualTo: "")
              .snapshots()
              .map(_orderListFromSnapshot);
        }
        break;
      case 'business':
        {
          return orderCollection
              .where('isArchived', isEqualTo: false)
              .where('businesID', isNotEqualTo: "")
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

  Stream<List<Order>> allDoneOrders() {
    return orderCollection
        .where('isArchived', isEqualTo: false)
        .where('isDone', isEqualTo: true)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<Order>> allOrders() {
    return orderCollection
        .where('isArchived', isEqualTo: false)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<Order>> businessAllDoneOrders(String businessID) {
    return orderCollection
        .where('businesID', isEqualTo: businessID)
        .where('isArchived', isEqualTo: false)
        .where('isDone', isEqualTo: true)
        .where('isPaid', isEqualTo: false)
        .snapshots()
        .map(_orderListFromSnapshot);
  }
}
