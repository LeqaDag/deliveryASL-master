import 'package:AsyadLogistic/components/searchComponent/driversSearch.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/driver.dart';
import 'package:AsyadLogistic/components/driverComponent/addComponent/add.dart';
import 'package:AsyadLogistic/components/driverComponent/driversComponent/driverlist.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/services/driverServices.dart';

import '../../../constants.dart';

class DriverAdmin extends StatelessWidget {
  final String name;
  DriverAdmin({this.name});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
          length: 2,
          child: StreamProvider<List<Driver>>.value(
            value: DriverServices().drivers,
            child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                      labelColor: kAppBarColor,
                      unselectedLabelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          color: Colors.white),
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "سائقين الشركة",
                              style: TextStyle(
                                  fontSize: 18.0, fontFamily: 'Amiri'),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "سائقين خصوصي",
                              style: TextStyle(
                                  fontSize: 18.0, fontFamily: 'Amiri'),
                            ),
                          ),
                        ),
                      ]),
                  title: Text('السائقين',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Amiri',
                      )),
                  centerTitle: true,
                  backgroundColor: kAppBarColor,
                  actions: <Widget>[
                    StreamBuilder<List<Driver>>(
                        stream: DriverServices().drivers,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Driver> driverList = snapshot.data;
                            return IconButton(
                              onPressed: () {
                                showSearch(
                                  context: context,
                                  delegate: DriversSearch(
                                    list: driverList,
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
                              builder: (context) => AddDriver(name: name)),
                        );
                      },
                      icon: Icon(Icons.person_add),
                      color: Colors.white,
                    )
                  ],
                ),
                drawer: AdminDrawer(name: name),
                body: DriverList(name: name)),
          ),
        ));
  }
}
