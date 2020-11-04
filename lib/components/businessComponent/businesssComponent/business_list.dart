import 'package:sajeda_app/classes/busines.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/components/businessComponent/businesssComponent/buisnessOrders.dart';
import 'package:sajeda_app/components/businessComponent/itemComponent/business_item.dart';

import '../../../constants.dart';

class BusinessList extends StatefulWidget {
  final String name;
  BusinessList({this.name});

  @override
  _BusinessListState createState() => _BusinessListState();
}

class _BusinessListState extends State<BusinessList> {
  @override
  Widget build(BuildContext context) {
    final business = Provider.of<List<Business>>(context) ?? [];
    if (business != []) {
      return ListView.builder(
        itemCount: business.length,
        itemBuilder: (context, index) {
          return AllBuisness(
              color: KCustomCompanyOrdersStatus,
              businessID: business[index].uid,
              name: widget.name,
              busID: business[index].userID,
              onTapBox: () {
                print(business[index].userID);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => CompaniesOrdersAdmin(
                //           businessID: business[index].uid, name: business[index].name)),
                // );
              });
        },
      );
    } else {
      return Center(
          child: ListView(
        children: <Widget>[
          Image.asset("assets/EmptyOrder.png"),
        ],
      ));
    }
  }
}
