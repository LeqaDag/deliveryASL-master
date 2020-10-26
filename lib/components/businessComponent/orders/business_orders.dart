import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/services/customerServices.dart';

import '../../../constants.dart';

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
          return CustomCompanyOrdersStatus(order: orders[index]);
        });
  }
}

class CustomCompanyOrdersStatus extends StatefulWidget {
  final Order order;
  final String orderState;

  CustomCompanyOrdersStatus({this.order, this.orderState});

  @override
  _CustomCompanyOrdersStatusState createState() =>
      _CustomCompanyOrdersStatusState();
}

class _CustomCompanyOrdersStatusState extends State<CustomCompanyOrdersStatus> {
  Color color;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (widget.order.isCancelld == true)
      color = KBadgeColorAndContainerBorderColorCancelledOrders;
    else if (widget.order.isDelivery == true)
      color = KAllOrdersListTileColor;
    else if (widget.order.isDone == true)
      color = KBadgeColorAndContainerBorderColorReadyOrders;
    else if (widget.order.isLoading == true)
      color = KBadgeColorAndContainerBorderColorLoadingOrder;
    else if (widget.order.isUrgent == true)
      color = KBadgeColorAndContainerBorderColorUrgentOrders;
    else if (widget.order.isReturn == true)
      color = KBadgeColorAndContainerBorderColorReturnOrders;
    else if (widget.order.isReceived == true)
      color = KBadgeColorAndContainerBorderColorRecipientOrder;

    return InkWell(
      child: Container(
          width: width - 50,
          height: 100,
          child: Card(
            elevation: 5,
            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            //color: KCustomCompanyOrdersStatus,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: width / 2,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            //3
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                    bottom: height * 0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.blueGrey,
                                ),
                              ),

                              //  SizedBox(width: 33,),
                              FutureBuilder<String>(
                                  future: CustomerService(
                                          uid: widget.order.customerID)
                                      .customerName,
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Amiri",
                                      ),
                                    );
                                  }),
                            ],
                          ),
                          Row(
                            //3
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                    bottom: height * 0),
                                child: Icon(
                                  Icons.date_range,
                                  color: Colors.blueGrey,
                                ),
                              ),

                              //  SizedBox(width: 33,),
                              Text(
                                widget.order.description,
                                // DateFormat('yyyy-MM-dd').format(order.date),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Amiri",
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            //3
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                    bottom: height * 0),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.blueGrey,
                                ),
                              ),

                              //  SizedBox(width: 33,),

                              FutureBuilder<String>(
                                  future: CustomerService(
                                          uid: widget.order.customerID)
                                      .customerAdress,
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Amiri",
                                      ),
                                    );
                                  }),
                            ],
                          ),
                          Row(
                            //3
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: height * 0.025,
                                    right: height * 0.025,
                                    top: height * 0,
                                    bottom: height * 0),
                                child: Image.asset('assets/price.png'),
                              ),

                              //  SizedBox(width: 33,),
                              Text(
                                widget.order.price.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Amiri",
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            width: 20,
                            height: 77,
                            child: Card(
                              color: color,

                              ///case color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          )),
    );
  }
}
