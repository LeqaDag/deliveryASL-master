import 'package:flutter/material.dart';
import 'package:sajeda_app/components/pages/drawer.dart';

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
                      MaterialPageRoute(builder: (context) => AddLine()),
                    );
                  },
                  icon: Icon(Icons.add),
                  color: Colors.white,
                )
              ],
            ),
            drawer: AdminDrawer(name: name),
            body: ListView(
              children: <Widget>[
                // CustomCardAndListTileAddLine(color :KAddLinesColor,onTap: () {}),
                // CustomCardAndListTileAddLine(KAddLinesColor, () {}),
                // CustomCardAndListTileAddLine(KAddLinesColor, () {}),
              ],
            ),
          )),
    );
  }
}
