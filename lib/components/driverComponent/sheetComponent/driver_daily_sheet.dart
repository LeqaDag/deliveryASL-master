import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/pages/driver_drawer.dart';
import 'package:sajeda_app/services/businessServices.dart';
import 'package:sajeda_app/services/customerServices.dart';
import 'package:sajeda_app/services/driverDeliveryCostServices.dart';
import 'package:sajeda_app/services/driverServices.dart';
import 'package:sajeda_app/services/orderServices.dart';
import 'package:intl/intl.dart' as intl;

import '../../../constants.dart';

class DriverDailySheet extends StatefulWidget {
  final String driverID, name;
  DriverDailySheet({this.driverID, this.name});
  @override
  _DriverDailySheetState createState() => _DriverDailySheetState();
}

class _DriverDailySheetState extends State<DriverDailySheet> {
  TextEditingController doneController = new TextEditingController();
  TextEditingController returnController = new TextEditingController();
  TextEditingController totalController = new TextEditingController();
  TextEditingController driverPriceController = new TextEditingController();
  String doneOrders;
  List<Order> orders;
  int isDoneOrders = 0, totalSalary = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Driver>(
        stream: DriverServices(uid: widget.driverID).driverByID,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Driver driverData = snapshot.data;
            return Scaffold(
              endDrawer: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DriverDrawer(
                    name: widget.name,
                  )),
              appBar: AppBar(
                title: Text(
                  driverData.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Amiri',
                  ),
                ),
                backgroundColor: kAppBarColor,
                centerTitle: true,
              ),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 8),
                                child: Text(
                                  "عدد الطورد الواصلة",
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: 18.0,
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 10,
                              ),
                              child: FutureBuilder<int>(
                                  future:
                                      OrderServices(driverID: driverData.uid)
                                          .countIsDoneInDailySheet,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      doneController.text =
                                          snapshot.data.toString();
                                      return TextFormField(
                                        controller: doneController,
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return TextFormField(
                                        initialValue: "0",
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, right: 6),
                                child: Text(
                                  "عدد الطرود الراجعة",
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: 18.0,
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 8),
                              child: FutureBuilder<int>(
                                  future:
                                      OrderServices(driverID: driverData.uid)
                                          .countIsReturnInDailySheet,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      returnController.text =
                                          snapshot.data.toString();
                                      return TextFormField(
                                        controller: returnController,
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return TextFormField(
                                        initialValue: "0",
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 8),
                                child: Text(
                                  "المبلغ الكلي",
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: 18.0,
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 8),
                              child: StreamBuilder<List<Order>>(
                                  stream: OrderServices()
                                      .driversAllOrders(driverData.uid),
                                  builder: (context, snapshot) {
                                    int totalPrice = 0;

                                    if (!snapshot.hasData) {
                                      totalController.text = "0";
                                      return TextFormField(
                                        controller: totalController,
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      orders = snapshot.data;
                                      orders.forEach((element) {
                                        totalPrice += element.totalPrice[0];
                                        totalController.text =
                                            totalPrice.toString();
                                      });
                                      return TextFormField(
                                        controller: totalController,
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, right: 6),
                                child: Text(
                                  "الراتب اليومي",
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: 18.0,
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 8),
                              child: FutureBuilder<int>(
                                  future: OrderServices(
                                          driverID: driverData.uid)
                                      .countDriverOrderByStateOrder("isDone"),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      isDoneOrders = snapshot.data;

                                      return FutureBuilder<int>(
                                          future: DriverDeliveryCostServices(
                                                  driverId: driverData.uid)
                                              .driverPriceData(driverData.uid),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              totalSalary =
                                                  snapshot.data * isDoneOrders;
                                              driverPriceController.text =
                                                  totalSalary.toString();
                                              print(snapshot.data);
                                              //  isDoneOrders = snapshot.data;
                                              return TextFormField(
                                                controller:
                                                    driverPriceController,
                                                decoration: InputDecoration(
                                                  enabled: false,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          right: 10.0,
                                                          left: 10.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 4,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return TextFormField(
                                                initialValue: "0",
                                                decoration: InputDecoration(
                                                  enabled: false,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          right: 10.0,
                                                          left: 10.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 4,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                    } else {
                                      return Text("");
                                    }
                                  }),

                              // StreamBuilder<List<Order>>(
                              //     stream: OrderServices()
                              //         .driversAllOrders(driverData.uid),
                              //     builder: (context, snapshot) {
                              //       int totalPrice = 0;

                              //       if (!snapshot.hasData) {
                              //         return TextFormField(
                              //           initialValue: "0",
                              //           decoration: InputDecoration(
                              //             enabled: false,
                              //             contentPadding: EdgeInsets.only(
                              //                 right: 10.0, left: 10.0),
                              //             border: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(10),
                              //               borderSide: BorderSide(
                              //                 color: Colors.black,
                              //                 width: 4,
                              //               ),
                              //             ),
                              //           ),
                              //         );
                              //       } else {
                              //         orders = snapshot.data;
                              //         orders.forEach((element) {
                              //           totalPrice += element.driverPrice;
                              //           driverPriceController.text =
                              //               totalPrice.toString();
                              //         });
                              //         return TextFormField(
                              //           controller: driverPriceController,
                              //           decoration: InputDecoration(
                              //             enabled: false,
                              //             contentPadding: EdgeInsets.only(
                              //                 right: 10.0, left: 10.0),
                              //             border: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(10),
                              //               borderSide: BorderSide(
                              //                 color: Colors.black,
                              //                 width: 4,
                              //               ),
                              //             ),
                              //           ),
                              //         );
                              //       }
                              //     }),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: StreamProvider<List<Order>>.value(
                          value: OrderServices(driverID: widget.driverID)
                              .sheetListDriver,
                          child: SheetListDriver(
                              name: widget.name, driverID: widget.driverID),
                          catchError: (_, __) => null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                child: Image.asset("assets/EmptyOrder.png"),
              ),
            );
          }
        });
  }
}

class SheetListDriver extends StatefulWidget {
  final String name, driverID;
  SheetListDriver({this.name, this.driverID});

  @override
  _SheetListDriverState createState() => _SheetListDriverState();
}

class _SheetListDriverState extends State<SheetListDriver> {
  @override
  Widget build(BuildContext context) {
    //final orders = Provider.of<List<Order>>(context) ?? [];
    final orders = Provider.of<List<Order>>(context).where((order) {
          return order.driverID == widget.driverID;
        }).toList() ??
        [];

    if (orders != [] && orders != null) {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: orders.length,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return AllDriverOrders(
              order: orders[index], name: widget.name, uid: widget.driverID);
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
    } else {
      return Center(
        child: Container(
          child: Image.asset("assets/EmptyOrder.png"),
        ),
      );
    }
  }
}

class AllDriverOrders extends StatefulWidget {
  final Order order;
  final String name, uid;

  AllDriverOrders({this.order, this.name, this.uid});

  @override
  _AllDriverOrdersState createState() => _AllDriverOrdersState();
}

class _AllDriverOrdersState extends State<AllDriverOrders> {
  Color color;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color color;

    IconData icon;
    String stateOrder;
    Color colorIcon;

    if (widget.order.isCancelld == true) {
      colorIcon = KBadgeColorAndContainerBorderColorCancelledOrders;
      icon = Icons.cancel;
      stateOrder = "ملغي";
    } else if (widget.order.isDelivery == true) {
      colorIcon = KAllOrdersListTileColor;
      icon = Icons.business_center_outlined;
      stateOrder = "جاهز للتوزيع";
    } else if (widget.order.isDone == true) {
      colorIcon = KBadgeColorAndContainerBorderColorReadyOrders;
      icon = Icons.done;
      stateOrder = "جاهز";
    } else if (widget.order.isLoading == true) {
      colorIcon = KBadgeColorAndContainerBorderColorLoadingOrder;
      icon = Icons.arrow_circle_up_rounded;
      stateOrder = "محمل";
    } else if (widget.order.isUrgent == true) {
      colorIcon = KBadgeColorAndContainerBorderColorUrgentOrders;
      icon = Icons.info_outline;
      stateOrder = "مستعجل";
    } else if (widget.order.isReturn == true) {
      colorIcon = KBadgeColorAndContainerBorderColorReturnOrders;
      icon = Icons.restore;
      stateOrder = "راجع";
    } else if (widget.order.isReceived == true) {
      colorIcon = KBadgeColorAndContainerBorderColorRecipientOrder;
      icon = Icons.assignment_turned_in_outlined;
      stateOrder = "تم استلامه";
    }
    if (widget.order.isArchived == true) {
      return Visibility(
        child: Text("Gone"),
        visible: false,
      );
    } else {
      return InkWell(
        child: Container(
          width: width - 50,
          child: Card(
            elevation: 5,
            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            //color: KCustomCompanyOrdersStatus,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    //width: width / 1.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                  bottom: height * 0),
                              child: Icon(
                                Icons.person,
                                color: Colors.green[800],
                              ),
                            ),

                            //  SizedBox(width: 33,),
                            FutureBuilder<String>(
                              future:
                                  CustomerServices(uid: widget.order.customerID)
                                      .customerName,
                              builder: (context, snapshot) {
                                // print(order.customerID);
                                return Text(
                                  snapshot.data ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  right: height * 0.025,
                                  top: height * 0,
                                  bottom: height * 0),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.blue[800],
                              ),
                            ),
                            FutureBuilder<String>(
                                future: CustomerServices(
                                        uid: widget.order.customerID)
                                    .customerCity,
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                }),
                            FutureBuilder<String>(
                                future: CustomerServices(
                                        uid: widget.order.customerID)
                                    .customerSublineName,
                                builder: (context, snapshot) {
                                  return Text(
                                    ' - ${snapshot.data}' ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                }),
                            FutureBuilder<String>(
                                future: CustomerServices(
                                        uid: widget.order.customerID)
                                    .customerAdress,
                                builder: (context, snapshot) {
                                  return Text(
                                    ' - ${snapshot.data}' ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
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
                                  bottom: height * 0),
                              child: Icon(
                                Icons.date_range,
                                color: Colors.blueGrey,
                                // size: 17,
                              ),
                            ),

                            //  SizedBox(width: 33,),
                            Text(
                              intl.DateFormat('yyyy-MM-dd')
                                  .format(widget.order.date),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Amiri",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          //3
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: height * 0.025,
                                  right: height * 0.025,
                                  top: height * 0,
                                  bottom: height * 0),
                              child: Icon(
                                Icons.location_city,
                                color: Colors.purple[800],
                              ),
                            ),

                            //  SizedBox(width: 33,),
                            FutureBuilder<String>(
                                future: BusinessServices(
                                        uid: widget.order.businesID)
                                    .businessName,
                                builder: (context, snapshot) {
                                  // print(snapshot.data);
                                  return Text(
                                    snapshot.data ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset('assets/price.png'),
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.015,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Text(
                              widget.order.price.toString(),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Amiri",
                              ),
                            ),
                          ),

                          //  SizedBox(width: 33,),
                        ],
                      ),
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            icon,
                            color: colorIcon,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Text(
                              stateOrder,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Amiri",
                              ),
                            ),
                          ),
                          //  SizedBox(width: 33,),

                          //  SizedBox(width: 33,),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
