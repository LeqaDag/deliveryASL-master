import 'package:AsyadLogistic/classes/admin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import 'package:AsyadLogistic/services/adminServices.dart';

class SecretaryList extends StatefulWidget {
  final String name;
  SecretaryList({this.name});

  @override
  _SecretaryListState createState() => _SecretaryListState();
}

class _SecretaryListState extends State<SecretaryList> {
  @override
  Widget build(BuildContext context) {
    final admins = Provider.of<List<Admin>>(context).where((admin) {
          return admin.type == false;
        }).toList() ??
        [];
    if (admins != []) {
      return ListView.builder(
        itemCount: admins.length,
        itemBuilder: (context, index) {
          return StreamBuilder<Admin>(
              stream: AdminServices(uid: admins[index].uid).adminByID,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Admin admin = snapshot.data;
                  return Card(
                    child: ListTile(
                      title: Text(
                          "${admin.name}"), // String Variable Take Name From DataBase
                      leading: CircleAvatar(
                          // Account Image Form DataBase
                          ),
                      trailing: Wrap(
                        spacing: -15, // space between two icons
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) =>
                                      CustomDialog(
                                        title: "حذف سكرتير",
                                        description: ' هل ترغب بحذف السكرتير',
                                        name: admin.name,
                                        buttonText: "تأكيد",
                                        onPressed: () {
                                          AdminServices().deleteAdminData(
                                              admins[index].uid);
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
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
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
