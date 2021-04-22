import 'dart:io';
import 'dart:ui';

import 'package:AsyadLogistic/classes/order.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart' show AssetImage, Colors, MediaQuery;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generateAndPrintAllReportPdf(List ordersList) async {

  final Document pdf = Document();



  // ignore: deprecated_member_use
  PdfImage logoImage = await pdfImageFromImageProvider(
    pdf: pdf.document,
    image: AssetImage('assets/logo.png'),
  );

  // ignore: deprecated_member_use
  PdfImage userImage = await pdfImageFromImageProvider(
    pdf: pdf.document,
    image: AssetImage('assets/admin.png'),
  );

  // ignore: deprecated_member_use
  PdfImage busImage = await pdfImageFromImageProvider(
    pdf: pdf.document,
    image: AssetImage('assets/CompanysAndStores.png'),
  );

  // ignore: deprecated_member_use
  PdfImage locationImage = await pdfImageFromImageProvider(
    pdf: pdf.document,
    image: AssetImage('assets/region100.png'),
  );

  // ignore: deprecated_member_use
  PdfImage phoneImage = await pdfImageFromImageProvider(
    pdf: pdf.document,
    image: AssetImage('assets/driverPrice.png'),
  );

  // ignore: deprecated_member_use
  PdfImage calenderImage = await pdfImageFromImageProvider(
    pdf: pdf.document,
    image: AssetImage('assets/cal.png'),
  );

  var arabicFont = Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));
  pdf.addPage(Page(
      theme: ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.roll80,
      build: (Context context) {

        return Center(
            child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Directionality(
                            textDirection: TextDirection.ltr,
                            child: Center(
                              // ignore: deprecated_member_use
                                child:  Text('0599843342', style: TextStyle(
                                  fontSize: 8,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('شركة شاهين', style: TextStyle(
                                  fontSize: 8,
                                ))
                            )
                        ),
                      ]
                  ),
                      Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text('تقرير التحصيلات' , style: TextStyle(
                              fontSize: 10
                          ))
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(22, 5, 22, 5),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Table.fromTextArray(
                            headerStyle: TextStyle(
                                fontSize: 6
                            ),
                            headers: <dynamic>[' ملاحظات', 'السعر ' ,'العنوان ', ' المستقبل', ' المرسل',
                              'رقم الباركود ', 'رقم الطرد '],
                            cellAlignment: Alignment.center,
                            cellStyle: TextStyle(
                                fontSize: 5
                            ),
                            data:  <List<dynamic>>[
                              <dynamic>['50', '10' ,'كوي', 'قميص', '', '' ],
                              <dynamic>['50', '10' ,'كوي', 'قميص', '', '' ],
                              <dynamic>['50', '10' ,'كوي', 'قميص', '', '' ],
                            ],
                          ),
                        ),
                      ),


                  pw.Table(
                      children: [
                        for (var i = 0; i < ordersList.length; i++)
                          pw.TableRow(
                              children: [
                                pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    children: [
                                      pw.Text(ordersList[i].barcode,
                                          style: pw.TextStyle(fontSize: 6)),
                                      pw.Divider(thickness: 1)
                                    ]
                                ),
                                pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    children: [
                                      pw.Text(ordersList[i].driverID,
                                          style: pw.TextStyle(fontSize: 6)),
                                      pw.Divider(thickness: 1)
                                    ]
                                ),
                                pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    children: [
                                      pw.Text(ordersList[i].businesID,
                                          style: pw.TextStyle(fontSize: 6)),
                                      pw.Divider(thickness: 1)
                                    ]
                                ),
                                pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: pw.MainAxisAlignment.center,
                                    children: [
                                      pw.Text(ordersList[i].price.toString(),
                                          style: pw.TextStyle(fontSize: 6)),
                                      pw.Divider(thickness: 1)
                                    ]
                                )
                              ]
                          )
                      ]
                  ),


                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '....................',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text('التاريخ : ', style: TextStyle(
                                  fontSize: 8,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '              ',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '....................',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(' التوقيع : ', style: TextStyle(
                                  fontSize: 9,
                                ))
                            )
                        ),
                      ]
                  ),
                ]
            )
        );
      }
  ));
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/1.pdf';
  final File file = File(path);
  await file.writeAsBytes(pdf.save());
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}
