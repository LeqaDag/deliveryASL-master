import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/deliveryStatus.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/deliveryStatusServices.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:toast/toast.dart';
import './rightChild.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../constants.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';

@immutable
// ignore: must_be_immutable
class ShowcaseDeliveryTimeline extends StatefulWidget {
  final String name;
  final String barcode;
  ShowcaseDeliveryTimeline({this.name, this.barcode});

  @override
  _ShowcaseDeliveryTimelineState createState() =>
      _ShowcaseDeliveryTimelineState();
}

class _ShowcaseDeliveryTimelineState extends State<ShowcaseDeliveryTimeline> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currentState = "isloading";
    var orderState = {
      'isloading': 'acitve',
      'isReceived': 'disable',
      'inStock': 'disable',
      'isDelivery': 'disable',
      'isCancelld': 'none',
      'isReturn': 'none',
      'isDone': 'disable',
      'isPaid': 'disable',
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("تتبع الطرد",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Amiri',
            )),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      endDrawer: Directionality(
          textDirection: TextDirection.rtl,
          child: AdminDrawer(name: widget.name)),
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            _Header(barcode:widget.barcode),
            Expanded(
              child: StreamBuilder<List<Order>>(
                stream: OrderServices(barcode: widget.barcode).orderByBarcode,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.length > 0) {
                    Order order = snapshot.data[0];
                    if (order.isReceived == true) {
                      currentState = "isReceived";
                      orderState['isloading'] = 'Done';
                      orderState['isReceived'] = 'active';
                      orderState['inStock'] = 'disable';
                      orderState['isDelivery'] = 'disable';
                      orderState['isDone'] = 'disable';
                      orderState['isPaid'] = 'disable';
                      orderState['isCancelld'] = 'none';
                      orderState['isReturn'] = 'none';
                    } else if (order.inStock == true) {
                      currentState = "inStock";
                      orderState['isloading'] = 'Done';
                      orderState['isReceived'] = 'Done';
                      orderState['inStock'] = 'active';
                      orderState['isDelivery'] = 'disable';
                      orderState['isDone'] = 'disable';
                      orderState['isPaid'] = 'disable';
                      orderState['isCancelld'] = 'none';
                      orderState['isReturn'] = 'none';
                    } else if (order.isDelivery == true) {
                      currentState = "isDelivery";
                      orderState['isloading'] = 'Done';
                      orderState['isReceived'] = 'Done';
                      orderState['inStock'] = 'Done';
                      orderState['isDelivery'] = 'active';
                      orderState['isDone'] = 'disable';
                      orderState['isPaid'] = 'disable';
                      orderState['isCancelld'] = 'none';
                      orderState['isReturn'] = 'none';
                    } else if (order.isDone == true && order.isPaid == false) {
                      currentState = "isDone";
                      orderState['isloading'] = 'Done';
                      orderState['isReceived'] = 'Done';
                      orderState['inStock'] = 'Done';
                      orderState['isDelivery'] = 'Done';
                      orderState['isDone'] = 'active';
                      orderState['isPaid'] = 'disable';
                      orderState['isCancelld'] = 'none';
                      orderState['isReturn'] = 'none';
                    } else if (order.isPaid == true && order.isDone == true) {
                      currentState = "isPaid";
                      orderState['isloading'] = 'Done';
                      orderState['isReceived'] = 'Done';
                      orderState['inStock'] = 'Done';
                      orderState['isDelivery'] = 'Done';
                      orderState['isDone'] = 'Done';
                      orderState['isPaid'] = 'active';
                      orderState['isCancelld'] = 'none';
                      orderState['isReturn'] = 'none';
                    } else if (order.isCancelld == true) {
                      currentState = "isCancelld";
                      orderState['isloading'] = 'Done';
                      orderState['isReceived'] = 'Done';
                      orderState['inStock'] = 'Done';
                      orderState['isDelivery'] = 'Done';
                      orderState['isDone'] = 'disable';
                      orderState['isPaid'] = 'disable';
                      orderState['isCancelld'] = 'active';
                      orderState['isReturn'] = 'none';
                    } else if (order.isReturn == true) {
                      currentState = "isReturn";
                      orderState['isloading'] = 'Done';
                      orderState['isReceived'] = 'Done';
                      orderState['inStock'] = 'Done';
                      orderState['isDelivery'] = 'Done';
                      orderState['isDone'] = 'disable';
                      orderState['isPaid'] = 'disable';
                      orderState['isCancelld'] = 'none';
                      orderState['isReturn'] = 'active';
                    }

                    print(currentState);
                    return Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          StreamBuilder<Business>(
                              stream: BusinessServices(uid: order.businesID)
                                  .businessByID,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Business business = snapshot.data;

                                  return TimelineTile(
                                    alignment: TimelineAlign.manual,
                                    lineXY: 0.1,
                                    isFirst: true,
                                    indicatorStyle: IndicatorStyle(
                                      width: 20,
                                      color: orderState['isloading'] ==
                                              'disable'
                                          ? Color(0xFFDADADA)
                                          : KBadgeColorAndContainerBorderColorLoadingOrder,
                                      padding: EdgeInsets.all(6),
                                    ),
                                    endChild: RightChild(
                                      disabled:
                                          orderState['isloading'] == 'disable'
                                              ? true
                                              : false,
                                      active:
                                          orderState['isloading'] == 'active'
                                              ? true
                                              : false,
                                      title: 'الطرد المحمل',
                                      message: business.name,
                                      dateTime: order.isLoadingDate,
                                      currentState: currentState,
                                      orderState:
                                          orderState["isloading"] + "loading",
                                    ),
                                    beforeLineStyle: LineStyle(
                                      color: orderState['isloading'] ==
                                              'disable'
                                          ? Color(0xFFDADADA)
                                          : orderState['isloading'] == 'active'
                                              ? Color(0xFFDADADA)
                                              : KBadgeColorAndContainerBorderColorLoadingOrder,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            indicatorStyle: IndicatorStyle(
                              width: 20,
                              color: orderState['isReceived'] == 'disable'
                                  ? Color(0xFFDADADA)
                                  : KBadgeColorAndContainerBorderColorRecipientOrder,
                              padding: EdgeInsets.all(6),
                            ),
                            endChild: RightChild(
                              disabled: orderState['isReceived'] == 'disable'
                                  ? true
                                  : false,
                              active: orderState['isReceived'] == 'active'
                                  ? true
                                  : false,
                              title: 'تم الإستلام',
                              dateTime: order.isReceivedDate,
                              currentState: currentState,
                              orderState:
                                  orderState["isReceived"] + "isReceived",
                            ),
                            beforeLineStyle: LineStyle(
                              color: orderState['isReceived'] == 'disable'
                                  ? Color(0xFFDADADA)
                                  : KBadgeColorAndContainerBorderColorLoadingOrder,
                            ),
                            afterLineStyle: LineStyle(
                              color: orderState['isReceived'] == 'disable'
                                  ? Color(0xFFDADADA)
                                  : orderState['isReceived'] == 'active'
                                      ? Color(0xFFDADADA)
                                      : KBadgeColorAndContainerBorderColorRecipientOrder,
                            ),
                          ),
                          StreamBuilder<Driver>(
                              stream: DriverServices(uid: order.driverID)
                                  .driverByID,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Driver driver = snapshot.data;
                                  return TimelineTile(
                                    alignment: TimelineAlign.manual,
                                    lineXY: 0.1,
                                    indicatorStyle: IndicatorStyle(
                                      width: 20,
                                      color: orderState['inStock'] == 'disable'
                                          ? Color(0xFFDADADA)
                                          : KBadgeColorAndContainerBorderColorWithDriverOrders,
                                      padding: EdgeInsets.all(6),
                                    ),
                                    endChild: RightChild(
                                      disabled:
                                          orderState['inStock'] == 'disable'
                                              ? true
                                              : false,
                                      active: orderState['inStock'] == 'active'
                                          ? true
                                          : false,
                                      title: 'في المخزن',
                                      message: 'السائق : ${driver.name}',
                                      dateTime: order.inStockDate,
                                      currentState: currentState,
                                      orderState:
                                          orderState["inStock"] + "inStock",
                                    ),
                                    beforeLineStyle: LineStyle(
                                      color: orderState['inStock'] == 'disable'
                                          ? Color(0xFFDADADA)
                                          : KBadgeColorAndContainerBorderColorRecipientOrder,
                                    ),
                                    afterLineStyle: LineStyle(
                                      color: orderState['inStock'] == 'disable'
                                          ? Color(0xFFDADADA)
                                          : orderState['inStock'] == 'active'
                                              ? Color(0xFFDADADA)
                                              : KBadgeColorAndContainerBorderColorWithDriverOrders,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            indicatorStyle: IndicatorStyle(
                              width: 20,
                              color: orderState['isDelivery'] == 'disable'
                                  ? Color(0xFFDADADA)
                                  : KBadgeColorAndContainerBorderColorAllOrder,
                              padding: EdgeInsets.all(6),
                            ),
                            endChild: RightChild(
                              disabled: orderState['isDelivery'] == 'disable'
                                  ? true
                                  : false,
                              active: orderState['isDelivery'] == 'active'
                                  ? true
                                  : false,
                              title: 'مع السائق',
                              dateTime: order.isDeliveryDate,
                              currentState: currentState,
                              orderState:
                                  orderState["isDelivery"] + "isDelivery",
                            ),
                            beforeLineStyle: LineStyle(
                              color: orderState['isDelivery'] == 'disable'
                                  ? Color(0xFFDADADA)
                                  : KBadgeColorAndContainerBorderColorWithDriverOrders,
                            ),
                            afterLineStyle: LineStyle(
                              color: orderState['isDelivery'] == 'disable'
                                  ? Color(0xFFDADADA)
                                  : orderState['isDelivery'] == 'active'
                                      ? Color(0xFFDADADA)
                                      : KBadgeColorAndContainerBorderColorAllOrder,
                            ),
                          ),
                          orderState['isReturn'] == 'active' ||
                                  orderState['isCancelld'] == 'active'
                              ? Container()
                              : TimelineTile(
                                  alignment: TimelineAlign.manual,
                                  lineXY: 0.1,
                                  indicatorStyle: IndicatorStyle(
                                    width: 20,
                                    color: orderState['isDone'] == 'disable'
                                        ? Color(0xFFDADADA)
                                        : KBadgeColorAndContainerBorderColorReadyOrders,
                                    padding: EdgeInsets.all(6),
                                  ),
                                  endChild: RightChild(
                                    disabled: orderState['isDone'] == 'disable'
                                        ? true
                                        : false,
                                    active: orderState['isDone'] == 'active'
                                        ? true
                                        : false,
                                    title: 'تم التوصيل',
                                    dateTime: order.isDoneDate,
                                    currentState: currentState,
                                    orderState: orderState["isDone"] + "isDone",
                                  ),
                                  beforeLineStyle: LineStyle(
                                    color: orderState['isDone'] == 'disable'
                                        ? Color(0xFFDADADA)
                                        : KBadgeColorAndContainerBorderColorAllOrder,
                                  ),
                                  afterLineStyle: LineStyle(
                                    color: orderState['isDone'] == 'disable'
                                        ? Color(0xFFDADADA)
                                        : orderState['isDone'] == 'active'
                                            ? Color(0xFFDADADA)
                                            : KBadgeColorAndContainerBorderColorReadyOrders,
                                  ),
                                ),
                          orderState['isReturn'] == 'active' ||
                                  orderState['isCancelld'] == 'active'
                              ? Container()
                              : TimelineTile(
                                  alignment: TimelineAlign.manual,
                                  lineXY: 0.1,
                                  isLast: true,
                                  indicatorStyle: IndicatorStyle(
                                    width: 20,
                                    color: orderState['isPaid'] == 'disable'
                                        ? Color(0xFFDADADA)
                                        : KBadgeColorAndContainerBorderColorPaidOrders,
                                    padding: EdgeInsets.all(6),
                                  ),
                                  endChild: RightChild(
                                    disabled: orderState['isPaid'] == 'disable'
                                        ? true
                                        : false,
                                    active: orderState['isPaid'] == 'active'
                                        ? true
                                        : false,
                                    title: 'تم التحصيل',
                                    dateTime: order.isPaidDate,
                                    currentState: currentState,
                                    orderState: orderState["isPaid"] + "isPaid",
                                  ),
                                  beforeLineStyle: LineStyle(
                                    color: orderState['isPaid'] == 'disable'
                                        ? Color(0xFFDADADA)
                                        : orderState['isPaid'] == 'active'
                                            ? KBadgeColorAndContainerBorderColorReadyOrders
                                            : Color(0xFFDADADA),
                                  ),
                                ),
                          orderState['isReturn'] != 'none'
                              ? StreamBuilder<List<DeliveryStatus>>(
                                  stream: DeliveriesStatusServices(
                                          orderID: order.uid)
                                      .deliveryStatusData,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      DeliveryStatus deliveryStatus =
                                          snapshot.data[0];

                                      return TimelineTile(
                                        alignment: TimelineAlign.manual,
                                        lineXY: 0.1,
                                        isLast: true,
                                        indicatorStyle: IndicatorStyle(
                                          width: 20,
                                          color:
                                              KBadgeColorAndContainerBorderColorReturnOrders,
                                          padding: EdgeInsets.all(6),
                                        ),
                                        endChild: RightChild(
                                          disabled: orderState['isReturn'] ==
                                                  'disable'
                                              ? true
                                              : false,
                                          active:
                                              orderState['isReturn'] == 'active'
                                                  ? true
                                                  : false,
                                          title: 'طرد راجع',
                                          message: _orderState(
                                              deliveryStatus.status),
                                          dateTime: order.isReturnDate,
                                          currentState: currentState,
                                          orderState: orderState["isReturn"] +
                                              "isReturn",
                                        ),
                                        beforeLineStyle: LineStyle(
                                          color: orderState['isReturn'] ==
                                                  'disable'
                                              ? Color(0xFFDADADA)
                                              : orderState['isReturn'] ==
                                                      'active'
                                                  ? KBadgeColorAndContainerBorderColorAllOrder
                                                  : Color(0xFFDADADA),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  })
                              : Container(),
                          orderState['isCancelld'] != 'none'
                              ? StreamBuilder<List<DeliveryStatus>>(
                                  stream: DeliveriesStatusServices(
                                          orderID: order.uid)
                                      .deliveryStatusData,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      DeliveryStatus deliveryStatus =
                                          snapshot.data[0];
                                      return TimelineTile(
                                        alignment: TimelineAlign.manual,
                                        lineXY: 0.1,
                                        isLast: true,
                                        indicatorStyle: const IndicatorStyle(
                                          width: 20,
                                          color:
                                              KBadgeColorAndContainerBorderColorCancelledOrders,
                                          padding: EdgeInsets.all(6),
                                        ),
                                        endChild: RightChild(
                                          disabled: orderState['isCancelld'] ==
                                                  'disable'
                                              ? true
                                              : false,
                                          active: orderState['isCancelld'] ==
                                                  'active'
                                              ? true
                                              : false,
                                          title: 'طرد ملغي',
                                          message: _orderState(
                                              deliveryStatus.status),
                                          dateTime: order.isCancelldDate,
                                          currentState: currentState,
                                          orderState: orderState["isCancelld"] +
                                              "isCancelld",
                                        ),
                                        beforeLineStyle: LineStyle(
                                          color: orderState['isCancelld'] ==
                                                  'disable'
                                              ? Color(0xFFDADADA)
                                              : orderState['isCancelld'] ==
                                                      'active'
                                                  ? KBadgeColorAndContainerBorderColorAllOrder
                                                  : Color(0xFFDADADA),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  })
                              : Container(),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    Toast.show("هذا الطرد غير متوفر", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return Text("هذا الطرد غير متوفر");
                  } else {
                    Toast.show("DDDهذا الطرد غير متوفر", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    // return Text("ddddهذا الطرد غير متوفر");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _orderState(String status) {
    switch (status) {
      case '5':
        {
          return 'ملغية لاسباب شخصية';
        }
        break;
      case '6':
        {
          return 'ملغية لاسباب أخرى';
        }
        break;
      case '4':
        {
          return 'ملغية بسبب خطأ في المنتج';
        }
        break;
      case '7':
        {
          return 'راجعة بسبب خطأ في المنتج';
        }
        break;
      case '8':
        {
          return 'راجعة لاسباب شخصية';
        }
        break;
      case '9':
        {
          return 'راجعة لاسباب أخرى';
        }
        break;
      default:
        {
          return "لا يوجد ملاحظات";
        }
        break;
    }
  }
}

// ignore: must_be_immutable
class _Header extends StatelessWidget {
  String barcode;

  _Header({this.barcode});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE9E9E9),
            width: 3,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'رقم الطرد',
                    style: GoogleFonts.yantramanav(
                      color: const Color(0xFFA2A2A2),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    barcode,
                    style: GoogleFonts.yantramanav(
                      color: const Color(0xFF636564),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
