import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/businessComponent/orders/update_order.dart';
import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';
import 'package:sajeda_app/services/customerServices.dart';
import 'package:sajeda_app/services/orderServices.dart';

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
    String orderState;
    if (widget.order.isCancelld == true)
      //color = KBadgeColorAndContainerBorderColorCancelledOrders;
      orderState = "تم الغاء الطرد ";
    else if (widget.order.isDelivery == true)
      //color = KAllOrdersListTileColor;
      orderState = " تم توزيع الطرد على السائق";
    else if (widget.order.isDone == true)
      // color = KBadgeColorAndContainerBorderColorReadyOrders;
      orderState = "تم استلام الطرد من قبل الزبون";
    else if (widget.order.isLoading == true)
      // color = KBadgeColorAndContainerBorderColorLoadingOrder;
      orderState = "لم يتم تحميل الطرد بعد";
    else if (widget.order.isUrgent == true)
      // color = KBadgeColorAndContainerBorderColorUrgentOrders;
      orderState = "تم الغاء الطرد ";
    else if (widget.order.isReturn == true)
      // color = KBadgeColorAndContainerBorderColorReturnOrders;
      orderState = "تم ارجاع الطرد ";
    else if (widget.order.isReceived == true)
      // color = KBadgeColorAndContainerBorderColorRecipientOrder;
      orderState = "تم استلام الطرد منكم ";

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderStatus(
                  name: widget.name,
                  order: widget.order,
                  customerName: customerName,
                  orderState: orderState)),
        );
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
                                  CustomerService(uid: widget.order.customerID)
                                      .customerName,
                              builder: (context, snapshot) {
                                customerName = snapshot.data;

                                return Text(
                                  customerName ?? "",
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
                                  CustomerService(uid: widget.order.customerID)
                                      .customerCity,
                              builder: (context, snapshot) {
                                return Text(
                                  "${snapshot.data}-" ?? "",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                );
                              }),
                          FutureBuilder<String>(
                              future:
                                  CustomerService(uid: widget.order.customerID)
                                      .customerAdress,
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
                        ],
                      ),
                    ]),
              ),
              Container(
                child: Row(children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateOrder(
                                  orderID: widget.order.uid,
                                  customerID: widget.order.customerID,
                                  name: widget.name,
                                )),
                      );
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
                                  OrderService()
                                      .deleteOrderData(widget.order.uid);
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
