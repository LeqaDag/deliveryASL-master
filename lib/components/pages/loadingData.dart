import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constants.dart';

class LoadingData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kAppBarColor,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
