import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/driver.dart';
import 'package:sajeda_app/components/driverComponent/sheetComponent/daliy_sheet.dart';
import 'package:sajeda_app/components/driverComponent/updateComponet/update.dart';
import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';
import 'package:sajeda_app/services/driverServices.dart';
import 'package:url_launcher/url_launcher.dart';

class Item extends StatelessWidget {
  final Driver driver;
  final String name;
  Item({this.driver, this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DailySheet(driverID: driver.uid, name: name)),
        );
      },
      child: Card(
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
                width: 150.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        launch('tel:' +
                            Uri.encodeComponent('${driver.phoneNumber}'));
                      },
                      icon: Icon(
                        Icons.phone,
                        color: Colors.orange,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateDriver(
                                  driverID: driver.uid, name: name)),
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
                            builder: (BuildContext context) => CustomDialog(
                                  title: "حذف سائق",
                                  description: ' هل ترغب بحذف السائق',
                                  name: driver.name,
                                  buttonText: "تأكيد",
                                  onPressed: () {
                                    DriverServices()
                                        .deleteDriverData(driver.uid);
                                    Navigator.of(context).pop();
                                  },
                                  cancelButton: "الغاء",
                                  cancelPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ));
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
      ),
    );
  }
}
