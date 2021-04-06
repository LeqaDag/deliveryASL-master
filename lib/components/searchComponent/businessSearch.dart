import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/components/businessComponent/itemComponent/business_item.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../constants.dart';

class BusinessSearch extends SearchDelegate {
  List<Business> list;
  String name;
  BusinessSearch({this.list, this.name});

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
    var businessList = query.isEmpty
        ? list
        : list.where((driver) => driver.name.startsWith(query)).toList();
    return ListView.builder(
      itemCount: businessList.length,
      itemBuilder: (context, index) {
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child:AllBuisness(
              color: KCustomCompanyOrdersStatus,
              businessID: businessList[index].uid,
              name: name,
              busID: businessList[index].userID,
              onTapBox: () {
                print(businessList[index].userID);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => CompaniesOrdersAdmin(
                //           businessID: business[index].uid, name: business[index].name)),
                // );
              })
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var searchList = query.isEmpty
        ? list
        : list.where((business) => business.name.startsWith(query)).toList();
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
