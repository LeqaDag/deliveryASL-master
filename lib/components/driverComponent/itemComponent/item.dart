import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/components/driverComponent/updateComponet/update.dart';
import 'package:sajeda_app/services/driverServices.dart';

class Item extends StatelessWidget {
  final Driver driver;
  Item({this.driver});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.person,
                      color: Color(0xff316686),
                      size: 32.0,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${driver.name}',
                      style: TextStyle(fontFamily: 'Amiri', fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('حذف سائق'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('هل ترغب بحذف السائق'),
                                  Text(driver.name),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('تأكيد'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateDriver(driverID: driver.uid)),
                                  );
                                },
                              ),
                              FlatButton(
                                child: Text('تراجع'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.create,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('حذف سائق'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('هل ترغب بحذف السائق'),
                                  Text(driver.name),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('تأكيد'),
                                onPressed: () {
                                  DriverService().deleteDriverData(driver.uid);
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text('تراجع'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
