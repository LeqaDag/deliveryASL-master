import 'package:flutter/material.dart';
import 'package:sajeda_app/components/businessComponent/business_main.dart';
import 'package:sajeda_app/components/businessComponent/business_profile.dart';
import 'package:sajeda_app/components/businessComponent/orders/all_orders.dart';
import 'package:sajeda_app/components/orderComponent/store_add_new_order.dart';
import 'package:sajeda_app/components/screenComponent/admin_login.dart';
import 'package:sajeda_app/components/orderComponent/store_profile.dart';
import 'package:sajeda_app/services/auth/auth.dart';

import '../../constants.dart';

class BusinessDrawer extends StatelessWidget {
  final String name, uid;
  BusinessDrawer({this.name, this.uid});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff363636),
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                name ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Amiri',
                  fontSize: 20.0,
                ),
              ),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StoreProfile()),
                    );
                  },
                  padding: EdgeInsets.all(0.0),
                  child: Image.asset(
                    "assets/user.png",
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                backgroundColor: kAppBarColor,
              ),
              decoration: BoxDecoration(
                color: kAppBarColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              child: Card(
                color: Color(0xff464646),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(
                    'الصفحة الرئيسية',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Amiri'),
                  ),
                  leading: Image.asset('assets/homePage.png'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BusinessMain(name: name)),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              child: Card(
                color: Color(0xff464646),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(
                    'حسابي',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Amiri'),
                  ),
                  leading: Image.asset('assets/profile-business-drawer.png',
                      width: 32),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusinessProfile(name: name, uid: uid)),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              child: Card(
                color: Color(0xff464646),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(
                    'طلبية جديدة',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Amiri'),
                  ),
                  leading:
                      Image.asset('assets/add-order-drawer.png', width: 32),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddNewOders(name: name)),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              child: Card(
                color: Color(0xff464646),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(
                    'جميع الطلبيات',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Amiri'),
                  ),
                  leading:
                      Image.asset('assets/all-order-drawer.png', width: 35),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BusinessOrders(name: name)),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              child: Card(
                color: Color(0xff464646),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(
                    'تسجيل خروج',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Amiri'),
                  ),
                  leading: Image.asset('assets/logout.png'),
                  onTap: () {
                    AuthService _authService = AuthService();
                    _authService.signOut();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginAdmin()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
