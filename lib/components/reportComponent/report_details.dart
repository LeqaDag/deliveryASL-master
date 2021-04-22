import 'dart:typed_data';

import 'package:AsyadLogistic/components/pdf/mobile.dart';
import 'package:AsyadLogistic/components/pdf/pdf.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../constants.dart';
import 'shared.dart';

class ReportDetails extends StatefulWidget {
  final Order order;
  final String name;

  ReportDetails({@required this.order, this.name});

  @override
  _ReportDetailsState createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    IconData icon;
    String stateOrder, paidDriver = "";
    Color color;
    DateTime stateDate;
    String customerName = "", businessName = "", city = "", address = "", subline= "",
        phoneNumber= "";

    if (widget.order.inStock == true) {
      color = KBadgeColorAndContainerBorderColorWithDriverOrders;
      icon = Icons.archive_sharp;
      stateOrder = "في المخزن";
      stateDate = widget.order.inStockDate;
    }
    if (widget.order.isCancelld == true) {
      color = KBadgeColorAndContainerBorderColorCancelledOrders;
      icon = Icons.cancel;
      stateOrder = "ملغي";
      stateDate = widget.order.isCancelldDate;
    } else if (widget.order.isDelivery == true) {
      color = KAllOrdersListTileColor;
      icon = Icons.business_center_outlined;
      stateOrder = "جاهز للتوزيع";
      stateDate = widget.order.isDeliveryDate;
    } else if (widget.order.isDone == true &&
        widget.order.isPaidDriver == false) {
      color = KBadgeColorAndContainerBorderColorReadyOrders;
      icon = Icons.done;
      stateOrder = "جاهز";
      stateDate = widget.order.isDoneDate;
    } else if (widget.order.isLoading == true) {
      color = KBadgeColorAndContainerBorderColorLoadingOrder;
      icon = Icons.arrow_circle_up_rounded;
      stateOrder = "محمل";
      stateDate = widget.order.isLoadingDate;
    } else if (widget.order.isUrgent == true) {
      color = KBadgeColorAndContainerBorderColorUrgentOrders;
      icon = Icons.info_outline;
      stateOrder = "مستعجل";
      stateDate = widget.order.isUrgentDate;
    } else if (widget.order.isReturn == true) {
      color = KBadgeColorAndContainerBorderColorReturnOrders;
      icon = Icons.restore;
      stateOrder = "راجع";
      stateDate = widget.order.isReturnDate;
    } else if (widget.order.isReceived == true) {
      color = KBadgeColorAndContainerBorderColorRecipientOrder;
      icon = Icons.assignment_turned_in_outlined;
      stateOrder = "تم استلامه";
      stateDate = widget.order.isReceivedDate;
    } else if (widget.order.isDone == true &&
        widget.order.isPaidDriver == true) {
      color = KBadgeColorAndContainerBorderColorPaidOrders;
      stateOrder = "مدفوع";
      paidDriver = "حذف هذه الطلبية المدفوعة";
      stateDate = widget.order.paidDriverDate;
    }

    List<Order> orders;

