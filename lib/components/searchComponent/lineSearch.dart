import 'package:AsyadLogistic/classes/mainLine.dart';
import 'package:AsyadLogistic/components/lineComponent/mainLineComponent/mainLineDetails.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../constants.dart';

class LineSearch extends SearchDelegate {
  List<MainLine> list;
  String name;
  LineSearch({this.list, this.name});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var mainLineList = query.isEmpty
        ? list
        : list.where((mainLine) => mainLine.name.startsWith(query)).toList();
    return ListView.builder(
      itemCount: mainLineList.length,
      itemBuilder: (context, index) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: CustomCardAndListTileAddLine(
            mainLine: mainLineList[index],
            color: KAddLinesColor,
            name: name,
            onTapBox: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainLineDetails(
                    name: name,
                    mainLineID: mainLineList[index].uid,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchList = query.isEmpty
        ? list
        : list.where((mainLine) => mainLine.name.startsWith(query)).toList();
    return ListView.builder(
      itemCount: searchList.length,
      itemBuilder: (context, index) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: ListTile(
            leading: Image.asset("assets/LineIcon.png"),
            title: Text(searchList[index].name),
            onTap: () {
              query = searchList[index].name;
              showResults(context);
            },
          ),
        );
      },
    );
  }
}
