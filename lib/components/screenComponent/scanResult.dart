import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:flutter/scheduler.dart';
import './rightChild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase/flutter_showcase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../constants.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';

@immutable
// ignore: must_be_immutable
class ShowcaseDeliveryTimeline extends StatefulWidget {
  final String name;
  ShowcaseDeliveryTimeline({this.name});

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
            _Header(),
            Expanded(
              child: StreamBuilder<Order>(
                stream: OrderServices(uid: '3mpwR4vYrH7bOeU3CZzv').orderByID,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Order order = snapshot.data;
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
                      orderState['isReceived'] = 'active';
                      orderState['inStock'] = 'disable';
                      orderState['isDelivery'] = 'disable';
                      orderState['isDone'] = 'disable';
                      orderState['isPaid'] = 'disable';
                      orderState['isCancelld'] = 'none';
                      orderState['isReturn'] = 'none';
                    } else if (order.isReturn == true) {
                      currentState = "isReturn";
                      orderState['isloading'] = 'Done';
                      orderState['isReceived'] = 'active';
                      orderState['inStock'] = 'disable';
                      orderState['isDelivery'] = 'disable';
                      orderState['isDone'] = 'disable';
                      orderState['isPaid'] = 'disable';
                      orderState['isCancelld'] = 'none';
                      orderState['isReturn'] = 'none';
                    }

                    print(currentState);
                    return Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            isFirst: true,
                            indicatorStyle: IndicatorStyle(
                              width: 20,
                              color: orderState['isloading'] == 'disable'
                                  ? Color(0xFFDADADA)
                                  : KBadgeColorAndContainerBorderColorLoadingOrder,
                              padding: EdgeInsets.all(6),
                            ),
                            endChild: RightChild(
                              disabled: orderState['isloading'] == 'disable'
                                  ? true
                                  : false,
                              active: orderState['isloading'] == 'active'
                                  ? true
                                  : false,
                              title: 'الطرد المحمل',
                              message: 'اسم الشركة',
                              dateTime: order.isLoadingDate,
                              currentState: currentState,
                              orderState: orderState["isloading"] + "loading",
                            ),
                            beforeLineStyle: LineStyle(
                              color: orderState['isloading'] == 'disable'
                                  ? Color(0xFFDADADA)
                                  : orderState['isloading'] == 'active'
                                      ? Color(0xFFDADADA)
                                      : KBadgeColorAndContainerBorderColorLoadingOrder,
                            ),
                          ),
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
                              message: '',
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
                          TimelineTile(
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
                              disabled: orderState['inStock'] == 'disable'
                                  ? true
                                  : false,
                              active: orderState['inStock'] == 'active'
                                  ? true
                                  : false,
                              title: 'في المخزن',
                              message: '',
                              dateTime: order.inStockDate,
                              currentState: currentState,
                              orderState: orderState["inStock"] + "inStock",
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
                          ),
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
                              message: '',
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
                          TimelineTile(
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
                              message: '',
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
                          TimelineTile(
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
                              message: '',
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
                          TimelineTile(
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
                              disabled: true,
                              title: 'طرد راجع',
                              message: '',
                              dateTime: order.isReturnDate,
                              currentState: currentState,
                              orderState: orderState["isReturn"] + "isReturn",
                            ),
                            beforeLineStyle: LineStyle(
                              color:
                                  KBadgeColorAndContainerBorderColorReturnOrders,
                            ),
                          ),
                          TimelineTile(
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
                              disabled: true,
                              title: 'طرد ملغي',
                              message: '',
                              dateTime: order.isCancelldDate,
                              currentState: currentState,
                              orderState:
                                  orderState["isCancelld"] + "isCancelld",
                            ),
                            beforeLineStyle: LineStyle(
                              color:
                                  KBadgeColorAndContainerBorderColorCancelledOrders,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text("Loading ...");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
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
                    'ORDER NUMBER',
                    style: GoogleFonts.yantramanav(
                      color: const Color(0xFFA2A2A2),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '#2482011',
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
