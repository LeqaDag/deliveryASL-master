import 'dart:typed_data';

import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/pdf/all_reports_pdf.dart';
import 'package:AsyadLogistic/components/pdf/mobile.dart';
import 'package:AsyadLogistic/components/pdf/pdf_test.dart';
import 'package:AsyadLogistic/components/reportComponent/all_reports.dart';
import 'package:AsyadLogistic/components/searchComponent/businessSearch.dart';
import 'package:AsyadLogistic/components/searchComponent/driversSearch.dart';
import 'package:AsyadLogistic/components/searchComponent/reportSearch.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/components/lineComponent/mainLineComponent/listMainLine.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/services/mainLineServices.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../classes/mainLine.dart';
import '../../constants.dart';
import 'shared.dart';

class AllReports extends StatefulWidget {
  final String name;
  final Order order;

  AllReports({this.name, this.order});

  @override
  _AllReportsState createState() => _AllReportsState();
}

class _AllReportsState extends State<AllReports> {
  final _formKey = GlobalKey<FormState>();

  String type = 'جميع التحصيلات';
  String filterOrder = 'order';

  List<Business> businessList;
  List<Order> ordersList;
  List<Customer> customersList;

  @override
  Widget build(BuildContext context) {


    StreamBuilder<List<Customer>>(
        stream: CustomerServices().customers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            customersList = snapshot.data;
            return Container();

          } else {
            return Container();
          }
        });
    StreamBuilder<List<Business>>(
        stream: BusinessServices().business,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
             businessList = snapshot.data;
            return Container();

          } else {
            return Container();
          }
        });
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("التقارير",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Amiri',
                )),
            backgroundColor: kAppBarColor,
            centerTitle: true,
            actions: <Widget>[

              IconButton(
                onPressed: () {
                  StreamProvider<List<Order>>.value(
                      value: OrderServices().orders,
                      builder: (context, snapshot) {
                        if (snapshot != null) {
                          ordersList = Provider.of<List<Order>>(context).toList() ??
                              [];

                           print(ordersList);
                          return Container();
                        } else {
                          return Container();
                        }
                      });


                  generateAndPrintAllReportPdf(ordersList);
                 // PdfPageTest();
                },
                icon: Icon(Icons.picture_as_pdf),
                color: Colors.white,
              )
            ],
          ),
          drawer: AdminDrawer(name: widget.name),
          body: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
          child: Form(
          key: _formKey,
          child: ListView(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Flexible(
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: ReportSearch(
                          //business: businessList,
                          orders: ordersList,
                          //customers: customersList,
                          name: widget.name,
                        ),
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'بحث',
                  //     labelStyle: TextStyle(
                  //         fontFamily: 'Amiri',
                  //         fontSize: 13.0,
                  //         color: Color(0xff316686)),
                  //     contentPadding: EdgeInsets.only(right: 10.0),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //       borderSide: BorderSide(
                  //         width: 1.0,
                  //         color: Color(0xff636363),
                  //       ),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //       borderSide: BorderSide(
                  //         width: 2.0,
                  //         color: Color(0xff73a16a),
                  //       ),
                  //       //Change color to Color(0xff73a16a)
                  //     ),
                  //   ),
                  // ),
                ),


                ),

                Flexible(
                  child:  Container(
                    margin: EdgeInsets.all(5.0),
                    child: DropdownButtonFormField(
                      onChanged: (val) {
                        setState(() =>
                          type = val
                        );

                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      items: <String>['جميع التحصيلات', 'التحصيلات المستلمة', 'التحصيل السائق',
                        'طرود قيد التسليم', 'التحصيل الجاهز للاستلام']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              value,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontFamily: 'Amiri', fontSize: 13.0),
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 1.0,
                              color: Color(0xff636363),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Color(0xff73a16a),
                            ),
                            //Change color to Color(0xff73a16a)
                          ),
                          contentPadding:
                          EdgeInsets.only(right: 10.0, left: 10.0),
                          labelText: "",
                          labelStyle: TextStyle(
                              fontFamily: 'Amiri',
                              fontSize: 13.0,
                              color: Color(0xff316686))),
                    ),
                  ),



                ),
              ],
            ),

            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  StreamBuilder<List<Order>>(
                    stream: OrderServices(report: type)
                    .ordersReports,
                    builder: (context, snapshot) {

                      if(snapshot.hasData) {
                        List<Order> orders= snapshot.data;
                        orders= orders.where((element) => element.driverID != "").toList();
                        return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:orders.length,
                          itemBuilder: (context, index) {
                            return CustomCard(
                                uid: orders[index].uid,
                                name: widget.name
                            );
                          },
                        );
                       // return ReportsList(order:widget.order, name: widget.name, orders: snapshot.data);
                      } else {
                        return Container();
                      }

                    }
                  ),
                ])
            ]
          ))),


          )
        )
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


  // var items = [];
  // var querySnapshot;
  // for(int i = 0; i<querySnapshot.documents.length; i++) {
  //   var a = querySnapshot.documents[i];
  //   var pdfLib;
  //   items.add(pdfLib.Table.fromTextArray(data: <List<String>>[
  //     <String>['List', 'Result Data'],
  //     <String>['-', a.toString()],
  //   ]));
  // }
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