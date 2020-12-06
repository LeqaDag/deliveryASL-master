import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/components/lineComponent/mainLineComponent/mainLineDetails.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';

import '../../../classes/mainLine.dart';
import '../../../constants.dart';

class MainLineList extends StatefulWidget {
  final String name;
  MainLineList({this.name});
  @override
  _MainLineListState createState() => _MainLineListState();
}

class _MainLineListState extends State<MainLineList> {
  @override
  Widget build(BuildContext context) {
    final mainLine = Provider.of<List<MainLine>>(context) ?? [];
    if (mainLine != []) {
      return ListView.builder(
        itemCount: mainLine.length,
        itemBuilder: (context, index) {
          return CustomCardAndListTileAddLine(
              mainLine: mainLine[index],
              color: KAddLinesColor,
              name: widget.name,
              onTapBox: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainLineDetails(
                        name: widget.name, mainLineID: mainLine[index].uid),
                  ),
                );
              });
        },
      );
    } else {
      return Center(
        child: Image.asset("assets/EmptyOrder.png"),
      );
    }
  }
}
