import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase/flutter_showcase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../constants.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';

class ShowcaseDeliveryTimeline extends StatelessWidget {
  final String name;
  ShowcaseDeliveryTimeline({this.name});
  bool orderStateisloading = false;
  bool orderStateisReceived = false;
  bool orderStateinStock = false;
  bool orderStateisDelivery = false;
  bool orderStateisDone = false;
  bool orderStateisPaid = false;
  bool orderStateisCancelld = false;
  bool orderStateisReturn = false;
  @override
  Widget build(BuildContext context) {
    // Map<String, bool> orderState = {
    //   'isloading': false,
    //   'isReceived': false,
    //   'inStock': false,
    //   'isDelivery': false,
    //   'isCancelld': false,
    //   'isReturn': false,
    //   'isDone': false,
    //   'isPaid': false,
    // };

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
          textDirection: TextDirection.rtl, child: AdminDrawer(name: name)),
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
                 Order order = snapshot.data;
                  print(order.curentState);
                  _setOrderState(
                    order,
                  );
                  print(orderStateisReceived);

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
                            color:
                                KBadgeColorAndContainerBorderColorLoadingOrder,
                            padding: EdgeInsets.all(6),
                          ),
                          endChild: _RightChild(
                            title: 'الطرد المحمل',
                            message: 'اسم الشركة',
                          ),
                          beforeLineStyle: LineStyle(
                            color:
                                KBadgeColorAndContainerBorderColorLoadingOrder,
                          ),
                        ),
                        orderStateisReceived
                            ? TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0.1,
                                indicatorStyle: IndicatorStyle(
                                  width: 20,
                                  color:
                                      KBadgeColorAndContainerBorderColorRecipientOrder,
                                  padding: EdgeInsets.all(6),
                                ),
                                endChild: _RightChild(
                                    // disabled: orderStateisReceived,
                                    title: 'تم الإستلام',
                                    message: '',
                                    dateTime: order.isLoadingDate),
                                beforeLineStyle: LineStyle(
                                  color:
                                      KBadgeColorAndContainerBorderColorRecipientOrder,
                                ),
                              )
                            : TimelineTile(
                                alignment: TimelineAlign.manual,
                                lineXY: 0.1,
                                indicatorStyle: IndicatorStyle(
                                  width: 20,
                                  color:
                                      KBadgeColorAndContainerBorderColorRecipientOrder,
                                  padding: EdgeInsets.all(6),
                                ),
                                endChild: _RightChild(
                                  // disabled: orderStateisReceived,
                                  title: 'تم الإستلام',
                                  message: '',
                                ),
                                beforeLineStyle: LineStyle(
                                  color:
                                      KBadgeColorAndContainerBorderColorRecipientOrder,
                                ),
                              ),
                        TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.1,
                          indicatorStyle:  IndicatorStyle(
                            width: 20,
                            color:
                                KBadgeColorAndContainerBorderColorWithDriverOrders,
                            padding: EdgeInsets.all(6),
                          ),
                          endChild:  _RightChild(
                            title: 'في المخزن',
                            message: '',
                          ),
                          beforeLineStyle:  LineStyle(
                            color:
                                KBadgeColorAndContainerBorderColorWithDriverOrders,
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.1,
                          indicatorStyle:  IndicatorStyle(
                            width: 20,
                            color: KBadgeColorAndContainerBorderColorAllOrder,
                            padding: EdgeInsets.all(6),
                          ),
                          endChild:  _RightChild(
                            title: 'مع السائق',
                            message: '',
                          ),
                          beforeLineStyle:  LineStyle(
                            color: KBadgeColorAndContainerBorderColorAllOrder,
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.1,
                          indicatorStyle:  IndicatorStyle(
                            width: 20,
                            color:
                                KBadgeColorAndContainerBorderColorReadyOrders,
                            padding: EdgeInsets.all(6),
                          ),
                          endChild:  _RightChild(
                            title: 'تم التوصيل',
                            message: '',
                          ),
                          beforeLineStyle:  LineStyle(
                            color:
                                KBadgeColorAndContainerBorderColorReadyOrders,
                          ),
                          afterLineStyle:  LineStyle(
                            color:
                                KBadgeColorAndContainerBorderColorReadyOrders,
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.1,
                          indicatorStyle:  IndicatorStyle(
                            width: 20,
                            color:
                                KBadgeColorAndContainerBorderColorReturnOrders,
                            padding: EdgeInsets.all(6),
                          ),
                          endChild:  _RightChild(
                            disabled: true,
                            title: 'طرد راجع',
                            message: '',
                          ),
                          beforeLineStyle:  LineStyle(
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
                          endChild:  _RightChild(
                            disabled: true,
                            title: 'طرد ملغي',
                            message: '',
                          ),
                          beforeLineStyle: LineStyle(
                            color:
                                KBadgeColorAndContainerBorderColorCancelledOrders,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setOrderState(Order order) {
    switch (order.curentState) {
      case 'isLoading':
        {
          // orderState['isloading'] = true;
          // orderState['isReceived'] = false;
          // orderState['inStock'] = false;
          // orderState['isDelivery'] = false;
          // orderState['isDone'] = false;
          // orderState['isPaid'] = false;
          // orderState['isCancelld'] = false;
          // orderState['isReturn'] = false;
          orderStateisloading = true;
          orderStateisReceived = false;
          orderStateinStock = false;
          orderStateisDelivery = false;
          orderStateisDone = false;
          orderStateisPaid = false;
          orderStateisCancelld = false;
          orderStateisReturn = false;
        }
        break;
      case 'isReceived':
        {
          // orderState['isloading'] = true;
          // orderState['isReceived'] = true;
          // orderState['inStock'] = false;
          // orderState['isDelivery'] = false;
          // orderState['isDone'] = false;
          // orderState['isPaid'] = false;
          // orderState['isCancelld'] = false;
          // orderState['isReturn'] = false;
          orderStateisloading = true;
          orderStateisReceived = true;
          orderStateinStock = false;
          orderStateisDelivery = false;
          orderStateisDone = false;
          orderStateisPaid = false;
          orderStateisCancelld = false;
          orderStateisReturn = false;
        }
        break;
      case 'inStock':
        {
          // orderState['isloading'] = true;
          // orderState['isReceived'] = true;
          // orderState['inStock'] = true;
          // orderState['isDelivery'] = false;
          // orderState['isDone'] = false;
          // orderState['isPaid'] = false;
          // orderState['isCancelld'] = false;
          // orderState['isReturn'] = false;
          orderStateisloading = true;
          orderStateisReceived = true;
          orderStateinStock = true;
          orderStateisDelivery = false;
          orderStateisDone = false;
          orderStateisPaid = false;
          orderStateisCancelld = false;
          orderStateisReturn = false;
        }
        break;
      case 'isCancelld':
        {
          // orderState['isloading'] = true;
          // orderState['isReceived'] = true;
          // orderState['inStock'] = true;
          // orderState['isDelivery'] = true;
          // orderState['isDone'] = false;
          // orderState['isPaid'] = false;
          // orderState['isCancelld'] = true;
          // orderState['isReturn'] = false;
          orderStateisloading = true;
          orderStateisReceived = true;
          orderStateinStock = true;
          orderStateisDelivery = true;
          orderStateisDone = false;
          orderStateisPaid = false;
          orderStateisCancelld = true;
          orderStateisReturn = false;
        }
        break;

      case 'isDelivery':
        {
          // orderState['isloading'] = true;
          // orderState['isReceived'] = true;
          // orderState['inStock'] = true;
          // orderState['isDelivery'] = true;
          // orderState['isDone'] = false;
          // orderState['isPaid'] = false;
          // orderState['isCancelld'] = false;
          // orderState['isReturn'] = false;
          orderStateisloading = true;
          orderStateisReceived = true;
          orderStateinStock = true;
          orderStateisDelivery = true;
          orderStateisDone = false;
          orderStateisPaid = false;
          orderStateisCancelld = false;
          orderStateisReturn = false;
        }
        break;
      case 'isDone':
        {
          // orderState['isloading'] = true;
          // orderState['isReceived'] = true;
          // orderState['inStock'] = true;
          // orderState['isDelivery'] = true;
          // orderState['isDone'] = true;
          // orderState['isPaid'] = false;
          // orderState['isCancelld'] = false;
          // orderState['isReturn'] = false;
          orderStateisloading = true;
          orderStateisReceived = true;
          orderStateinStock = true;
          orderStateisDelivery = true;
          orderStateisDone = true;
          orderStateisPaid = false;
          orderStateisCancelld = false;
          orderStateisReturn = false;
        }
        break;
      case 'isReturn':
        {
          // orderState['isloading'] = true;
          // orderState['isReceived'] = true;
          // orderState['inStock'] = true;
          // orderState['isDelivery'] = true;
          // orderState['isDone'] = false;
          // orderState['isPaid'] = false;
          // orderState['isCancelld'] = false;
          // orderState['isReturn'] = true;
          orderStateisloading = true;
          orderStateisReceived = true;
          orderStateinStock = true;
          orderStateisDelivery = true;
          orderStateisDone = false;
          orderStateisPaid = false;
          orderStateisCancelld = false;
          orderStateisReturn = true;
        }
        break;
      case 'isPaid':
        {
          // orderState['isloading'] = true;
          // orderState['isReceived'] = true;
          // orderState['inStock'] = true;
          // orderState['isDelivery'] = true;
          // orderState['isDone'] = true;
          // orderState['isPaid'] = false;
          // orderState['isCancelld'] = false;
          // orderState['isReturn'] = false;
          orderStateisloading = true;
          orderStateisReceived = true;
          orderStateinStock = true;
          orderStateisDelivery = true;
          orderStateisDone = true;
          orderStateisPaid = false;
          orderStateisCancelld = false;
          orderStateisReturn = false;
        }
        break;
      default:
        {
          return null;
        }
        break;
    }
  }
}

class _RightChild extends StatelessWidget {
   _RightChild({
    this.title,
    this.message,
    this.dateTime,
    this.disabled = false,
  }) ;

  final String title;
  final String message;
  final bool disabled;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               SizedBox(height: 6),
              Text(
                title,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ?  Color(0xFFBABABA)
                      :  Color(0xFF636564),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // SizedBox(height: 6),
              // Text(
              //   message,
              //   style: GoogleFonts.yantramanav(
              //     color: disabled
              //         ?  Color(0xFFD5D5D5)
              //         :  Color(0xFF636564),
              //     fontSize: 16,
              //   ),
              // ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               SizedBox(height: 6),
              Text(
                "10/10/2020",
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ?  Color(0xFFBABABA)
                      :  Color(0xFF636564),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
               SizedBox(height: 6),
              Text(
                "10:11 AM",
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ?  Color(0xFFD5D5D5)
                      :  Color(0xFF636564),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
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
