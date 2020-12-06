import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/invoice.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/invoiceServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';

import '../../../constants.dart';
import 'add_invoice.dart';

class AllInvoice extends StatefulWidget {
  final Color color;
  final Function onTapBox;
  final String businessId, name;

  AllInvoice({
    @required this.color,
    @required this.onTapBox,
    @required this.businessId,
    this.name,
  });

  @override
  _AllInvoiceState createState() => _AllInvoiceState();
}

class _AllInvoiceState extends State<AllInvoice> {
  List<Order> orders;

  int total;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder<Business>(
        stream: BusinessServices(uid: widget.businessId).businessByID,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Business business = snapshot.data;
            return Flexible(
                child: Card(
              elevation: 5,
              margin: EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                Row(children: <Widget>[
                  Expanded(
                      child:Container(
                    width: width / 2,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            //3
                            //mainAxisAlignment: MainAxisAlignment.start,
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
                                business.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Amiri",
                                ),
                              ),
                            ],
                          ),
                        ]),
                )),
                  Expanded(
                    child: Container(
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
                                  stream: OrderServices()
                                      .businessAllOrders(widget.businessId),
                                  builder: (context, snapshot) {
                                    int totalPrice = 0;
                                    if (!snapshot.hasData) {
                                      return Text('جاري التحميل ... ');
                                    } else {
                                      orders = snapshot.data;
                                      orders.forEach((element) {
                                        totalPrice += element.price;
                                        total = totalPrice;
                                      });
                                      return Text(totalPrice.toString());
                                    }
                                  }),
                              
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddInvoice(
                                            businessId: widget.businessId,
                                            name: widget.name)),
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
                  )),
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Positioned(
                              child: Container(
                                width: width - 2,
                                height: 9,
                                child: Card(
                                  color: widget.color,

                                  ///case color
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ]),
                Row(children: <Widget>[
                  Container(
                    width: width - 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          Icons.done,
                          color: KBadgeColorAndContainerBorderColorReadyOrders,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(businesID: widget.businessId)
                                .countBusinessOrderByStateOrder("isDone"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  ":${snapshot.data.toString()} " ?? "0",
                                );
                              } else {
                                return Text(
                                  "0",
                                );
                              }
                            }),
                        Icon(
                          Icons.restore,
                          color: KBadgeColorAndContainerBorderColorReturnOrders,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(businesID: widget.businessId)
                                .countBusinessOrderByStateOrder("isReturn"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  ":${snapshot.data.toString()} " ?? "0",
                                );
                              } else {
                                return Text(
                                  "0",
                                );
                              }
                            }),
                        Icon(
                          Icons.cancel,
                          color:
                              KBadgeColorAndContainerBorderColorCancelledOrders,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(businesID: widget.businessId)
                                .countBusinessOrderByStateOrder("isCancelld"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  ":${snapshot.data.toString()} " ?? "0",
                                );
                              } else {
                                return Text(
                                  "0",
                                );
                              }
                            }),
                        Icon(
                          Icons.business_center_outlined,
                          color: KAllOrdersListTileColor,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(businesID: widget.businessId)
                                .countBusinessOrderByStateOrder("isDelivery"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  ":${snapshot.data.toString()} " ?? "0",
                                );
                              } else {
                                return Text(
                                  "0",
                                );
                              }
                            }),
                        Icon(
                          Icons.arrow_circle_up_rounded,
                          color: KBadgeColorAndContainerBorderColorLoadingOrder,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(businesID: widget.businessId)
                                .countBusinessOrderByStateOrder("isLoading"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  ":${snapshot.data.toString()} " ?? "0",
                                );
                              } else {
                                return Text(
                                  "0",
                                );
                              }
                            }),
                        Icon(
                          Icons.assignment_turned_in_outlined,
                          color:
                              KBadgeColorAndContainerBorderColorRecipientOrder,
                        ),
                        FutureBuilder<int>(
                            future: OrderServices(businesID: widget.businessId)
                                .countBusinessOrderByStateOrder("isReceived"),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  ":${snapshot.data.toString()} " ?? "0",
                                );
                              } else {
                                return Text(
                                  "0",
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
              ]),
            ));
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
                // Text(
                //   invoice[index].totalPrice.toString(),
                //   style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "Amiri",
                //   ),
                // ),
              ]);
        });
  }
}
