import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';

import '../../constants.dart';
import 'all_locations.dart';

class AllLocation extends StatelessWidget {
  final String name;
  AllLocation({this.name});
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("المناطق",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Amiri',
                )),
            backgroundColor: kAppBarColor,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: null),
              IconButton(
                onPressed: () {
                
                },
                icon: Icon(Icons.add),
                color: Colors.white,
              )
            ],
          ),
          drawer: AdminDrawer(name: name),
          body: StreamProvider<List<Location>>.value(
            value: LocationServices().locations,
            child: LocationList(name: name),
          ),
        ));
  }
}
