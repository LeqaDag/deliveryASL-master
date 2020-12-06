import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/businessComponent/business_main.dart';
import 'components/driverComponent/driverAccount/driver_main.dart';
import 'components/pages/loadingData.dart';
import 'components/screenComponent/admin_home.dart';
import 'components/screenComponent/admin_login.dart';
import 'package:firebase_core/firebase_core.dart';

import 'services/auth/authentication_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
          child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null && firebaseUser.uid != null) {
      FirebaseFirestore.instance
            .collection('users')
            .where('userID', isEqualTo: firebaseUser.uid)
            .get()
            .then((value) {
          print(FirebaseAuth.instance.currentUser.uid);
          if (value.docs[0]["userType"] == '0') {
            LoadingData();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminHome(
                        name: value.docs[0]["name"],
                      )),
            );
          } else if (value.docs[0]["userType"] == '1') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BusinessMain(
                      name: value.docs[0]["name"],
                      uid: FirebaseAuth.instance.currentUser.uid)),
            );
          } else if (value.docs[0]["userType"] == '2') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DriverMain(
                      name: value.docs[0]["name"],
                      uid: FirebaseAuth.instance.currentUser.uid)),
            );
          } else {
            return LoadingData();
          }
        });
    }
    return LoginAdmin();
  }
}
///store-and-business
