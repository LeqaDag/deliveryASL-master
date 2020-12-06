import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:AsyadLogistic/components/businessComponent/addComponent/add_company.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';

import '../../constants.dart';

class StoreAndBusiness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
          child: Scaffold(
        appBar: AppBar(
          title: Text("الشركات التجار",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
          backgroundColor: kAppBarColor,
          centerTitle: true,
          //leading: IconButton(icon: Icon(Icons.search),color: Colors.white, onPressed: null),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  textDirection: TextDirection.rtl,
                ),
                onPressed: null),
            IconButton(
              onPressed: () {
                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCompany()),
                          );
              },
              icon: Icon(Icons.person_add),
              color: Colors.white,
            )
          ],
        ),
        drawer: AdminDrawer(),
        body: ListView(
          children: <Widget>[
            //CustomCardAndListTile(color: KAllOrdersListTileColor, onTapBox: () {}),
          ],
        ),
      ),
    );
  }
}
