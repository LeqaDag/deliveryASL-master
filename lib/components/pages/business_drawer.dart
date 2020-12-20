import 'package:flutter/material.dart';
import 'package:AsyadLogistic/components/businessComponent/business_main.dart';
import 'package:AsyadLogistic/components/businessComponent/business_profile.dart';
import 'package:AsyadLogistic/components/businessComponent/orders/add_order.dart';
import 'package:AsyadLogistic/components/businessComponent/orders/all_orders.dart';
import 'package:AsyadLogistic/services/auth/auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';
import '../../services/auth/authentication_service.dart';

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
                      MaterialPageRoute(
                          builder: (context) =>
                              BusinessProfile(name: name, uid: uid)),
                    );
                  },
                  padding: EdgeInsets.all(0.0),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/asyadlogo2.jpeg",
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BusinessMain(
                                name: name,
                                uid: uid,
                              )),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddNewOdersByBusiness(name: name, uid: uid)),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BusinessOrders(name: name, uid: uid)),
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
                    
                    context.read<AuthenticationService>().signOut();
                    Phoenix.rebirth(context);

                    // SystemNavigator.pop();
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