    int total;

    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
        Widget>[
      new Card(
        child: new Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Padding(
                      padding: new EdgeInsets.all(4.0),
                      child: new Row(
                        children: <Widget>[
                          new Padding(
                            padding: new EdgeInsets.all(4.0),
                            child: new Text(
                              "السعر:",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(4.0),
                            child: new Text(
                              widget.order.totalPrice.toString(),
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(4.0),
                            child: new Image.asset(
                              'assets/price.png',
                              scale: 1.5,
                            ),
                          ),
                        ],
                      )),
                  new Padding(
                      padding: new EdgeInsets.all(4.0),
                      child: new Row(
                        children: <Widget>[
                          new Padding(
                            padding: new EdgeInsets.all(4.0),
                            child: new Text(
                              "جميع تحصيلات الشركة: ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(4.0),
                            child: new StreamBuilder<List<Order>>(
                                stream: OrderServices()
                                    .businessAllDoneOrders(widget.order.businesID),
                                builder: (context, snapshot) {
                                  int totalPrice = 0;
                                  if (!snapshot.hasData) {
                                    return Text('');
                                  } else {
                                    orders = snapshot.data;
                                    orders.forEach((element) {
                                      if (element.isPaid == false) {
                                        totalPrice += element.price;
                                        total = totalPrice;
                                      }
                                    });
                                    return Text(
                                      totalPrice.toString()
                                    );
                                  }
                                }),

                          ),
                          new Padding(
                            padding: new EdgeInsets.all(4.0),
                            child: new Image.asset(
                              'assets/price.png',
                              scale: 1.5,
                            ),
                          ),
                        ],
                      )),
                  ],
            ),
            Column(
              children: <Widget>[
                new Padding(
                    padding: new EdgeInsets.all(4.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new Icon(Icons.qr_code),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new Text(
                            widget.order.barcode,
                            style: new TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ],
                    )),
                new Padding(
                    padding: new EdgeInsets.all(4.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new Icon(Icons.supervised_user_circle),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new CustomerName(order: widget.order),
                        ),
                      ],
                    )),
                new Padding(
                    padding: new EdgeInsets.all(4.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new Icon(Icons.business),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new  BisunessrName(order: widget.order),
                        ),
                      ],
                    )),
                new Padding(
                    padding: new EdgeInsets.all(4.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new Icon(Icons.location_on),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new CustomerCityAndSublineName(order: widget.order),
                        ),
                      ],
                    )),
                new Padding(
                    padding: new EdgeInsets.all(4.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new Icon(Icons.description),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new Text(
                            widget.order.description,
                            style: new TextStyle(fontSize: 13.0),
                          ),
                        ),
                      ],
                    )),
                new Padding(
                    padding: new EdgeInsets.all(4.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new Icon(Icons.delivery_dining),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new DeliveryStatus(order: widget.order),
                        ),
                      ],
                    )),
                new Padding(
                    padding: new EdgeInsets.all(4.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new Icon(Icons.note_outlined),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new DeliveryNote(order: widget.order),
                        ),
                      ],
                    )),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Padding(
                    padding: new EdgeInsets.all(4.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new Text(""),
                        ),
                      ],
                    )),
                FutureBuilder<String>(
                      future: BusinessServices(uid: widget.order.businesID).businessName,
                      builder: (context, snapshot) {
                        businessName = snapshot.data;
                        return Text("");
                      }),
                FutureBuilder<String>(
                      future: CustomerServices(uid: widget.order.customerID).customerName,
                      builder: (context, snapshot) {
                        customerName = snapshot.data;
                        return Text("");
                      }),

                FutureBuilder<String>(
                    future: CustomerServices(uid: widget.order.customerID).customerCity,
                    builder: (context, snapshot) {
                      city = snapshot.data;
                      return Text("");
                    }),

                FutureBuilder<String>(
                    future: CustomerServices(uid: widget.order.customerID).customerSublineName,
                    builder: (context, snapshot) {
                      subline = snapshot.data;
                      return Text("");
                    }),

                FutureBuilder<String>(
                    future: CustomerServices(uid: widget.order.customerID).customerAdress,
                    builder: (context, snapshot) {
                      address = snapshot.data;
                      return Text("");
                    }),

                FutureBuilder<int>(
                    future: CustomerServices(uid: widget.order.customerID).customerPhoneNumber,
                    builder: (context, snapshot) {
                      phoneNumber = snapshot.data.toString();
                      return Text("");
                    }),
                new Padding(
                    padding: new EdgeInsets.all(4.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new Text(""),
                        ),
                      ],
                    )),
                new Padding(
                    padding: new EdgeInsets.all(4.0),
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.all(4.0),
                          child: new IconButton(
                            icon: Icon(Icons.picture_as_pdf),
                            onPressed: () {

                             // _pdfCreate(widget.order.barcode, customerN);
                              generateAndPrintArabicPdf(businessName, widget.order.barcode, customerName,
                                  widget.order.description, widget.order.totalPrice, city, address, subline,
                                  phoneNumber);
                            },
                          ),
                        ),

                      ],
                    )),
              ],
            ),
          ],
        ),
      )
    ]);
  }

  // ignore: non_constant_identifier_names
  Widget VerticalDivider() {
    return Container(
      color: Colors.black45,
      height: 50,
      width: 1,
    );
  }

  // ignore: non_constant_identifier_names
  Widget HorizantalDivider(double width) {
    return Container(
      color: Colors.black45,
      height: 1,
      width: width,
    );
  }
}



Future<void> _pdfCreate() async{
  PdfDocument document = PdfDocument();
  final page = document.pages.add();

  page.graphics.drawImage(PdfBitmap(await _readImaeData('assets/logo.png')),
           Rect.fromLTWH(150, 30, 120, 90));


  //Load the paragraph text into PdfTextElement with standard font
    PdfTextElement textElement = PdfTextElement(
        text:
        'Shaheen Company',
        font: PdfStandardFont(PdfFontFamily.helvetica, 12));

  //Draw the paragraph text on page and maintain the position in PdfLayoutResult
    PdfLayoutResult layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(0, 150, page.getClientSize().width,
            page.getClientSize().height));

  //Assign header text to PdfTextElement
    textElement.text = 'Top 5 sales stores';

