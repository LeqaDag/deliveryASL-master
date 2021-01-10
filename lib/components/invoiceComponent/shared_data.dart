import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/cityServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/deliveryStatusServices.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class DriverName extends StatelessWidget {
  Order order;

  DriverName({this.order});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: DriverServices(uid: order.driverID).driverName,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "",
            );
          } else {
            return Expanded(
                child: Text(
              " السائق : ${snapshot.data.toString()} " ?? "",
              style: new TextStyle(
                fontSize: 13.0,
                color: Color(0xFF457B9D),
              ),
            ));
          }
        });
  }
}

// ignore: must_be_immutable
class DriverPhoneNumber extends StatelessWidget {
  Order order;

  DriverPhoneNumber({this.order});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: DriverServices(uid: order.driverID).driverPhone,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "",
            );
          } else {
            return InkWell(
              child: Expanded(
                  child: Text(
                " ${snapshot.data.toString()} " ?? "",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Amiri",
                ),
              )),
              onTap: () {
                launch("tel:" +
                    Uri.encodeComponent('0${snapshot.data.toString()}'));
              },
            );
          }
        });
  }
}

// ignore: must_be_immutable
class BisunessrName extends StatelessWidget {
  Order order;

  BisunessrName({this.order});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: BusinessServices(uid: order.businesID).businessName,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "",
            );
          } else {
            return Expanded(
                child: Text(
              "${snapshot.data.toString()} " ?? "",
              style: new TextStyle(
                fontSize: 13.0,
                color: Color(0xFF457B9D),
                fontWeight: FontWeight.bold,
              ),
            ));
          }
        });
  }
}

// ignore: must_be_immutable
class CustomerName extends StatelessWidget {
  Order order;

  CustomerName({this.order});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: CustomerServices(uid: order.customerID).customerName,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "",
            );
          } else {
            return Expanded(
                child: Text(
              "${snapshot.data.toString()} " ?? "",
              style: new TextStyle(
                fontSize: 13.0,
                color: Color(0xFF457B9D),
                fontWeight: FontWeight.bold,
              ),
            ));
          }
        });
  }
}

// ignore: must_be_immutable
class CustomerCityName extends StatelessWidget {
  Order order;

  CustomerCityName({this.order});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: CustomerServices(uid: order.customerID).customerCity,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "",
            );
          } else {
            return Expanded(
                child: Text(
              "${snapshot.data.toString()} /" ?? "",
            ));
          }
        });
  }
}

// ignore: must_be_immutable
class CustomerSublineName extends StatelessWidget {
  Order order;

  CustomerSublineName({this.order});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: CustomerServices(uid: order.customerID).customerSublineName,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "",
            );
          } else {
            return Expanded(
                child: Text(
              "${snapshot.data.toString()} " ?? "",
            ));
          }
        });
  }
}

// ignore: must_be_immutable
class CustomerCityAndSublineName extends StatelessWidget {
  Order order;

  CustomerCityAndSublineName({this.order});
  @override
  Widget build(BuildContext context) {
    String cityName;
    return FutureBuilder<String>(
        future: CustomerServices(uid: order.customerID).customerCity,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "",
            );
          } else {
            cityName = snapshot.data.toString();
            return FutureBuilder<String>(
              future:
                  CustomerServices(uid: order.customerID).customerSublineName,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    "",
                  );
                } else {
                  return Expanded(
                      child: Text(
                    "$cityName / ${snapshot.data.toString()} " ?? "",
                  ));
                }
              },
            );
          }
        });
  }
}

// ignore: must_be_immutable
class CustomerAddressName extends StatelessWidget {
  Order order;

  CustomerAddressName({this.order});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: CustomerServices(uid: order.customerID).customerAdress,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "",
            );
          } else {
            return Expanded(
                child: Text(
              "${snapshot.data.toString()} " ?? "",
            ));
          }
        });
  }
}

// ignore: must_be_immutable
class DeliveryNote extends StatelessWidget {
  Order order;

