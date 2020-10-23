import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sajeda_app/components/screenComponent/admin_login.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () => Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginAdmin()),
    ));

    return Scaffold(
      backgroundColor: Color(0xff316686),
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 70.0,
        ),
      ),
    );
  }
}
