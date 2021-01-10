import 'package:AsyadLogistic/components/businessComponent/updateComponent/update_company.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:intl/intl.dart' as intl;
import '../../../constants.dart';

class AllBuisness extends StatelessWidget {
  final Color color;
  final Function onTapBox;
  final String businessID, name, busID;

  AllBuisness(
      {@required this.color,
      @required this.onTapBox,
      @required this.businessID,
      this.name,
      this.busID});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StreamBuilder<Business>(
        stream: BusinessServices(uid: businessID).businessByID,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Business business = snapshot.data;
            return Card(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Icon(
                              Icons.circle,
                              color: Color(0xff316686),
                              size: 23.0,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${business.name}',
                              style: TextStyle(
                                  fontFamily: 'Amiri', fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FutureBuilder<int>(
                              future: OrderServices(businesID: businessID)
                                  .countBusinessOrders(businessID),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Badge(
                                    position: BadgePosition.topStart(
                                        start: width * 0.04,
                                        top: height * -0.004),
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
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BusinessOrders(
                                                          name: name,
                                                          uid: businessID)));
                                        }),
                                  );
                                } else {
                                  return Badge(
                                    position: BadgePosition.topStart(
                                        start: width * 0.04,
                                        top: height * -0.004),
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
                                        onPressed: () {}),
                                  );
                                }
                              }),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateCompany(
                                        businessID: businessID, name: name)),
                              );
                            },
                            icon: Icon(
                              Icons.create,
                              color: Colors.green,
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     return showDialog<void>(
                          //         context: context,
                          //         barrierDismissible:
                          //             false, // user must tap button!
                          //         builder: (BuildContext context) =>
                          //             CustomDialog(
                          //               title: "حذف شركة",
                          //               description: ' هل ترغب بحذف الشركة',
                          //               name: business.name,
                          //               buttonText: "تأكيد",
                          //               onPressed: () {
                          //                 final FirebaseAuth auth =
                          //                     FirebaseAuth.instance;
                          //                 final User user = auth.currentUser;
                          //                 BusinessServices().deleteBusinessData(
                          //                     businessID, user.uid);
                          //                 Navigator.of(context).pop();
                          //               },
                          //               cancelButton: "الغاء",
                          //               cancelPressed: () {
                          //                 Navigator.of(context).pop();
                          //               },
                          //             ));
                          //   },
                          //   icon: Icon(
                          //     Icons.delete,
                          //     color: Colors.red,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class BusinessOrders extends StatelessWidget {
  final String name, uid;
  BusinessOrders({this.name, this.uid});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("جميع الطلبيات",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
          centerTitle: true,
          backgroundColor: kAppBarColor,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
              color: Colors.white,
            ),
          ],
        ),
        drawer: AdminDrawer(name: name, uid: uid),
        body: StreamProvider<List<Order>>.value(
          value: OrderServices(businesID: uid, orderState: "all")
              .ordersBusinessByState,
          child: BusinessOrderListAdmin(name: name, uid: uid),
        ),
      ),
    );
  }
}

class BusinessOrderListAdmin extends StatelessWidget {
  final name, uid;
  BusinessOrderListAdmin({this.name, this.uid});
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    IconData icon;
    String orderState;
    DateTime date;

    if (widget.order.inStock == true) {
      color = KBadgeColorAndContainerBorderColorWithDriverOrders;
      icon = Icons.archive_sharp;
      orderState = "في المخزن";
      date = widget.order.inStockDate;
    }
    if (widget.order.isCancelld == true) {
      color = KBadgeColorAndContainerBorderColorCancelledOrders;
      icon = Icons.cancel;
      orderState = "ملغي";
      date = widget.order.isCancelldDate;
    } else if (widget.order.isDelivery == true) {
      color = KAllOrdersListTileColor;
      icon = Icons.business_center_outlined;
      orderState = "جاهز للتوزيع";
      date = widget.order.isDeliveryDate;
    } else if (widget.order.isDone == true) {
      color = KBadgeColorAndContainerBorderColorReadyOrders;
      icon = Icons.done;
      orderState = "جاهز";
      date = widget.order.isDoneDate;
    } else if (widget.order.isLoading == true) {
      color = KBadgeColorAndContainerBorderColorLoadingOrder;
      icon = Icons.arrow_circle_up_rounded;
      orderState = "محمل";
      date = widget.order.isLoadingDate;
    } else if (widget.order.isUrgent == true) {
      color = KBadgeColorAndContainerBorderColorUrgentOrders;
      icon = Icons.info_outline;
      orderState = "مستعجل";
    } else if (widget.order.isReturn == true) {
      color = KBadgeColorAndContainerBorderColorReturnOrders;
      icon = Icons.restore;
      orderState = "راجع";
      date = widget.order.isReturnDate;
    } else if (widget.order.isReceived == true) {
      color = KBadgeColorAndContainerBorderColorRecipientOrder;
      icon = Icons.assignment_turned_in_outlined;
      orderState = "تم استلامه";
      date = widget.order.isReceivedDate;
    }

    return InkWell(
      onTap: () {},
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
                width: width / 1.6,
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
                                  CustomerServices(uid: widget.order.customerID)
                                      .customerCity,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data.toString()}-" ?? "",
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
                          FutureBuilder<String>(
                              future:
                                  CustomerServices(uid: widget.order.customerID)
                                      .customerSublineName,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "${snapshot.data.toString()}-" ?? "",
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
                              Icons.calendar_today,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text(
                            intl.DateFormat('yyyy-MM-dd').format(date),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Icon(
                              Icons.access_alarm,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text(
                            intl.DateFormat.jm().format(date),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      icon,
                      color: color,
                    ),
                  ),
                  Text(orderState),
                ],
              )),
            ]),
          )),
    );
  }
}
