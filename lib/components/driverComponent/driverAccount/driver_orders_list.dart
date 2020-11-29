// import 'package:sajeda_app/classes/order.dart';
// import 'package:sajeda_app/services/customerServices.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart' as intl;
// import 'orders_details.dart';

// class DriverOrderList extends StatefulWidget {
//   final String name, uid;
//   DriverOrderList({this.name, this.uid});

//   @override
//   _DriverOrderListState createState() => _DriverOrderListState();
// }

// class _DriverOrderListState extends State<DriverOrderList> {
//   @override
//   Widget build(BuildContext context) {
//     final pendingOrders = Provider.of<List<Order>>(context).where((order) {
//           return order.driverID == widget.uid;
//         }).toList() ??
//         [];
//     final doneOrders = Provider.of<List<Order>>(context).where((order) {
//           return order.isDone == true;
//         }).toList() ??
//         [];
//     final stuckOrders = Provider.of<List<Order>>(context).where((order) {
//           return order.isReturn == true;
//         }).toList() ??
//         [];
//     return TabBarView(children: [
//       ListView.builder(
//         itemCount: pendingOrders.length,
//         itemBuilder: (context, index) {
//           return CustomDriverOrders(
//               order: pendingOrders[index],
//               orderState: "pending",
//               name: widget.name,
//               uid: widget.uid);
//         },
//       ),
//       ListView.builder(
//         itemCount: doneOrders.length,
//         itemBuilder: (context, index) {
//           return CustomDriverOrders(
//               order: doneOrders[index],
//               orderState: "done",
//               name: widget.name,
//               uid: widget.uid);
//         },
//       ),
//       ListView.builder(
//         itemCount: stuckOrders.length,
//         itemBuilder: (context, index) {
//           return CustomDriverOrders(
//               order: stuckOrders[index],
//               orderState: "stuck",
//               name: widget.name,
//               uid: widget.uid);
//         },
//       ),
//     ]);
//   }
// }

// class CustomDriverOrders extends StatefulWidget {
//   final Order order;
//   final String orderState, name, uid;

//   CustomDriverOrders({this.order, this.orderState, this.name, this.uid});

//   @override
//   _CustomDriverOrdersState createState() => _CustomDriverOrdersState();
// }

// class _CustomDriverOrdersState extends State<CustomDriverOrders> {
//   Color color;

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     Color color;
//     if (widget.orderState == "done")
//       color = Colors.greenAccent;
//     else
//       color = Colors.white;

