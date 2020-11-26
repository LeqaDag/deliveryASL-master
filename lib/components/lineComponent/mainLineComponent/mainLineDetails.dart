import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/subLine.dart';
import 'package:sajeda_app/components/lineComponent/subLineComponent/addSubLine.dart';
import 'package:sajeda_app/components/lineComponent/subLineComponent/subLineList.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/components/pages/loadingData.dart';
import 'package:sajeda_app/services/mainLineServices.dart';
import 'package:sajeda_app/services/subLineServices.dart';

import '../../../classes/mainLine.dart';
import '../../../constants.dart';

class MainLineDetails extends StatefulWidget {
  final String name;
  final String mainLineID;
  MainLineDetails({this.name, this.mainLineID});
  @override
  _MainLineDetailsState createState() => _MainLineDetailsState();
}

class _MainLineDetailsState extends State<MainLineDetails> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainLine>(
        stream: MainLineServices(uid: widget.mainLineID).mainLineByID,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            MainLine mainLine = snapshot.data;
            return Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Directionality(
                  textDirection: TextDirection.rtl,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddSubLine(
                              name: widget.name, mainLineID: mainLine.uid),
                        ),
                      );
                    },
                    label: Text(
                      'خط فرعي',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontFamily: 'Amiri',
                      ),
                    ),
                    icon: Icon(Icons.add),
                    backgroundColor: Color(0xff73a16a),
                  ),
                ),
                appBar: AppBar(
                  title: Text(
                    "خط التوصيل الرئيسي ${mainLine.name}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Amiri',
                    ),
                  ),
                  backgroundColor: kAppBarColor,
                  centerTitle: true,
                ),
                endDrawer: Directionality(
                    textDirection: TextDirection.rtl,
                    child: AdminDrawer(name: widget.name)),
                body: Directionality(
                  textDirection: TextDirection.rtl,
                  child: StreamProvider<List<SubLine>>.value(
                    value:
                        SubLineServices(mainLineID: widget.mainLineID).subLines,
                    child: SubLineList1(
                        name: widget.name, mainLineID: widget.mainLineID),
                    catchError: (_, __) => null,
                  ),
                ));
          } else {
            return LoadingData();
          }
        });
  }
}

class SubLineList1 extends StatefulWidget {
  final String name, mainLineID;
  SubLineList1({this.name, this.mainLineID});
  @override
  _SubLineList1State createState() => _SubLineList1State();
}

class _SubLineList1State extends State<SubLineList1> {
  @override
  Widget build(BuildContext context) {
    
    return StreamProvider<List<SubLine>>.value(
      value: SubLineServices().subLines1,
      child: SubLineList(name: widget.name, mainLineID: widget.mainLineID),
      catchError: (_, __) => null,
    );
  }
}
