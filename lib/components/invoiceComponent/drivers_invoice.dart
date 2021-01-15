import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/order.dart';

import '../../constants.dart';
import 'driverInvoice/add_invoice_driver.dart';
import 'shared_data.dart';

class DriversInvoice extends StatefulWidget {
  final Order order;
  final String name;
  DriversInvoice({@required this.order, this.name});

  @override
  _DriversInvoiceState createState() => _DriversInvoiceState();
}

class _DriversInvoiceState extends State<DriversInvoice> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    IconData icon;
    String stateOrder, paidDriver = "";
    Color color;
    print(widget.order.totalPrice.toString());
    if (widget.order.inStock == true) {
      color = KBadgeColorAndContainerBorderColorWithDriverOrders;
      icon = Icons.archive_sharp;
      stateOrder = "في المخزن";
    }
    if (widget.order.isCancelld == true) {
      color = KBadgeColorAndContainerBorderColorCancelledOrders;
      icon = Icons.cancel;
      stateOrder = "ملغي";
    } else if (widget.order.isDelivery == true) {
      color = KAllOrdersListTileColor;
      icon = Icons.business_center_outlined;
      stateOrder = "جاهز للتوزيع";
    } else if (widget.order.isDone == true &&
        widget.order.isPaidDriver == false) {
      color = KBadgeColorAndContainerBorderColorReadyOrders;
      icon = Icons.done;
      stateOrder = "جاهز";
    } else if (widget.order.isLoading == true) {
      color = KBadgeColorAndContainerBorderColorLoadingOrder;
      icon = Icons.arrow_circle_up_rounded;
      stateOrder = "محمل";
    } else if (widget.order.isUrgent == true) {
      color = KBadgeColorAndContainerBorderColorUrgentOrders;
      icon = Icons.info_outline;
      stateOrder = "مستعجل";
    } else if (widget.order.isReturn == true) {
      color = KBadgeColorAndContainerBorderColorReturnOrders;
      icon = Icons.restore;
      stateOrder = "راجع";
    } else if (widget.order.isReceived == true) {
      color = KBadgeColorAndContainerBorderColorRecipientOrder;
      icon = Icons.assignment_turned_in_outlined;
      stateOrder = "تم استلامه";
    } else if (widget.order.isDone == true &&
        widget.order.isPaidDriver == true) {
      color = KBadgeColorAndContainerBorderColorPaidOrders;
      stateOrder = "مدفوع";
      paidDriver = "حذف هذه الطلبية المدفوعة";
    }

    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
        Widget>[
      Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                    color: color,
                    border: new Border.all(color: Colors.white, width: 2.0),
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: new Center(
                    child: new Text(
                      stateOrder,
                      style: new TextStyle(fontSize: 13.0, color: Colors.white),
                    ),
                  ),
                ),
                VerticalDivider(),
                CustomerName(order: widget.order),
                Icon(
                  Icons.arrow_downward,
                ),
                VerticalDivider(),
                BisunessrName(order: widget.order),
                Icon(
                  Icons.arrow_upward,
                ),
              ]),
          HorizantalDivider(width),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomerCityAndSublineName(order: widget.order),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                       Text(
                        widget.order.totalPrice.toString(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: height * 0.015,
                            top: height * 0,
                            bottom: height * 0),
                        child: Image.asset(
                          'assets/price.png',
                          scale: 1.5,
                        ),
                      ),
                    ]),
              ]),
          HorizantalDivider(width),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            CustomerAddressName(order: widget.order),
          ]),
          HorizantalDivider(width),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                 Text(
                  widget.order.uid,
                  style: new TextStyle(
                    fontSize: 13.0,
                    color: Color(0xFF457B9D),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                    child: Text(
                  widget.order.description ?? "",
                  style: new TextStyle(fontSize: 13.0),
                )),
              ]),
          HorizantalDivider(width),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddInvoiceDriver(
                              driverId: widget.order.driverID,
                              name: widget.name,
                              order: widget.order)),
                    );
                  },
                  child: DriverName(order: widget.order),
                ),
                DriverPhoneNumber(order: widget.order),
              ]),
          HorizantalDivider(width),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DeliveryNote(order: widget.order),
                DeliveryStatus(order: widget.order),
              ]),
          HorizantalDivider(width),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) => CustomDialog(
                              title: "حذف طلبية",
                              description: ' هل ترغب بحذف هذه الطلبية الجاهزة',
                              name: widget.order.description,
                              buttonText: "تأكيد",
                              onPressed: () {
                                final FirebaseAuth auth =
                                          FirebaseAuth.instance;
                                      final User user = auth.currentUser;
                                OrderServices().deleteOrderData(
                                    widget.order.uid, user.uid);
                                Navigator.of(context).pop();
                                DriversInvoice(
                                    order: widget.order, name: widget.name);
                              },
                              cancelButton: "الغاء",
                              cancelPressed: () {
                                Navigator.of(context).pop();
                              },
                            ));
                  },
                  child:  Text(
                    paidDriver ?? "",
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: Color(0xffA8312D),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
        ],
      )),
      SizedBox(
        height: 15,
      ),
    ]);
  }

  // ignore: non_constant_identifier_names
  Widget VerticalDivider() {
    return Container(
      color: Colors.black45,
      height: 50,
      width: 1,
    );
  }

  // ignore: non_constant_identifier_names
  Widget HorizantalDivider(double width) {
    return Container(
      color: Colors.black45,
      height: 1,
      width: width,
    );
  }
}