//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => OrderDetails(
//                   name: widget.name,
//                   orderState: widget.orderState,
//                   uid: widget.order.uid)),
//         );
//       },
//       child: Container(
//           width: width - 50,
//           height: 100,
//           child: Card(
//             color: color,
//             elevation: 4,
//             margin: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 11.0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(0.0),
//             ),
//             //color: KCustomCompanyOrdersStatus,
//             child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <
//                 Widget>[
//               Container(
//                 width: width / 2,
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Row(
//                         //3
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: height * 0.025,
//                               right: height * 0.025,
//                               top: height * 0,
//                             ),
//                             child: Icon(
//                               Icons.person,
//                               color: Colors.blueGrey,
//                             ),
//                           ),
//                           FutureBuilder<String>(
//                               future:
//                                   CustomerService(uid: widget.order.customerID)
//                                       .customerName,
//                               builder: (context, snapshot) {
//                                 return Text(
//                                   snapshot.data ?? "",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: "Amiri",
//                                   ),
//                                 );
//                               }),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: height * 0.025,
//                               right: height * 0.025,
//                               top: height * 0,
//                             ),
//                             child: Icon(
//                               Icons.date_range,
//                               color: Colors.blueGrey,
//                             ),
//                           ),
//                           Text(
//                             intl.DateFormat('yyyy-MM-dd')
//                                 .format(widget.order.date),
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: "Amiri",
//                             ),
//                           ),
//                         ],
//                       ),
//                     ]),
//               ),
//               Container(
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: height * 0.025,
//                               right: height * 0.025,
//                               top: height * 0,
//                             ),
//                             child: Icon(
//                               Icons.location_on,
//                               color: Colors.blueGrey,
//                             ),
//                           ),
//                           FutureBuilder<String>(
//                               future:
//                                   CustomerService(uid: widget.order.customerID)
//                                       .customerCity,
//                               builder: (context, snapshot) {
//                                 return Text(
//                                   snapshot.data ?? "",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: "Amiri",
//                                   ),
//                                 );
//                               }),
//                           FutureBuilder<String>(
//                               future:
//                                   CustomerService(uid: widget.order.customerID)
//                                       .customerAdress,
//                               builder: (context, snapshot) {
//                                 return Text(
//                                   ' - ${snapshot.data}' ?? "",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: "Amiri",
//                                   ),
//                                 );
//                               }),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: height * 0.025,
//                               right: height * 0.025,
//                               top: height * 0,
//                             ),
//                             child: Image.asset('assets/price.png'),
//                           ),
//                           Text(
//                             widget.order.price.toString(),
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: "Amiri",
//                             ),
//                           ),
//                         ],
//                       ),
//                     ]),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//             ]),
//           )),
//     );
//   }
// }

import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/services/customerServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import 'orders_details.dart';

class DriverOrderList extends StatefulWidget {
  final String name, uid;
  DriverOrderList({this.name, this.uid});

  @override
  _DriverOrderListState createState() => _DriverOrderListState();
}

class _DriverOrderListState extends State<DriverOrderList> {
  @override
  Widget build(BuildContext context) {
    final pendingOrders = Provider.of<List<Order>>(context) ?? [];
    final doneOrders = Provider.of<List<Order>>(context) ?? [];
    final stuckOrders = Provider.of<List<Order>>(context) ?? [];
    return TabBarView(children: [
      ListView.builder(
        itemCount: pendingOrders.length,
        itemBuilder: (context, index) {
          return PendingDriverOrders(
              order: pendingOrders[index],
              orderState: "pending",
              name: widget.name,
              uid: widget.uid);
        },
      ),
      ListView.builder(
        itemCount: doneOrders.length,
        itemBuilder: (context, index) {
          return DoneDriverOrders(
              order: doneOrders[index],
              orderState: "done",
              name: widget.name,
              uid: widget.uid);
        },
      ),
      ListView.builder(
        itemCount: stuckOrders.length,
        itemBuilder: (context, index) {
          return StuckDriverOrders(
              order: stuckOrders[index],
              orderState: "stuck",
              name: widget.name,
              uid: widget.uid);
        },
      ),
    ]);
  }
}

class PendingDriverOrders extends StatefulWidget {
  final Order order;
  final String orderState, name, uid;

  PendingDriverOrders({this.order, this.orderState, this.name, this.uid});

  @override
  _PendingDriverOrdersState createState() => _PendingDriverOrdersState();
}

class _PendingDriverOrdersState extends State<PendingDriverOrders> {
  Color color;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color color;
    if (widget.orderState == "done")
      color = Colors.greenAccent;
    else
      color = Colors.white;
    if (widget.order.isDelivery == false) {
      return Visibility(
        child: Text("Gone"),
        visible: false,
      );
    } else if (widget.order.isDelivery == true &&
        widget.order.driverID == widget.uid) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetails(
                    name: widget.name,
                    orderState: widget.orderState,
                    uid: widget.order.uid)),
          );
        },
        child: Container(
            width: width - 50,
            height: 100,
            child: Card(
              color: color,
              elevation: 4,
              margin: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 11.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              //color: KCustomCompanyOrdersStatus,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width / 2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              //3
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                FutureBuilder<String>(
                                    future: CustomerService(
                                            uid: widget.order.customerID)
                                        .customerName,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri",
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Icon(
                                    Icons.date_range,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Text(
                                  intl.DateFormat('yyyy-MM-dd')
                                      .format(widget.order.date),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                FutureBuilder<String>(
                                    future: CustomerService(
                                            uid: widget.order.customerID)
                                        .customerCity,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri",
                                        ),
                                      );
                                    }),
                                FutureBuilder<String>(
                                    future: CustomerService(
                                            uid: widget.order.customerID)
                                        .customerAdress,
                                    builder: (context, snapshot) {
                                      return Text(
                                        ' - ${snapshot.data}' ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri",
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Image.asset('assets/price.png'),
                                ),
                                Text(
                                  widget.order.price.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ]),
            )),
      );
    } else {
      return Visibility(
        child: Text("Gone"),
        visible: false,
      );
    }
  }
}

