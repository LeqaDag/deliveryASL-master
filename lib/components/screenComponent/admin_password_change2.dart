import 'package:flutter/material.dart';

import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';
import '../../constants.dart';

class AdminPasswordChange2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(textDirection: TextDirection.rtl, child: Home()),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("تغيير كلمة المرور")),
        backgroundColor: kAppBarColor,
      ),
      body: ListView(
        children: <Widget>[
          Image.asset("assets/delivery_logo copy.png"),
          Center(
            child: Text(
              "اعادة تعيين كلمة المرور",
              style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          CustomTextFormField(TextInputType.visiblePassword, false,
              "تاكيد كلمة المرور", Icon(Icons.lock)),
          SizedBox(
            height: height * 0.02,
          ),
          CustomTextFormField(TextInputType.visiblePassword, false,
              "كلمة مرور جديدة", Icon(Icons.lock)),
          SizedBox(
            height: height * 0.06,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            child: Container(
              height: 55,
              child: FlatButton(
                onPressed: () {},
                color: kAdminLoginBackGroundButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  "ارسال",
                  style: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 30,
                    color: kAdminLoginButtonColor,
                  ),
                ),
              ),
            ),
          ),
          Image.asset("assets/delivery_master.png"),
        ],
      ),
    );
  }
}
