import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/admin.dart';
import 'package:AsyadLogistic/components/adminComponent/secretary_list.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/services/adminServices.dart';

import '../../constants.dart';
import 'add_secretary.dart';


class AdminSecretaryHome extends StatelessWidget {
  final String name;
  AdminSecretaryHome({this.name});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("العاملين",
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
                      builder: (context) => AddSecretary(name: name)),
                );
              },
              icon: Icon(Icons.person_add),
              color: Colors.white,
            )
          ],
        ),
        drawer: AdminDrawer(name: name),
        body: StreamProvider<List<Admin>>.value(
          value: AdminServices().admins,
          child: SecretaryList(name: name),
        ),
      ),
    );
  }
}
