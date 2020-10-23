import 'package:flutter/material.dart';
import 'package:sajeda_app/components/pages/driver_drawer.dart';

class DriverMain extends StatelessWidget {
  final String name, uid;
  DriverMain({this.name, this.uid});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF457B9D),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {
                  print('driver');
                })
          ],
          title: Text(name ?? "",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
        ),
        drawer: DriverDrawer(name: name, uid: uid),
        body: Stack(
          children: [
            // CustomBoxSize(0.1),
            Positioned.fill(
              top: height * 0.22,
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/DriversOrder.png"),
              ),
            ),

            Positioned.fill(
              top: height * 0.35,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "الــطـــرود",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Amiri",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
