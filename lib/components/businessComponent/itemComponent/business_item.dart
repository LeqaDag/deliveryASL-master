import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/businessComponent/addComponent/add_delivery_cost.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';
import 'package:sajeda_app/services/businessServices.dart';
import 'package:sajeda_app/services/cityServices.dart';
import 'package:sajeda_app/services/customerServices.dart';
import 'package:sajeda_app/services/orderServices.dart';

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
        stream: BusinessService(uid: businessID).businessByID,
        builder: (context, snapshot) {
          print(businessID);
          if (snapshot.hasData) {
            Business business = snapshot.data;
            return Card(
              color: color,
              child: ListTile(
                title: Text(
                    "${business.name}"), // String Variable Take Name From DataBase
                leading: CircleAvatar(
                    // Account Image Form DataBase
                    ),
                trailing: Wrap(
                  spacing: -15, // space between two icons
                  children: <Widget>[
                    FutureBuilder<int>(
                        future: OrderService(businesID: businessID)
                            .countBusinessOrders(businessID),
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
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => CustomCompanyOrdersItemsStatus(name: name)),
                                    // );
                                  }),
                            );
                          }
                        }),
                    // IconButton(
                    //     icon: Icon(Icons.edit, color: KEditIconColor),
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => UpdateCompany(
                    //                 businessID: businessID, name: name)),
                    //       );
                    //     }),

                    IconButton(
                      onPressed: () {
                        return showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) => CustomDialog(
                                  title: "حذف شركة",
                                  description: ' هل ترغب بحذف الشركة',
                                  name: business.name,
                                  buttonText: "تأكيد",
                                  onPressed: () {
                                    BusinessService()
                                        .deleteBusinessData(businessID);
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
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: KAllOrdersListTileColor),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddDeliveryCost(
                                  businessID: businessID,
                                  businessName: business.name,
                                  name: name,
                                  busID: busID)),
                        );
                      },
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
          value: OrderService(businesID: uid, orderState: "all")
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
    String cityID;
    IconData icon;
    String orderState;
    if (widget.order.isCancelld == true) {
      color = KBadgeColorAndContainerBorderColorCancelledOrders;
      icon = Icons.cancel;
      orderState = "ملغي";
    } else if (widget.order.isDelivery == true) {
      color = KAllOrdersListTileColor;
      icon = Icons.business_center_outlined;
      orderState = "جاهز للتوزيع";
    } else if (widget.order.isDone == true) {
      color = KBadgeColorAndContainerBorderColorReadyOrders;
      icon = Icons.done;
      orderState = "جاهز";
    } else if (widget.order.isLoading == true) {
      color = KBadgeColorAndContainerBorderColorLoadingOrder;
      icon = Icons.arrow_circle_up_rounded;
      orderState = "محمل";
    } else if (widget.order.isUrgent == true) {
      color = KBadgeColorAndContainerBorderColorUrgentOrders;
      icon = Icons.info_outlined;
      orderState = "مستعجل";
    } else if (widget.order.isReturn == true) {
      color = KBadgeColorAndContainerBorderColorReturnOrders;
      icon = Icons.restore;
      orderState = "راجع";
    } else if (widget.order.isReceived == true) {
      color = KBadgeColorAndContainerBorderColorRecipientOrder;
      icon = Icons.assignment_turned_in_outlined;
      orderState = "تم استلامه";
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
                                cityID = snapshot.data.toString();
                                print(cityID);
                                return Text(
                                  "",
                                );
                              }),
                          FutureBuilder<String>(
                              future: CityService(uid: cityID).cityName,
                              builder: (context, snapshot) {
                                print(cityID);
                                if (snapshot.data == null) {
                                  return Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text(
                                    "${snapshot.data.toString()}-" ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                }
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
