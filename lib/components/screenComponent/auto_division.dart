import 'package:flutter/material.dart';
import 'package:sajeda_app/components/pages/drawer.dart';

import '../../constants.dart';

class AutoDivision extends StatefulWidget {
   final String name;
   AutoDivision({this.name});
  @override
  _AutoDivisionState createState() => _AutoDivisionState();
}

class _AutoDivisionState extends State<AutoDivision> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("توزيع الطرود تلقائياً",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Amiri',
            )),
        backgroundColor: kAppBarColor,
        centerTitle: true,
      ),
      endDrawer: Directionality(
          textDirection: TextDirection.rtl, child: AdminDrawer(name: widget.name)),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(""),
      ),
    );
  }
}