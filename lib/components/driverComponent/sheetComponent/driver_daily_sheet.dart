import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/driverComponent/sheetComponent/sheetList.dart';
import 'package:sajeda_app/components/pages/driver_drawer.dart';
import 'package:sajeda_app/services/driverServices.dart';
import 'package:sajeda_app/services/invoiceServices.dart';
import 'package:sajeda_app/services/orderServices.dart';

import '../../../constants.dart';

class DriverDailySheet extends StatefulWidget {
  final String driverID, name;
  DriverDailySheet({this.driverID, this.name});
  @override
  _DriverDailySheetState createState() => _DriverDailySheetState();
}

class _DriverDailySheetState extends State<DriverDailySheet> {
  TextEditingController doneController = new TextEditingController();
  TextEditingController returnController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Driver>(
        stream: DriverService(uid: widget.driverID).driverByID,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Driver driverData = snapshot.data;
            return Scaffold(
              endDrawer: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DriverDrawer(
                    name: widget.name,
                  )),
              appBar: AppBar(
                title: Text(
                  driverData.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Amiri',
                  ),
                ),
                backgroundColor: kAppBarColor,
                centerTitle: true,
              ),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 8),
                                child: Text(
                                  "عدد الطورد الواصلة",
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: 18.0,
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 10,
                              ),
                              child: FutureBuilder<int>(
                                  future: OrderService(driverID: driverData.uid)
                                      .countIsDoneInDailySheet,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      doneController.text =
                                          snapshot.data.toString();
                                      return TextFormField(
                                        controller: doneController,
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return TextFormField(
                                        initialValue: "0",
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, right: 6),
                                child: Text(
                                  "عدد الطرود الراجعة",
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: 18.0,
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 8),
                              child: FutureBuilder<int>(
                                  future: OrderService(driverID: driverData.uid)
                                      .countIsReturnInDailySheet,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      returnController.text =
                                          snapshot.data.toString();
                                      return TextFormField(
                                        controller: returnController,
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return TextFormField(
                                        initialValue: "0",
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 8),
                                child: Text(
                                  "المبلغ الكلي",
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: 18.0,
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 8),
                              child: FutureBuilder<int>(
                                  future:
                                      InvoiceService(driverId: driverData.uid)
                                          .totalPriceDriver(driverData.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      returnController.text =
                                          snapshot.data.toString();
                                      return TextFormField(
                                        controller: returnController,
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return TextFormField(
                                        initialValue: "0",
                                        decoration: InputDecoration(
                                          enabled: false,
                                          contentPadding: EdgeInsets.only(
                                              right: 10.0, left: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 4,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, right: 6),
                                child: Text(
                                  "الراتب اليومي",
                                  style: TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: 18.0,
                                  ),
                                ),
                              )),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 8),
                              child: TextField(
                                decoration: InputDecoration(
                                  enabled: false,
                                  contentPadding:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 4,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: StreamProvider<List<Order>>.value(
                          value:
                              OrderService(driverID: widget.driverID).sheetList,
                          child: SheetList(
                            name: widget.name,
                          ),
                          catchError: (_, __) => null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                child: Image.asset("assets/EmptyOrder.png"),
              ),
            );
          }
        });
  }
}
