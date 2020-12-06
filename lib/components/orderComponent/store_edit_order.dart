
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';


class EditOrder extends StatelessWidget{
 final String selectedOrderCustomerName = "ليقا"; //هذا المتغير يحمل اسم صاحب الطلبية المراد تتعديلها والذي يتأتي من قاعدة البيانات
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Directionality(textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text("تعديل طلبية "+selectedOrderCustomerName),
                backgroundColor: Color(0xFF4889B6),
            ),
            drawer: AdminDrawer(),
          )),

    );
  }
  
}