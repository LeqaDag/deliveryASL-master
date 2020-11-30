import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/admin.dart';
import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';
import 'package:sajeda_app/services/adminServices.dart';

class AllSecretaries extends StatelessWidget {
  final String adminID, name;
  AllSecretaries(this.adminID, this.name);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Admin>(
        stream: AdminServices(uid: adminID).adminByID,
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
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) => CustomDialog(
                                  title: "حذف سكرتير",
                                  description: ' هل ترغب بحذف السكرتير',
                                  name: admin.name,
                                  buttonText: "تأكيد",
                                  onPressed: () {
                                    AdminServices().deleteAdminData(adminID);
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
  }
}
