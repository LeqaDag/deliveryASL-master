import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/searchComponent/resultOrderSearch.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class OrdersSearch extends SearchDelegate {
  List<Order> list;
  String name;
  OrdersSearch({this.list, this.name});

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
    var searchList = query.isEmpty
        ? list
        : list.where((driver) => driver.barcode.startsWith(query)).toList();
    return ListView.builder(
      itemCount: searchList.length,
      itemBuilder: (context, index) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child:ListTile(
            leading: FaIcon(FontAwesomeIcons.stop,color: Color(0xff316686),), 
            title: Text(searchList[index].barcode),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultOrderSearch(name: name,order: searchList[index],)),
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
        : list.where((business) => business.barcode.startsWith(query)).toList();
    return ListView.builder(
      itemCount: searchList.length,
      itemBuilder: (context, index) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: ListTile(
            leading: FaIcon(FontAwesomeIcons.stop,color: Color(0xff316686),), 
            title: Text(searchList[index].barcode),
            onTap: () {
              query = searchList[index].barcode;
              showResults(context);
            },
          ),
        );
      },
    );
  }
}
