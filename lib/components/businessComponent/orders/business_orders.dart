import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';

import '../../../constants.dart';
import 'order_status.dart';

class BusinessOrderList extends StatelessWidget {
  final name, uid;
  BusinessOrderList({this.name, this.uid});
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context) ?? [];

    print(orders.length);

    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return CustomCompanyOrdersStatus(
              order: orders[index], name: name, uid: uid);
        });
  }
}

class CustomCompanyOrdersStatus extends StatefulWidget {
  final Order order;
  final String orderState, name, uid;

  CustomCompanyOrdersStatus({this.order, this.orderState, this.name, this.uid});

  @override
  _CustomCompanyOrdersStatusState createState() =>
      _CustomCompanyOrdersStatusState();
}

class _CustomCompanyOrdersStatusState extends State<CustomCompanyOrdersStatus> {
  Color color;
  String customerName, customerID;
  @override
  Widget build(BuildContext context) {
    print(widget.uid);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    IconData icon;
    String stateOrder;
    Color color;

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
    } else if (widget.order.isDone == true) {
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
    }

    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => OrderStatus(
        //           name: widget.name,
        //           order: widget.order,
        //           customerName: customerName,
        //           orderState: orderState)),
        // );
      },
      child: Container(
          width: width - 50,
          height: 100,
          child: Card(
            elevation: 0.6,
            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 7.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            //color: KCustomCompanyOrdersStatus,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <
                Widget>[
              Container(
                width: width / 1.4,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Icon(
                              Icons.person,
                              color: Colors.blueGrey,
                            ),
                          ),
                          FutureBuilder<String>(
                              future:
                                  CustomerServices(uid: widget.order.customerID)
                                      .customerName,
                              builder: (context, snapshot) {
                                customerName = snapshot.data;
                                if (snapshot.hasData) {
                                  return Text(
                                    customerName ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "",
                                  );
                                }
                              }),
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
                              color: Colors.blueGrey,
                            ),
                          ),
                          FutureBuilder<String>(
                              future:
                                  CustomerServices(uid: widget.order.customerID)
                                      .customerCity,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data}-" ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                          FutureBuilder<String>(
                              future:
                                  CustomerServices(uid: widget.order.customerID)
                                      .customerSublineName,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data}-" ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                          FutureBuilder<String>(
                              future:
                                  CustomerServices(uid: widget.order.customerID)
                                      .customerAdress,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                        ],
                      ),
                    ]),
              ),
              Column(
                children: [
                  Row(children: <Widget>[
                    IconButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => UpdateOrder(
                        //             orderID: widget.order.uid,
                        //             customerID: widget.order.customerID,
                        //             name: widget.name,
                        //           )),
                        // );
                      },
                      icon: Icon(
                        Icons.create,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        return showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) => CustomDialog(
                                  title: "حذف طلبية",
                                  description: ' هل ترغب بحذف طلبية',
                                  name: customerName,
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
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ]),
                  Row(
                    //3
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        icon,
                        color: color,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: height * 0.025,
                            right: height * 0.025,
                            top: height * 0,
                            bottom: height * 0),
                        child: Text(
                          stateOrder ?? "",
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
            ]),
          )),
    );
  }
}

class CustomDialogStatus extends StatelessWidget {
  final Order order;
  final String orderState, name, uid;

  CustomDialogStatus({this.order, this.orderState, this.name, this.uid});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          // margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              CustomTextFieldOrderStatus(
                  "assets/OrderStatus.png", "حالة الطرد"),
              SizedBox(
                height: 20,
              ),
              CustomTextFieldOrderStatus(
                  "assets/OrderNotes.png", "ملاحظات من السائق"),
              SizedBox(
                height: 20,
              ),
              CustomTextFieldOrderStatus(
                  "assets/OrderِAmountStatus.png", "المبلغ المستحق للشركة"),
              SizedBox(
                height: 20,
              ),
              CustomTextFieldOrderStatus(
                  "assets/DateOrderDeliveredStatus.png", "تاريخ تسليم الطرد"),
              SizedBox(
                height: 20,
              ),
              CustomTextFieldOrderStatus(
                  "assets/DateOrderِAdminAuthenticationStatus.png",
                  "تاريخ المصادقة من الادمن"),
            ],
          ),
        ),
      ],
    );
  }
}
