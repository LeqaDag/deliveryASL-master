import 'package:flutter/material.dart';
import 'package:AsyadLogistic/components/driverComponent/driverAccount/driver_main.dart';
import 'package:AsyadLogistic/components/driverComponent/driverAccount/driver_profile.dart';
import 'package:AsyadLogistic/components/driverComponent/sheetComponent/driver_daily_sheet.dart';
import 'package:AsyadLogistic/services/auth/auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';
import '../../services/auth/authentication_service.dart';

class DriverDrawer extends StatelessWidget {
  final String name, uid;
  DriverDrawer({this.name, this.uid});

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
                            DriverProfile(name: name, uid: uid),
                      ),
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
                      fontFamily: 'Amiri',
                    ),
                  ),
                  leading: Image.asset('assets/homePage.png'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DriverMain(
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
                              DriverProfile(name: name, uid: uid)),
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
                    'الانجاز اليومي',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'Amiri',
                    ),
                  ),
                  leading: Image.asset('assets/profile-business-drawer.png',
                      width: 32),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DriverDailySheet(name: name, driverID: uid),
                      ),
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
                      fontFamily: 'Amiri',
                    ),
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