  DeliveryNote({this.order});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: DeliveriesStatusServices(orderID: order.uid).deliveryStatusNote,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "",
            );
          } else {
            return Expanded(
                child: Text(
              "${snapshot.data.toString()} " ?? "",
            ));
          }
        });
  }
}

// ignore: must_be_immutable
class DeliveryStatus extends StatelessWidget {
  Order order;

  DeliveryStatus({this.order});
  @override
  Widget build(BuildContext context) {
    String status, statusString;
    return FutureBuilder<String>(
        future: DeliveriesStatusServices(orderID: order.uid).deliveryStatus,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "",
            );
          } else {
            status = snapshot.data;
            if (status == "1") {
              statusString = "تم التوصيل";
            } else if (status == "2") {
              statusString = " لم يتم الرد على الهاتف";
            } else if (status == "3") {
              statusString = " تم التوصيل مع تغيير السعر";
            } else if (status == "4") {
              statusString = " ملغية بسبب خطأ في المنتج";
            } else if (status == "5") {
              statusString = "ملغية لاسباب شخصية ";
            } else if (status == "6") {
              statusString = "ملغية لاسباب أخرى ";
            } else if (status == "7") {
              statusString = "راجعة بسبب خطأ في المنتج ";
            } else if (status == "8") {
              statusString = "راجعة لاسباب شخصية ";
            } else if (status == "9") {
              statusString = " راجعة لاسباب أخرى";
            } else if (status == "10") {
              statusString = "مؤجلة ";
            } else if (status == "11") {
              statusString = "تم فقدان الطرد ";
            } else if (status == "12") {
              statusString = "ارجاع الى المخزن ";
            }
            print(statusString);
            return Expanded(
                child: Text(
              statusString,
            ));
          }
        });
  }
}

// ignore: must_be_immutable
class OrderCountByState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Order> orders;
    int total;

    return Row(children: <Widget>[
      Container(
          width: width - 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: height * 0.005,
                          right: height * 0.025,
                          top: height * 0,
                          bottom: height * 0),
                      child: Image.asset(
                        'assets/price.png',
                        scale: 1.5,
                      ),
                    ),
                    StreamBuilder<List<Order>>(
                        stream: OrderServices().allOrders(),
                        builder: (context, snapshot) {
                          int totalPrice = 0;
                          if (!snapshot.hasData) {
                            return Text('جاري التحميل ... ');
                          } else {
                            orders = snapshot.data;
                            orders.forEach((element) {
                              if (element.isPaid == false) {
                                totalPrice += element.totalPrice;
                                total = totalPrice;
                              }
                            });
                            return Text(
                              totalPrice.toString(),
                            );
                          }
                        }),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.done,
                      color: KBadgeColorAndContainerBorderColorReadyOrders,
                    ),
                    FutureBuilder<int>(
                        future: OrderServices().orderDone,
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
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.restore,
                      color: KBadgeColorAndContainerBorderColorReturnOrders,
                    ),
                    FutureBuilder<int>(
                        future: OrderServices().orderReturn,
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
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.cancel,
                      color: KBadgeColorAndContainerBorderColorCancelledOrders,
                    ),
                    FutureBuilder<int>(
                        future: OrderServices().orderCancelld,
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
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.business_center_outlined,
                      color: KAllOrdersListTileColor,
                    ),
                    FutureBuilder<int>(
                        future: OrderServices().orderDelivery,
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
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.assignment_turned_in_outlined,
                      color: KBadgeColorAndContainerBorderColorRecipientOrder,
                    ),
                    FutureBuilder<int>(
                        future: OrderServices().orderReceived,
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
                  ]),
            ],
          ))
    ]);
  }
}

