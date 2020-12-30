import 'package:AsyadLogistic/components/locationComponent/location_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/components/adminComponent/admin_secretary_home.dart';
import 'package:AsyadLogistic/components/cityComponent/city_admin.dart';
import 'package:AsyadLogistic/components/invoiceComponent/invoice_admin.dart';
import 'package:AsyadLogistic/components/lineComponent/all_lines.dart';
import 'package:AsyadLogistic/components/screenComponent/admin_home.dart';
import 'package:AsyadLogistic/components/screenComponent/admin_login.dart';
import 'package:AsyadLogistic/components/screenComponent/admin_orders.dart';
import 'package:AsyadLogistic/components/businessComponent/businesssComponent/business_admin.dart';
import 'package:AsyadLogistic/components/driverComponent/driversComponent/driveradmin.dart';
import 'package:AsyadLogistic/components/orderComponent/store_profile.dart';
import 'package:AsyadLogistic/services/auth/auth.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';
import '../../services/auth/authentication_service.dart';

class AdminDrawer extends StatelessWidget {
  final String uid, name;
  AdminDrawer({this.uid, this.name});

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
                          builder: (context) => StoreProfile(name: name)),
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
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminHome(name: name)),
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
                    'الشركات والتجار',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Amiri'),
                  ),
                  leading: Image.asset('assets/user-group.png'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BusinessAdmin(name: name)),
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
                    'الطرود',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Amiri'),
                  ),
                  leading: Image.asset('assets/box.png'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminOrders(name: name)),
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
                    'السائقين',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Amiri'),
                  ),
                  leading: Image.asset('assets/delivery.png'),
                  selected: true,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DriverAdmin(name: name)),
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
                    'خطوط التوصيل',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Amiri'),
                  ),
                  leading: Image.asset('assets/track-order.png'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllLines(name: name)),
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
                    'المصروفات',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Amiri'),
                  ),
                  leading: Image.asset('assets/invoice.png'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvoiceAdmin(name: name)),
                    );
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            //   child: Card(
            //     color: Color(0xff464646),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            //     child: ListTile(
            //       title: Text(
            //         'العاملين',
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 18.0,
            //             fontFamily: 'Amiri'),
            //       ),
            //       leading: Image.asset('assets/adminwhite.png'),
            //       onTap: () {
            //         Navigator.pop(context);
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => AdminSecretaryHome(name: name)),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              child: Card(
                color: Color(0xff464646),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(
                    'المدن',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: 'Amiri'),
                  ),
                  leading: Image.asset(
                    'assets/city-draw.png',
                    width: 40,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminCitiesHome(name: name)),
                    );
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            //   child: Card(
            //     color: Color(0xff464646),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            //     child: ListTile(
            //       title: Text(
            //         'المناطق',
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 18.0,
            //             fontFamily: 'Amiri'),
            //       ),
            //       leading: Image.asset('assets/wregion50.png', width: 40),
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => AllLocation(name: name)),
            //         );
            //       },
            //     ),
            //   ),
            // ),
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
