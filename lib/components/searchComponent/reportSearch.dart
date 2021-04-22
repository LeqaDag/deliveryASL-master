import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/customer.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/businessComponent/itemComponent/business_item.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../constants.dart';

class ReportSearch extends SearchDelegate {
  List<Business> business;
  List<Order> orders;
  List<Customer> customers;
  String name;

  ReportSearch({this.business, this.orders, this.customers, this.name});

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
        ? business
        : business.where((business) => business.name.startsWith(query)).toList();

    var ordersList = query.isEmpty
        ? orders
        : orders.where((order) => order.barcode.startsWith(query))
            .where((order) => order.price.toString().startsWith(query))
            .where((order) => order.totalPrice.toString().startsWith(query))
            .where((order) => order.description.startsWith(query))
            .toList();
    return ListView.builder(
      itemCount: ordersList.length,
      itemBuilder: (context, index) {
        return Directionality(
            textDirection: ui.TextDirection.rtl,
            child:AllBuisness(
                color: KCustomCompanyOrdersStatus,
                businessID: ordersList[index].uid,
                name: name,
                busID: ordersList[index].uid,
                onTapBox: () {
                  //print(businessList[index].userID);
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
        // ? business
        // : business.where((business) => business.name.startsWith(query)).toList() != null
        ? orders
        : orders.where((order) => order.barcode.startsWith(query))
        .where((order) => order.price.toString().startsWith(query))
        .where((order) => order.totalPrice.toString().startsWith(query))
        .where((order) => order.description.startsWith(query))
        .toList();

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
            title: Text(searchList[index].barcode),
            onTap: () {
              query = searchList[index].totalPrice.toString();
              showResults(context);
            },
          ),
        );
      },
    );
  }
}
