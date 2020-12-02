import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/classes/invoice.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/services/driverServices.dart';
import 'package:sajeda_app/services/invoiceServices.dart';
import 'package:sajeda_app/services/orderServices.dart';

import '../../../constants.dart';
import 'add_invoice_driver.dart';

class AllInvoiceDrivers extends StatelessWidget {
  final Color color;
  final Function onTapBox;
  final String driverId, name;
  List<Order> orders;
  int total = 0;
  AllInvoiceDrivers({
    @required this.color,
    @required this.onTapBox,
    @required this.driverId,
     this.name,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder<Driver>(
        stream: DriverServices(uid: driverId).driverByID,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Driver driver = snapshot.data;
            return Card(
              elevation: 5,
              margin: EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                Row(children: <Widget>[
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
                                    bottom: height * 0),
                                child: Icon(
                                  Icons.account_circle,
                                  color: KEditIconColor,
                                  size: 30,
                                ),
                              ),
                              Text(
                                driver.name,
                                style: TextStyle(
                                  fontSize: 16,
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
                                    left: height * 0.015,
                                    right: height * 0.015,
                                    top: height * 0,
                                    bottom: height * 0),
                                // child: Icon(
                                //   Icons.date_range,
                                //   color: Colors.blueGrey,
                                // ),
                              ),
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
                                child: Image.asset(
                                  'assets/price.png',
                                  scale: 1.5,
                                ),
                              ),
                              StreamBuilder<List<Order>>(
                                  stream:
                                      OrderServices().driversAllOrders(driverId),
                                  builder: (context, snapshot) {
                                    int totalPrice = 0;

                                    if (!snapshot.hasData) {
                                      return Text(
                                        "0",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri",
                                        ),
                                      );
                                    } else {
                                      orders = snapshot.data;
                                      orders.forEach((element) {
                                        totalPrice += element.driverPrice;
                                        print(totalPrice);
                                        total = totalPrice;
                                      });
                                      return Text(
                                        total.toString() ?? "",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Amiri",
                                        ),
                                      );
                                    }
                                  }),
                              SizedBox(
                                width: 40,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddInvoiceDriver(
                                              driverId: driverId,
                                              name: name,
                                              driverName: driver.name,
                                              total: total
                                            )),
                                  );
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Positioned(
                              child: Container(
                                width: width - 2,
                                height: 9,
                                child: Card(
                                  color: color,

                                  ///case color
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
                  Container(
                    width: width - 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.done,
                          color: KBadgeColorAndContainerBorderColorReadyOrders,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(driverID: driverId)
                                .countDriverOrderByStateOrder("isDone"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Text(
                                ":${snapshot.data.toString()} " ?? "0",
                              );
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.restore,
                          color: KBadgeColorAndContainerBorderColorReturnOrders,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(driverID: driverId)
                                .countDriverOrderByStateOrder("isReturn"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Text(
                                ":${snapshot.data.toString()} " ?? "0",
                              );
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.cancel,
                          color:
                              KBadgeColorAndContainerBorderColorCancelledOrders,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(driverID: driverId)
                                .countDriverOrderByStateOrder("isCancelld"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Text(
                                ":${snapshot.data.toString()} " ?? "0",
                              );
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.business_center_outlined,
                          color: KAllOrdersListTileColor,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(driverID: driverId)
                                .countDriverOrderByStateOrder("isDelivery"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Text(
                                ":${snapshot.data.toString()} " ?? "0",
                              );
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.arrow_circle_up_rounded,
                          color: KBadgeColorAndContainerBorderColorLoadingOrder,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(driverID: driverId)
                                .countDriverOrderByStateOrder("isLoading"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Text(
                                ":${snapshot.data.toString()} " ?? "0",
                              );
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.assignment_turned_in_outlined,
                          color:
                              KBadgeColorAndContainerBorderColorRecipientOrder,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(driverID: driverId)
                                .countDriverOrderByStateOrder("isReceived"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Text(
                                ":${snapshot.data.toString()} " ?? "0",
                              );
                            }),
                      ],
                    ),
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
              ]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class TotalPrice extends StatelessWidget {
  final String businessId, name;

  TotalPrice({
    @required this.businessId,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    final invoice = Provider.of<List<Invoice>>(context).where((driv) {
          return driv.businessID == businessId;
        }).toList() ??
        [];
    print(invoice[0].totalPrice);

    return StreamProvider<List<Invoice>>.value(
      value: InvoiceServices(businessId: businessId).totalPrice,
      child: InvoicePrice(),
    );
  }
}

class InvoicePrice extends StatefulWidget {
  @override
  _InvoicePriceState createState() => _InvoicePriceState();
}

class _InvoicePriceState extends State<InvoicePrice> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final invoice = Provider.of<List<Invoice>>(context) ?? [];

    return ListView.builder(
        itemCount: invoice.length,
        itemBuilder: (context, index) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: height * 0.025,
                      right: height * 0.025,
                      top: height * 0,
                      bottom: height * 0),
                  child: Image.asset('assets/price.png'),
                ),
                SizedBox(
                  width: 33,
                ),
                Text(
                  invoice[index].totalPrice.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Amiri",
                  ),
                ),
              ]);
        });
  }
}
