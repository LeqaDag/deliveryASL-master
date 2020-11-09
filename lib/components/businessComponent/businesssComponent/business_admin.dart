import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/components/businessComponent/addComponent/add_company.dart';
import 'package:sajeda_app/components/businessComponent/businesssComponent/business_list.dart';
import 'package:sajeda_app/components/businessComponent/searchComponent/companiesAdminSearch.dart';
import 'package:sajeda_app/components/pages/drawer.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/services/businessServices.dart';

import '../../../constants.dart';

class BusinessAdmin extends StatelessWidget {
  final String name;
  BusinessAdmin({this.name});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("الشركات والتجار",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
          centerTitle: true,
          backgroundColor: kAppBarColor,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CloudFirestoreSearch()),
                );
              },
              icon: Icon(Icons.search),
              color: Colors.white,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCompany(name: name)),
                );
              },
              icon: Icon(Icons.person_add),
              color: Colors.white,
            )
          ],
        ),
        drawer: AdminDrawer(name: name),
        body: StreamProvider<List<Business>>.value(
          value: BusinessService().business,
          child: BusinessList(name: name),
        ),
      ),
    );
  }
}
