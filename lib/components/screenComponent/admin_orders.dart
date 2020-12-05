import 'package:flutter/material.dart';
import 'package:sajeda_app/components/orderComponent/store_add_new_order.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/components/pages/loadingData.dart';
import 'package:sajeda_app/services/orderServices.dart';
import 'pending_orders.dart';
import 'pickup_orders.dart';
import 'ready_orders.dart';
import 'return_orders.dart';
import 'urgent_orders.dart';

import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';
import '../../constants.dart';
import 'delivery_orders.dart';
import 'canceled_orders.dart';
import 'inStock_orders.dart';

class AdminOrders extends StatelessWidget {
  final String name;
  AdminOrders({this.name});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder<List<int>>(
        future: Future.wait([
          OrderServices().orderLoading,
          OrderServices().orderReceived,
          OrderServices().orderUrgent,
          OrderServices().orderCancelld,
          OrderServices().orderDone,
          OrderServices().orderDelivery,
          OrderServices().orderReturn,
          OrderServices().orderInStock,
        ]),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            int orderLoading = snapshot.data[0] ?? -1;
            int orderReceived = snapshot.data[1] ?? -1;
            int orderUrgent = snapshot.data[2] ?? -1;
            int orderCancelld = snapshot.data[3] ?? -1;
            int orderDone = snapshot.data[4] ?? -1;
            int orderDelivery = snapshot.data[5] ?? -1;
            int orderReturn = snapshot.data[6] ?? -1;
            int orderInStock = snapshot.data[7] ?? -1;
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("الطرود",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: 'Amiri',
                      )),
                  backgroundColor: kAppBarColor,
                  centerTitle: true,
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewOders(name: name)),
                        );
                      },
                      icon: Icon(Icons.add),
                      color: Colors.white,
                    )
                  ],
                ),
                drawer: AdminDrawer(name: name),
                body: ListView(
                  padding: EdgeInsets.only(top: height * 0.03),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomContainerOrders(
                          width: 0.37,
                          height: 0.17,
                          imagepath: AssetImage("assets/LoadedOrders.png"),
                          text: "الطرود المحملة",
                          badgeColorAndContainerBorderColor:
                              KBadgeColorAndContainerBorderColorLoadingOrder,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PendingOrders(name: name)),
                            );
                          },
                          count: orderLoading.toString(),
                        ),
                        CustomContainerOrders(
                            width: 0.37,
                            height: 0.17,
                            imagepath: AssetImage("assets/RecipientOrder.png"),
                            text: "الطرود المستلمة",
                            badgeColorAndContainerBorderColor:
                                KBadgeColorAndContainerBorderColorRecipientOrder,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PickupOrders(name: name)),
                              );
                            },
                            count: orderReceived.toString()),
                      ],
                    ),
                    CustomBoxSize(height: 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomContainerOrders(
                            width: 0.37,
                            height: 0.17,
                            imagepath: AssetImage("assets/orderStore.png"),
                            text: "في المخزن",
                            badgeColorAndContainerBorderColor:
                                KBadgeColorAndContainerBorderColorWithDriverOrders,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      InStockOrders(name: name),
                                ),
                              );
                            },
                            count: orderInStock.toString()),
                        CustomContainerOrders(
                            width: 0.37,
                            height: 0.17,
                            imagepath: AssetImage("assets/AllOrders.png"),
                            text: "الطرود الموزعة",
                            badgeColorAndContainerBorderColor:
                                KBadgeColorAndContainerBorderColorAllOrder,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AllOrders(name: name)),
                              );
                            },
                            count: orderDelivery.toString()),
                      ],
                    ),
                    CustomBoxSize(height: 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomContainerOrders(
                            width: 0.37,
                            height: 0.17,
                            imagepath: AssetImage("assets/ReadyOrders.png"),
                            text: "طرود تم توصيلها",
                            badgeColorAndContainerBorderColor:
                                KBadgeColorAndContainerBorderColorReadyOrders,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReadyOrders(name: name)),
                              );
                            },
                            count: orderDone.toString()),
                        CustomContainerOrders(
                            width: 0.37,
                            height: 0.17,
                            imagepath: AssetImage("assets/UrgentOrders.png"),
                            text: "الطرود المستعجلة",
                            badgeColorAndContainerBorderColor:
                                KBadgeColorAndContainerBorderColorUrgentOrders,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UrgentOrders(name: name)),
                              );
                            },
                            count: orderUrgent.toString()),
                      ],
                    ),
                    CustomBoxSize(height: 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomContainerOrders(
                            width: 0.37,
                            height: 0.17,
                            imagepath: AssetImage("assets/ReturnOrders.png"),
                            text: "الطرود الراجعة",
                            badgeColorAndContainerBorderColor:
                                KBadgeColorAndContainerBorderColorReturnOrders,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReturnOrders(name: name)),
                              );
                            },
                            count: orderReturn.toString()),
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: CustomContainerOrders(
                              width: 0.37,
                              height: 0.17,
                              imagepath:
                                  AssetImage("assets/CancelledOrders.png"),
                              text: "الطرود الملغية",
                              badgeColorAndContainerBorderColor:
                                  KBadgeColorAndContainerBorderColorCancelledOrders,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CanceledOrders(name: name)),
                                );
                              },
                              count: orderCancelld.toString()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return LoadingData();
          }
        });
  }
}
