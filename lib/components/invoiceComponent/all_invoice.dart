import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/services/businessServices.dart';
import 'package:sajeda_app/services/orderServices.dart';

import '../../constants.dart';

class AllInvoice extends StatelessWidget {
  final Color color;
  final Function onTapBox;
  final String businessId, name;

  AllInvoice({
    @required this.color,
    @required this.onTapBox,
    @required this.businessId,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // FirebaseFirestore.instance
    //     .collection('invoice')
    //     .where('businessID', isEqualTo: businessId)
    //     .where('isArchived', isEqualTo: false)
    //     .get()
    //     .then((value) => value.docs);
    // print(FirebaseFirestore.instance
    //     .collection('invoice')
    //     .where('businessID', isEqualTo: businessId)
    //     .where('isArchived', isEqualTo: false)
    //     .get()
    //     .then((value) => value.docs[0]["totalPrice"]));
    //print(businessId);
    return StreamBuilder<Business>(
        stream: BusinessService(uid: businessId).businessByID,
        builder: (context, snapshot) {
          //print(snapshot.data);
          if (snapshot.hasData) {
            Business business = snapshot.data;
            return Card(
              elevation: 5,
              margin: EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                Row(children: <Widget>[
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
                                  Icons.account_circle,
                                  color: KEditIconColor,
                                  size: 35,
                                ),
                              ),
                              Text(
                                business.name,
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
                                    left: height * 0.015,
                                    right: height * 0.015,
                                    top: height * 0,
                                    bottom: height * 0),
                                child: Icon(
                                  Icons.date_range,
                                  color: Colors.blueGrey,
                                ),
                              ),
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
                              // FutureBuilder<String>(
                              //     future:
                              //         InvoiceService(businessId: business.uid)
                              //             .totalPrice,
                              //     builder: (context, snapshot) {
                              //       return Text(
                              //         snapshot.data ?? "",
                              //         style: TextStyle(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.bold,
                              //           fontFamily: "Amiri",
                              //         ),
                              //       );
                              //     }),
                            ],
                          ),
                        ]),
                  ),
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Positioned(
                              child: Container(
                                width: width - 2,
                                height: 9,
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
                Row(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
                  Container(
                    width: width - 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.done,
                          color: KBadgeColorAndContainerBorderColorReadyOrders,
                        ),
                        FutureBuilder<int>(
                            future: OrderService(businesID: businessId)
                                .countBusinessOrderByStateOrder("isDone"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Text(
                                ":${snapshot.data.toString()} " ?? "0",
                              );
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.restore,
                          color: KBadgeColorAndContainerBorderColorReturnOrders,
                        ),
                        FutureBuilder<int>(
                            future: OrderService(businesID: businessId)
                                .countBusinessOrderByStateOrder("isReturn"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Text(
                                ":${snapshot.data.toString()} " ?? "0",
                              );
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.cancel,
                          color:
                              KBadgeColorAndContainerBorderColorCancelledOrders,
                        ),
                        FutureBuilder<int>(
                            future: OrderService(businesID: businessId)
                                .countBusinessOrderByStateOrder("isCancelld"),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Text(
                                ":${snapshot.data.toString()} " ?? "0",
                              );
                            }),
                      ],
                    ),
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
              ]),
              //color: KCustomCompanyOrdersStatus,
              // child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: <Widget>[
              //       Container(
              //         width: width / 2,
              //         child: Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceAround,
              //             children: <Widget>[
              //               Row(
              //                 //3
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: <Widget>[
              //                   Padding(
              //                     padding: EdgeInsets.only(
              //                         left: height * 0.025,
              //                         right: height * 0.025,
              //                         top: height * 0,
              //                         bottom: height * 0),
              //                     child: Icon(
              //                       Icons.circle,
              //                       color: KEditIconColor,
              //                       size: 35,
              //                     ),
              //                   ),
              //                   FutureBuilder<String>(
              //                       future:
              //                           BusinessService(uid: invoice.businessID)
              //                               .businessName,
              //                       builder: (context, snapshot) {
              //                         return Text(
              //                           snapshot.data ?? "",
              //                           style: TextStyle(
              //                             fontSize: 16,
              //                             fontWeight: FontWeight.bold,
              //                             fontFamily: "Amiri",
              //                           ),
              //                         );
              //                       }),
              //                 ],
              //               ),
              //             ]),
              //       ),
              //       Container(
              //         child: Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceAround,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: <Widget>[
              //               Row(
              //                 //3
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: <Widget>[
              //                   Padding(
              //                     padding: EdgeInsets.only(
              //                         left: height * 0.015,
              //                         right: height * 0.015,
              //                         top: height * 0,
              //                         bottom: height * 0),
              //                     child: Icon(
              //                       Icons.location_on,
              //                       color: Colors.blueGrey,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Row(
              //                 //3
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: <Widget>[
              //                   Padding(
              //                     padding: EdgeInsets.only(
              //                         left: height * 0.025,
              //                         right: height * 0.025,
              //                         top: height * 0,
              //                         bottom: height * 0),
              //                     child: Image.asset('assets/price.png'),
              //                   ),

              //                   //  SizedBox(width: 33,),
              //                   Text(
              //                     "hola",
              //                     style: TextStyle(
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.bold,
              //                       fontFamily: "Amiri",
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ]),
              //       ),
              //       Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: <Widget>[
              //             Container(
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: <Widget>[
              //                   Positioned(
              //                     child: Container(
              //                       width: 20,
              //                       height: 77,
              //                       child: Card(
              //                         color: color,

              //                         ///case color
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ]),
              //       SizedBox(
              //         height: 50,
              //       ),
              //     ]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