// ignore: must_be_immutable
class OrderCountByStateDriver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Order> orders;

    int total;

    return Row(children: <Widget>[
      Container(
          width: width - 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: height * 0.005,
                          right: height * 0.025,
                          top: height * 0,
                          bottom: height * 0),
                      child: Image.asset(
                        'assets/price.png',
                        scale: 1.5,
                      ),
                    ),
                    StreamBuilder<List<Order>>(
                        stream: OrderServices().allDoneOrders(),
                        builder: (context, snapshot) {
                          int totalPrice = 0;
                          if (!snapshot.hasData) {
                            return Text('جاري التحميل ... ');
                          } else {
                            orders = snapshot.data;
                            orders.forEach((element) {
                              if (element.isPaid == false) {
                                totalPrice += element.totalPrice;
                                total = totalPrice;
                              }
                            });
                            return Text(
                              totalPrice.toString(),
                            );
                          }
                        }),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: height * 0.005,
                          right: height * 0.025,
                          top: height * 0,
                          bottom: height * 0),
                      child: Image.asset(
                        'assets/price.png',
                        scale: 1.5,
                      ),
                    ),
                    StreamBuilder<List<Order>>(
                        stream: OrderServices().allDoneOrders(),
                        builder: (context, snapshot) {
                          int totalPrice = 0;
                          if (!snapshot.hasData) {
                            return Text('جاري التحميل ... ');
                          } else {
                            orders = snapshot.data;
                            orders.forEach((element) {
                              if (element.isPaid == false) {
                                totalPrice += element.totalPrice;
                                total = totalPrice;
                              }
                            });
                            return Text(
                              totalPrice.toString(),
                            );
                          }
                        }),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.done,
                      color: KBadgeColorAndContainerBorderColorReadyOrders,
                    ),
                    FutureBuilder<int>(
                        future: OrderServices().orderDone,
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
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.restore,
                      color: KBadgeColorAndContainerBorderColorReturnOrders,
                    ),
                    FutureBuilder<int>(
                        future: OrderServices().orderReturn,
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
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.cancel,
                      color: KBadgeColorAndContainerBorderColorCancelledOrders,
                    ),
                    FutureBuilder<int>(
                        future: OrderServices().orderCancelld,
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
                  ]),
            ],
          ))
    ]);
  }
}

// ignore: must_be_immutable
class BusinessCityName extends StatelessWidget {
  Business business;

  BusinessCityName({this.business});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: CityServices(uid: business.cityID).cityName,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "",
            );
          } else {
            return Expanded(
                child: Text(
              "${snapshot.data.toString()} " ?? "",
            ));
          }
        });
  }
}

// ignore: must_be_immutable
class OrderCountByBusiness extends StatelessWidget {
  Business business;

  OrderCountByBusiness({this.business});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          Icons.done,
          color: KBadgeColorAndContainerBorderColorReadyOrders,
        ),
        FutureBuilder<int>(
            future: OrderServices(businesID: business.uid)
                .countBusinessOrderByStateOrder("isDone1"),
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
            })]),
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          Icons.restore,
          color: KBadgeColorAndContainerBorderColorReturnOrders,
        ),
        FutureBuilder<int>(
            future: OrderServices(businesID: business.uid)
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
            })]),
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          Icons.cancel,
          color: KBadgeColorAndContainerBorderColorCancelledOrders,
        ),
        FutureBuilder<int>(
            future: OrderServices(businesID: business.uid)
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
            })]),
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          Icons.business_center_outlined,
          color: KAllOrdersListTileColor,
        ),
        FutureBuilder<int>(
            future: OrderServices(businesID: business.uid)
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
            })]),
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          Icons.arrow_circle_up_rounded,
          color: KBadgeColorAndContainerBorderColorLoadingOrder,
        ),
        FutureBuilder<int>(
            future: OrderServices(businesID: business.uid)
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
            })]),
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(
          Icons.assignment_turned_in_outlined,
          color: KBadgeColorAndContainerBorderColorRecipientOrder,
        ),
        FutureBuilder<int>(
            future: OrderServices(businesID: business.uid)
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
            })]),
      ],
    );
  }
}
