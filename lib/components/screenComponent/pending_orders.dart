import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/components/companyComponent/company_orders_admin_side.dart';
import 'package:AsyadLogistic/components/screenComponent/admin_orders.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/orderComponent/orderList.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';

class PendingOrders extends StatefulWidget {
  final String name;
  PendingOrders({this.name});

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("الطرود المحملة",
              style: TextStyle(fontSize: 20.0, fontFamily: 'Amiri')),
          backgroundColor: kAppBarColor,
          centerTitle: true,
        ),
        endDrawer: Directionality(
            textDirection: TextDirection.rtl,
            child: AdminDrawer(name: widget.name)),
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: StreamProvider<List<Order>>.value(
            value: OrderServices().ordersByState('isLoading'),
           // catchError: (_, __) => null,
            child: PendingOrderList(orderState: 'isLoading', name: widget.name),
          ),
        ));
  }
}

class PendingOrderList extends StatefulWidget {
  final String orderState, name;
  PendingOrderList({@required this.orderState, this.name});

  @override
  _PendingOrderListState createState() => _PendingOrderListState();
}

class _PendingOrderListState extends State<PendingOrderList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context) ?? [];
    if (orders != []) {
      final ids = orders.map((e) => e.businesID).toSet();
      orders.retainWhere((x) => ids.remove(x.businesID));
      return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return CustomCardPendingOrder(
            color: KCustomCompanyOrdersStatus,
            businessID: orders[index].businesID,
            orderState: widget.orderState,
            name: widget.name,
            onTapBox: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompanyOrdersAdminSide(
                          uid: orders[index].businesID,
                          orderState: widget.orderState,
                          name: widget.name,
                        )),
              );
            },
          );
        },
      );
    } else {
      return Center(child: Image.asset("assets/EmptyOrder.png"));
    }
  }
}

class CustomCardPendingOrder extends StatefulWidget {
  final Color color;
  final Function onTapBox;
  final String businessID, name;
  final String orderState;
  final Function onTapSelectAll;

  CustomCardPendingOrder(
      {@required this.color,
      @required this.onTapBox,
      @required this.businessID,
      @required this.orderState,
      this.onTapSelectAll,
      this.name});

  @override
  _CustomCardPendingOrderState createState() => _CustomCardPendingOrderState();
}

class _CustomCardPendingOrderState extends State<CustomCardPendingOrder> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool checkboxVal = false;

    return StreamBuilder<Business>(
      stream: BusinessServices(uid: widget.businessID).businessByID,
      builder: (context, snapshot) {
        //print(snapshot.data);
        if (snapshot.hasData) {
          Business business = snapshot.data;
          return InkWell(
            onTap: () {},
            child: Card(
              color: widget.color,
              child: ListTile(
                title: Text(
                    "${business.name}"), // String Variable Take Name From DataBase
                leading: FutureBuilder<int>(
                    future: OrderServices(businesID: widget.businessID)
                        .countBusinessOrderByStateOrder(widget.orderState),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Badge(
                          position: BadgePosition.topStart(
                              start: width * 0.04, top: height * -0.004),
                          elevation: 5,
                          animationType: BadgeAnimationType.slide,
                          badgeContent: Text(
                            snapshot.data.toString() ?? "-1",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          shape: BadgeShape.circle,
                          badgeColor: KEditIconColor,
                          child: IconButton(
                            icon: Image.asset(
                              "assets/select-all.png",
                              width: 25,
                            ),
                            onPressed: () {
                              return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) =>
                                      CustomDialogSelectAll(
                                        title: "تحديد جميع الطرود المحملة",
                                        description:
                                            'تأكيد استلام جميع الطرود لشركة',
                                        name: "${business.name}",
                                        buttonText: "تأكيد",
                                        onPressed: () async {
                                          OrderServices(businesID: business.uid)
                                              .loadingToReceivedBusinessOrders(
                                                  business.uid);
                                          Toast.show("تم الاستلام", context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.BOTTOM);
                                          await Future.delayed(
                                              Duration(milliseconds: 1000));
                                          Navigator.of(context).pop();
                                          // await Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => AdminOrders(
                                          //         name: widget.name),
                                          //     fullscreenDialog: true,
                                          //   ),
                                          // );
                                          // setState(() {});
                                        },
                                        cancelButton: "الغاء",
                                        cancelPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ));
                            },
                          ),
                        );
                      } else {
                        return Badge(
                          position: BadgePosition.topStart(
                              start: width * 0.04, top: height * -0.004),
                          elevation: 5,
                          animationType: BadgeAnimationType.slide,
                          badgeContent: Text(
                            "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          shape: BadgeShape.circle,
                          badgeColor: KEditIconColor,
                          child: IconButton(
                              icon: Image.asset(
                                "assets/select-all.png",
                                width: 25,
                              ),
                              onPressed: widget.onTapBox),
                        );
                      }
                    }),
                trailing: Wrap(
                  spacing: -15, // space between two icons
                  children: <Widget>[
                    FutureBuilder<int>(
                        future: OrderServices(businesID: widget.businessID)
                            .countBusinessOrderByStateOrder(widget.orderState),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Badge(
                              position: BadgePosition.topStart(
                                  start: width * 0.04, top: height * -0.004),
                              elevation: 5,
                              animationType: BadgeAnimationType.slide,
                              badgeContent: Text(
                                snapshot.data.toString() ?? "-1",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              shape: BadgeShape.circle,
                              badgeColor: KEditIconColor,
                              child: IconButton(
                                  icon: Image.asset("assets/BoxIcon.png"),
                                  onPressed: widget.onTapBox),
                            );
                          } else {
                            return Badge(
                              position: BadgePosition.topStart(
                                  start: width * 0.04, top: height * -0.004),
                              elevation: 5,
                              animationType: BadgeAnimationType.slide,
                              badgeContent: Text(
                                "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              shape: BadgeShape.circle,
                              badgeColor: KEditIconColor,
                              child: IconButton(
                                  icon: Image.asset("assets/BoxIcon.png"),
                                  onPressed: widget.onTapBox),
                            );
                          }
                        }),

                        
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
