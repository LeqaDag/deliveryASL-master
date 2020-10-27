import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/components/lineComponent/listMainLineComponent/listMainLine.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:sajeda_app/services/mainLineServices.dart';

import '../../classes/mainLine.dart';
import '../../constants.dart';
import 'add_line.dart';

class AllLines extends StatelessWidget {
  final String name;
  AllLines({this.name});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text("خطوط التوصيل",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amiri',
                  )),
              backgroundColor: kAppBarColor,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: null),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddLine(name:name)),
                    );
                  },
                  icon: Icon(Icons.add),
                  color: Colors.white,
                )
              ],
            ),
            drawer: AdminDrawer(name: name),
            body: StreamProvider<List<MainLine>>.value(
              value: MainLineServices().mainLines,
              child: MainLineList(name: name),
            ),
          )),
    );
  }
}