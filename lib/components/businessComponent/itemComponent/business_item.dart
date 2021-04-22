import 'dart:io';

import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/classes/mainLine.dart';
import 'package:AsyadLogistic/components/businessComponent/updateComponent/update_company.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:AsyadLogistic/services/mainLineServices.dart';
import 'package:badges/badges.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:intl/intl.dart' as intl;
import 'package:toast/toast.dart';
import '../../../constants.dart';
import 'package:path/path.dart' as path;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
                          IconButton(
                            onPressed: () {
                              return showDialog<Widget>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      color: Colors.white,
                                      child: SfDateRangePicker(
                                        selectionMode:
                                            DateRangePickerSelectionMode.range,
                                        showActionButtons: true,
                                        onSubmit: (Object value) async {
                                          PickerDateRange val = value;
                                          print(val);
                                          List<Order> orders =
                                              await OrderServices(
                                            businesID: businessID,
                                            startDate: val.startDate,
                                            endDate: val.endDate,
                                          ).ordersByBusinessID.first;
                                          print(orders);
                                          _generateCSVAndView(
                                              context, orders, businessID, val);
                                          Toast.show(
                                              "تم تنزيل الكشف", context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.BOTTOM);
                                          Navigator.of(context).pop();
                                        },
                                        onCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(
                              FontAwesomeIcons.solidFileExcel,
                              color: Colors.green,
                            ),
                          ),
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

  Future<void> _generateCSVAndView(
      context, List<Order> data, String businesID, PickerDateRange val) async {
    var excel = Excel.createExcel();

    CellStyle cellStyle = CellStyle(
      bold: true,
      fontSize: 12,
      backgroundColorHex: '#17375E',
      fontColorHex: "#ffffff",
      horizontalAlign: HorizontalAlign.Center,
    );

    var sheet = excel['Sheet1'];

    List<String> dataList1 = [
      'Barcode',
      'Customer Name',
      'Customer Phone',
      'Customer Phone2',
      'Payment Address 1',
      'Payment City',
      'Payment Zone',
      'Total'
    ];
    String businessName = await BusinessServices(uid: businesID).businessName;
    String startDate = intl.DateFormat('yyyy-MM-dd').format(val.startDate);
    String endDate = intl.DateFormat('yyyy-MM-dd').format(val.endDate);
    sheet.merge(CellIndex.indexByString("A1"), CellIndex.indexByString("H1"),
        customValue:
            "----------------------------------------- كشف  ${businessName.toString()} من $startDate الى $endDate -----------------------------------------");
    sheet.insertRowIterables(dataList1, 1);
    sheet.cell(CellIndex.indexByString("A2")).cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByString("B2")).cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByString("C2")).cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByString("D2")).cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByString("E2")).cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByString("F2")).cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByString("G2")).cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByString("G2")).cellStyle = cellStyle;
    sheet.cell(CellIndex.indexByString("H2")).cellStyle = cellStyle;

    Customer c;
    int index = 2;

    for (Order order in data) {
      Stream<Customer> customer =
          CustomerServices(uid: order.customerID).customerByID;
      c = await customer.first;
      Stream<MainLine> stream =
          MainLineServices(uid: order.mainlineID).mainLineByID;
      MainLine mainLine = await stream.first;
      Stream<Location> streamLocation =
          LocationServices(uid: order.locationID).locationByID;
      Location location = await streamLocation.first;
      sheet.insertRowIterables([
        order.barcode.toString(),
        c.name.toString(),
        c.phoneNumber.toString(),
        c.phoneNumberAdditional.toString(),
        c.address.toString(),
        mainLine.name,
        location.name,
        order.totalPrice.toString(),
      ], index++);
    }

    excel.setDefaultSheet(sheet.sheetName).then((isSet) {
      if (isSet) {
        print("${sheet.sheetName} is set to default sheet.");
      } else {
        print("Unable to set ${sheet.sheetName} to default sheet.");
      }
    });
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    excel.encode().then((fileBytes) {
      File(path.join(
          '/storage/emulated/0/Download/كشف ${businessName.toString()}.xlsx'))
        ..createSync(recursive: false)
        ..writeAsBytesSync(fileBytes);
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
