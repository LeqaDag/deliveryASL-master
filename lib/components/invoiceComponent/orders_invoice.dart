import 'package:AsyadLogistic/components/reportComponent/shared.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:intl/intl.dart' as intl;
import '../../constants.dart';
import 'custom_icon_button.dart';

class OrdersInvoice extends StatefulWidget {
  final Order order;
  final String name;

  OrdersInvoice({@required this.order, this.name});

  @override
  _OrdersInvoiceState createState() => _OrdersInvoiceState();
}

class _OrdersInvoiceState extends State<OrdersInvoice> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    IconData icon;
    String stateOrder,
        paidDriver = "";
    Color color;
    DateTime stateDate;

    print(widget.order.totalPrice.toString());
    if (widget.order.inStock == true) {
      color = KBadgeColorAndContainerBorderColorWithDriverOrders;
      icon = Icons.archive_sharp;
      stateOrder = "في المخزن";
      stateDate = widget.order.inStockDate;
    }
    if (widget.order.isCancelld == true) {
      color = KBadgeColorAndContainerBorderColorCancelledOrders;
      icon = Icons.cancel;
      stateOrder = "ملغي";
      stateDate = widget.order.isCancelldDate;
    } else if (widget.order.isDelivery == true) {
      color = KAllOrdersListTileColor;
      icon = Icons.business_center_outlined;
      stateOrder = "جاهز للتوزيع";
      stateDate = widget.order.isDeliveryDate;
    } else if (widget.order.isDone == true &&
        widget.order.isPaidDriver == false) {
      color = KBadgeColorAndContainerBorderColorReadyOrders;
      icon = Icons.done;
      stateOrder = "جاهز";
      stateDate = widget.order.isDoneDate;
    } else if (widget.order.isLoading == true) {
      color = KBadgeColorAndContainerBorderColorLoadingOrder;
      icon = Icons.arrow_circle_up_rounded;
      stateOrder = "محمل";
      stateDate = widget.order.isLoadingDate;
    } else if (widget.order.isUrgent == true) {
      color = KBadgeColorAndContainerBorderColorUrgentOrders;
      icon = Icons.info_outline;
      stateOrder = "مستعجل";
      stateDate = widget.order.isUrgentDate;
    } else if (widget.order.isReturn == true) {
      color = KBadgeColorAndContainerBorderColorReturnOrders;
      icon = Icons.restore;
      stateOrder = "راجع";
      stateDate = widget.order.isReturnDate;
    } else if (widget.order.isReceived == true) {
      color = KBadgeColorAndContainerBorderColorRecipientOrder;
      icon = Icons.assignment_turned_in_outlined;
      stateOrder = "تم استلامه";
      stateDate = widget.order.isReceivedDate;
    } else if (widget.order.isDone == true &&
        widget.order.isPaidDriver == true) {
      color = KBadgeColorAndContainerBorderColorPaidOrders;
      stateOrder = "مدفوع";
      paidDriver = "حذف هذه الطلبية المدفوعة";
      stateDate = widget.order.paidDriverDate;
    }

       return Container(
        margin: EdgeInsets.symmetric(horizontal: 31, vertical: 21),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(
            colors: [
              Color(0xfff1f1f1),
              Color(0xffffffff),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: <Widget>[
                      Container(
                                        width: 80.0,
                                        height: 50.0,
                                        decoration: new BoxDecoration(
                                          color: color,
                                          border: new Border.all(color: Colors.white, width: 2.0),
                                          borderRadius: new BorderRadius.circular(30.0),
                                        ),
                                        child: new Center(
                                          child: new Text(
                                            stateOrder,
                                            style: new TextStyle(
                                                fontSize: 13.0, color: Colors.white),
                                          ),
                                        ),
                                      ),

                      ],
                    ),

                    trailing:
                        Text(widget.order.barcode),
                  ),
                  ListTile(
                    title:   Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.business
                                  ),
                                  BisunessrName(order: widget.order),
                                ]),
                    subtitle: BusinessCity(order: widget.order,),
                    trailing: BisunessPhoneNumber(order: widget.order,),
                  ),
                  ListTile(
                    title:   Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                              Icons.supervised_user_circle
                          ),
                          CustomerName(order: widget.order),
                        ]),
                    subtitle:  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                              Icons.location_on
                          ),
                          CustomerCityAndSublineName(order: widget.order),
                          Text("/"),
                          CustomerAddressName(order: widget.order),
                        ]),
                    trailing: CustomerPhoneNumber(order: widget.order,)
                  ),
                  ListTile(
                    title:   Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                          Icons.calendar_today_outlined
                                      ),
                                      Text(
                                        " تاريخ الطلبية : ${intl.DateFormat('yyyy-MM-dd').format(
                                            widget.order.date)} " ??
                                            "",
                                        style: new TextStyle(fontSize: 13.0),
                                      ),
                                    ]),


                  ),
                  ListTile(
                    title:   Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                              Icons.calendar_today_outlined
                          ),
                          Text(
                            " تاريخ آخر التحديث : ${intl.DateFormat('yyyy-MM-dd')
                                .format(stateDate)} " ??
                                "",
                            style: new TextStyle(fontSize: 13.0),
                          ),

                        ]),
                    subtitle: Text(
                      "وقت آخر التحديث : ${intl.DateFormat.jm().format(
                          stateDate)} " ??
                          "",
                      style: new TextStyle(fontSize: 13.0),
                    ),
                  ),
                ],
              ),

          ListTile(
            title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                        Icons.description
                    ),
                    Text(
                      widget.order.description,
                      style: TextStyle(color: Colors.black,),
                    ),

                  ]),
            subtitle:  Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
    Text(
    "مع : " ?? "",
    style: new TextStyle(fontSize: 13.0),
    ),
    DriverName(order: widget.order),

    ]),
          ),

              ListTile(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "السعر : ",
                      ),
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
              ),
              HorizantalDivider(width),
              ListTile(
                title:    Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      return showDialog<void>(
                                          context: context,
                                          barrierDismissible: false, // user must tap button!
                                          builder: (BuildContext context) =>
                                              CustomDialog(
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
                                                },
                                                cancelButton: "الغاء",
                                                cancelPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ));
                                    },
                                    child: Text(
                                      paidDriver ?? "",
                                      style: new TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xffA8312D),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
              )
            ],
          ),
        ),
      );
    }
  }


  // ignore: non_constant_identifier_names
  Widget HorizantalDivider(double width) {
    return Container(
      color: Colors.black45,
      height: 1,
      width: width,
    );
  }
