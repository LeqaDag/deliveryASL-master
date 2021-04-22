import 'package:AsyadLogistic/components/searchComponent/businessSearch.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/components/businessComponent/addComponent/add_company.dart';
import 'package:AsyadLogistic/components/businessComponent/businesssComponent/business_list.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/services/businessServices.dart';

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
            StreamBuilder<List<Business>>(
                stream: BusinessServices().business,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Business> businessList = snapshot.data;
                    return IconButton(
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: BusinessSearch(
                            list: businessList,
                            name: name,
                          ),
                        );
                      },
                      icon: Icon(Icons.search),
                      color: Colors.white,
                    );
                  } else {
                    return Container();
                  }
                }),
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
          value: BusinessServices().business,
          child: BusinessList(name: name),
        ),
      ),
    );
  }
}