class DoneDriverOrders extends StatefulWidget {
  final Order order;
  final String orderState, name, uid;

  DoneDriverOrders({this.order, this.orderState, this.name, this.uid});

  @override
  _DoneDriverOrdersState createState() => _DoneDriverOrdersState();
}

class _DoneDriverOrdersState extends State<DoneDriverOrders> {
  Color color;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color color;
    if (widget.orderState == "done")
      color = Colors.greenAccent;
    else
      color = Colors.white;
    if (widget.order.isDone == false) {
      return Visibility(
        child: Text("Gone"),
        visible: false,
      );
    } else if (widget.order.isDone == true &&
        widget.order.driverID == widget.uid) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetails(
                    name: widget.name,
                    orderState: widget.orderState,
                    uid: widget.order.uid)),
          );
        },
        child: Container(
            width: width - 50,
            height: 100,
            child: Card(
              color: color,
              elevation: 4,
              margin: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 11.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              //color: KCustomCompanyOrdersStatus,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width / 2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              //3
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                FutureBuilder<String>(
                                    future: CustomerService(
                                            uid: widget.order.customerID)
                                        .customerName,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri",
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Icon(
                                    Icons.date_range,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Text(
                                  intl.DateFormat('yyyy-MM-dd')
                                      .format(widget.order.date),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                FutureBuilder<String>(
                                    future: CustomerService(
                                            uid: widget.order.customerID)
                                        .customerCity,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri",
                                        ),
                                      );
                                    }),
                                FutureBuilder<String>(
                                    future: CustomerService(
                                            uid: widget.order.customerID)
                                        .customerAdress,
                                    builder: (context, snapshot) {
                                      return Text(
                                        ' - ${snapshot.data}' ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri",
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Image.asset('assets/price.png'),
                                ),
                                Text(
                                  widget.order.price.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ]),
            )),
      );
    } else {
      return Visibility(
        child: Text("Gone"),
        visible: false,
      );
    }
  }
}

class StuckDriverOrders extends StatefulWidget {
  final Order order;
  final String orderState, name, uid;

  StuckDriverOrders({this.order, this.orderState, this.name, this.uid});

  @override
  _StuckDriverOrdersState createState() => _StuckDriverOrdersState();
}

class _StuckDriverOrdersState extends State<StuckDriverOrders> {
  Color color;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color color;
    if (widget.orderState == "done")
      color = Colors.greenAccent;
    else
      color = Colors.white;
    if (widget.order.isReturn == false) {
      return Visibility(
        child: Text("Gone"),
        visible: false,
      );
    } else if (widget.order.isReturn == true &&
        widget.order.driverID == widget.uid) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetails(
                    name: widget.name,
                    orderState: widget.orderState,
                    uid: widget.order.uid)),
          );
        },
        child: Container(
            width: width - 50,
            height: 100,
            child: Card(
              color: color,
              elevation: 4,
              margin: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 11.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              //color: KCustomCompanyOrdersStatus,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width / 2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              //3
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                FutureBuilder<String>(
                                    future: CustomerService(
                                            uid: widget.order.customerID)
                                        .customerName,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri",
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Icon(
                                    Icons.date_range,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Text(
                                  intl.DateFormat('yyyy-MM-dd')
                                      .format(widget.order.date),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                FutureBuilder<String>(
                                    future: CustomerService(
                                            uid: widget.order.customerID)
                                        .customerCity,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri",
                                        ),
                                      );
                                    }),
                                FutureBuilder<String>(
                                    future: CustomerService(
                                            uid: widget.order.customerID)
                                        .customerAdress,
                                    builder: (context, snapshot) {
                                      return Text(
                                        ' - ${snapshot.data}' ?? "",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri",
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                  ),
                                  child: Image.asset('assets/price.png'),
                                ),
                                Text(
                                  widget.order.price.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ]),
            )),
      );
    } else {
      return Visibility(
        child: Text("Gone"),
        visible: false,
      );
    }
  }
}
