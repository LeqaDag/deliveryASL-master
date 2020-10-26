import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';

import '../../../classes/mainLine.dart';
import '../../../constants.dart';

class MainLineList extends StatefulWidget {
  
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
              color: KAddLinesColor, onTapBox: () {});
        },
      );
    } else {
      return Center(child: Image.asset("assets/EmptyOrder.png"));
    }
  }
}
