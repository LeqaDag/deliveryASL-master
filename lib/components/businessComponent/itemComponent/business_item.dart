import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/components/businessComponent/addComponent/add_delivery_cost.dart';
import 'package:sajeda_app/components/businessComponent/updateComponent/update_company.dart';
import 'package:sajeda_app/services/businessServices.dart';
import 'package:sajeda_app/services/orderServices.dart';

import '../../../constants.dart';

class AllBuisness extends StatelessWidget {
  final Color color;
  final Function onTapBox;
  final String businessID, name;

  AllBuisness({
    @required this.color,
    @required this.onTapBox,
    @required this.businessID,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(businessID);
    return StreamBuilder<Business>(
        stream: BusinessService(uid: businessID).businessByID,
        builder: (context, snapshot) {
          print(businessID);
          if (snapshot.hasData) {
            Business business = snapshot.data;
            return Card(
              color: color,
              child: ListTile(
                title: Text(
                    "${business.name}"), // String Variable Take Name From DataBase
                leading: CircleAvatar(
                    // Account Image Form DataBase
                    ),
                trailing: Wrap(
                  spacing: -15, // space between two icons
                  children: <Widget>[
                    FutureBuilder<int>(
                        future: OrderService(businesID: businessID)
                            .countBusinessOrders(businessID),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Badge(
                              position: BadgePosition.topStart(
                                  start: width * 0.04, top: height * -0.004),
                              elevation: 5,
                              animationType: BadgeAnimationType.slide,
                              badgeContent: Text(
                                snapshot.data.toString() ?? "-1",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              shape: BadgeShape.circle,
                              badgeColor: KEditIconColor,
                              child: IconButton(
                                  icon: Image.asset("assets/BoxIcon.png"),
                                  onPressed: onTapBox),
                            );
                          } else {
                            return Badge(
                              position: BadgePosition.topStart(
                                  start: width * 0.04, top: height * -0.004),
                              elevation: 5,
                              animationType: BadgeAnimationType.slide,
                              badgeContent: Text(
                                "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              shape: BadgeShape.circle,
                              badgeColor: KEditIconColor,
                              child: IconButton(
                                  icon: Image.asset("assets/BoxIcon.png"),
                                  onPressed: onTapBox),
                            );
                          }
                        }),
                    IconButton(
                        icon: Icon(Icons.edit, color: KEditIconColor),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateCompany(
                                    businessID: businessID, name: name)),
                          );
                        }),
                    IconButton(
                        icon: Icon(Icons.delete, color: KTrashIconColor),
                        onPressed: () {
                          return showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('حذف شركة'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('هل ترغب بحذف الشركة'),
                                      Text(business.name),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('تأكيد'),
                                    onPressed: () async {
                                      BusinessService()
                                          .deleteBusinessData(businessID);
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
                        }),
                    IconButton(
                      icon: Icon(Icons.add, color: KAllOrdersListTileColor),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddDeliveryCost(
                                  businessID: businessID,
                                  businessName: business.name,
                                  name: name)),
                        );
                      },
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