//Assign standard font to PdfTextElement
  textElement.font = PdfStandardFont(PdfFontFamily.helvetica, 14,
      style: PdfFontStyle.bold);

//Draw the header text on page, below the paragraph text with a height gap of 20 and maintain the position in PdfLayoutResult
  layoutResult = textElement.draw(
      page: page,
      bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 20, 0, 0));

  //Initialize PdfGrid for drawing the table
  PdfGrid grid = PdfGrid();
  grid.columns.add(count: 3);
  grid.headers.add(1);
  PdfGridRow header = grid.headers[0];
  header.cells[0].value = 'ID';
  header.cells[1].value = 'Name';
  header.cells[2].value = 'Salary';
  PdfGridRow row1 = grid.rows.add();
  row1.cells[0].value = 'E01';
  row1.cells[1].value = 'Clay';
  row1.cells[2].value = '\$10,000';
  PdfGridRow row2 = grid.rows.add();
  row2.cells[0].value = 'E02';
  row2.cells[1].value = 'Thomas';
  row2.cells[2].value = '\$10,500';
  PdfGridRow row3 = grid.rows.add();
  row3.cells[0].value = 'E02';
  row3.cells[1].value = 'Simon';
  row3.cells[2].value = '\$12,000';


//Draws the grid
  grid.draw(
      page: page,
      bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 20, 0, 0));
  // page.graphics.drawString(
  //       'Shahin', PdfStandardFont(PdfFontFamily.timesRoman, 15),
  //       bounds: Rect.fromLTWH(0, 0, 120, 90));
  //
  // page.graphics.drawImage(PdfBitmap(await _readImaeData('assets/logo.png')),
  //     Rect.fromLTWH(0, 20, 120, 90));
  //
  // //Create the footer with specific bounds
  //   PdfPageTemplateElement footer = PdfPageTemplateElement(
  //       Rect.fromLTWH(0, 0, document.pages[0].getClientSize().width, 50));
  //
  // //Create the composite field with page number page count
  //   PdfCompositeField compositeField = PdfCompositeField(
  //       font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
  //       brush: PdfSolidBrush(PdfColor(0, 0, 0)),
  //       text: 'Signature:                     Date:');
  //   compositeField.bounds = footer.bounds;
  //
  // //Add the composite field in footer
  //   compositeField.draw(footer.graphics,
  //       Offset(290, 50 - PdfStandardFont(PdfFontFamily.timesRoman, 19).height));
  //
  // //Add the footer at the bottom of the document
  //   document.template.bottom = footer;
  //
  // // page.graphics.drawImage(PdfBitmap(await _readImaeData('assets/logo.png')),
  // //   Rect.fromLTWH(0, 20, 120, 90));
  //
  // PdfGrid grid = PdfGrid();
  // grid.style = PdfGridStyle(
  //   font: PdfStandardFont(PdfFontFamily.helvetica, 30),
  //   cellPadding: PdfPaddings(left:2, right:2, top:2, bottom: 2)
  // );
  // grid.columns.add(count: 3);
  // grid.headers.add(1);
  //
  // PdfGridRow tableHeader = grid.headers[0];
  // tableHeader.cells[0].value = barCode;
  // tableHeader.cells[1].value = 'Name';
  // tableHeader.cells[2].value = 'Class';
  //
  // PdfGridRow row = grid.rows.add();
  // row.cells[0].value = '1';
  // row.cells[1].value = 'LeQa';
  // row.cells[2].value = 'CSE';
  //
  // row = grid.rows.add();
  // row.cells[0].value = '2';
  // row.cells[1].value = 'Haneen';
  // row.cells[2].value = 'CSE';
  //
  // row = grid.rows.add();
  // row.cells[0].value = '3';
  // row.cells[1].value = 'Sajeda';
  // row.cells[2].value = 'CS';

  grid.draw(page: document.pages.add(),
      bounds: const Rect.fromLTWH(0, 0, 0, 0));

  List<int> bytes = document.save();
  document.dispose();

  saveAndLaunchFile(bytes, 'output.pdf');
}


Future<Uint8List> _readImaeData(String name) async{
  final data = await rootBundle.load(name);
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}












