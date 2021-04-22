import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart' show AssetImage, Colors, MediaQuery;
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generateAndPrintArabicPdf(String businessName, String barCode, String customerName,
    String description, int totalPrice, String city, String subline, String address,
    String phoneNumber) async {

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

  // // ignore: deprecated_member_use
  // PdfImage noteImage = await pdfImageFromImageProvider(
  //   pdf: pdf.document,
  //   image: AssetImage('assets/note.png'),
  // );

  // ignore: deprecated_member_use
  PdfImage descriptionImage = await pdfImageFromImageProvider(
    pdf: pdf.document,
    image: AssetImage('assets/report.png'),
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Directionality(
                            textDirection: TextDirection.ltr,
                            child: Center(
                              // ignore: deprecated_member_use
                              child: Image(logoImage, width: 60, height: 30),
                            )
                        ),

                        // ignore: missing_required_param
                        Center(child: BarcodeWidget(
                          data: barCode ,
                          width: 60,
                          height: 20,
                          barcode: Barcode.code128(),
                        ),),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    "   $businessName  ",
                                    style: TextStyle(
                                  fontSize: 7,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                              child: Text(
                                  " المرسل :  ",
                                  style: TextStyle(
                                    fontSize: 7,
                                  ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                // ignore: deprecated_member_use
                                child: Image(busImage, width: 10, height: 10),
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    "    $customerName  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                                child: Text(
                                    " المستقبل :  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                              child: Image(userImage, width: 10, height: 10),
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    " $city / $address / $subline ",
                                    style: TextStyle(
                                  fontSize: 7,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                                child: Text(
                                    " العنوان :  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                // ignore: deprecated_member_use
                                child: Image(locationImage, width: 10, height: 10),
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    "  0$phoneNumber  "?? "", style: TextStyle(
                                  fontSize: 7,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                                child: Text(
                                    " رقم الجوال :  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                              child: Image(phoneImage, width: 10, height: 10),
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                   "  $description "?? "", style: TextStyle(
                                  fontSize: 7,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                                child: Text(
                                    " وصف الطلبية :  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                // ignore: deprecated_member_use
                                child: Image(descriptionImage, width: 10, height: 10),
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(' شيكل  ', style: TextStyle(
                                  fontSize: 8,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    totalPrice.toString(), style: TextStyle(
                                  fontSize: 8,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(' السعر الكلي : ', style: TextStyle(
                                  fontSize: 8,
                                ))
                            )
                        ),
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

                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child:  Text(
                                    '----------------------------',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    '----------------------------',
                                    style: TextStyle(
                                      fontSize: 8,
                                    ))
                            )
                        ),
                      ]
                  ),


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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Directionality(
                            textDirection: TextDirection.ltr,
                            child: Center(
                              // ignore: deprecated_member_use
                              child: Image(logoImage, width: 60, height: 30),
                            )
                        ),
                        Center(child: BarcodeWidget(
                          data: barCode ,
                          width: 60,
                          height: 20,
                          barcode: Barcode.code128(),
                        ),),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    "   $businessName  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                                child: Text(
                                    " المرسل :  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                              child: Image(busImage, width: 10, height: 10),
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    "    $customerName  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                                child: Text(
                                    " المستقبل :  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                              child: Image(userImage, width: 10, height: 10),
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    " $city / $address / $subline ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                                child: Text(
                                    " العنوان :  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                              child: Image(locationImage, width: 10, height: 10),
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    "  0$phoneNumber  "?? "", style: TextStyle(
                                  fontSize: 7,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                                child: Text(
                                    " رقم الجوال :  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                              child: Image(phoneImage, width: 10, height: 10),
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    "  $description "?? "", style: TextStyle(
                                  fontSize: 7,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                                child: Text(
                                    " وصف الطلبية :  ",
                                    style: TextStyle(
                                      fontSize: 7,
                                    ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              // ignore: deprecated_member_use
                              child: Image(descriptionImage, width: 10, height: 10),
                            )
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(' شيكل  ', style: TextStyle(
                                  fontSize: 8,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(
                                    totalPrice.toString(), style: TextStyle(
                                  fontSize: 8,
                                ))
                            )
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                                child: Text(' السعر الكلي : ', style: TextStyle(
                                  fontSize: 8,
                                ))
                            )
                        ),
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