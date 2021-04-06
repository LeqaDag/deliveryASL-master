import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/components/driverComponent/itemComponent/item.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DriversSearch extends SearchDelegate {
  List<Driver> list;
  String name;
  DriversSearch({this.list, this.name});

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
    var driverList = query.isEmpty
        ? list
        : list.where((driver) => driver.name.startsWith(query)).toList();
    return ListView.builder(
      itemCount: driverList.length,
      itemBuilder: (context, index) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Item(
            driver: driverList[index],
            name: name,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchList = query.isEmpty
        ? list
        : list.where((driver) => driver.name.startsWith(query)).toList();
    return ListView.builder(
      itemCount: searchList.length,
      itemBuilder: (context, index) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: ListTile(
            leading: Icon(
              Icons.person,
              color: Color(0xff316686),
              size: 32.0,
            ),
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
