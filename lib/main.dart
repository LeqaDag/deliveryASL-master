import 'package:flutter/material.dart';
import 'components/orderComponent/store_add_new_order.dart';
import 'components/pages/loading.dart';
import 'components/screenComponent/admin_login.dart';
import 'components/screenComponent/admin_password_change.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginAdmin.id: (context) => LoginAdmin(),
        // AdminPasswordChange.id: (context) => AdminPasswordChange(),
        // '/': (context) => AddNewOders(),
        // '/loading': (context) => LoadingPage(),
      },
      initialRoute: LoginAdmin.id,
    );
  }
}

///store-and-business
