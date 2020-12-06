import 'package:flutter/material.dart';
import 'admin_password_change2.dart';

import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import '../../constants.dart';

class AdminPasswordChange extends StatelessWidget {
  static String id = "ChangePassword";

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
              "اضف البريد الالكتروني",
              style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Center(
            child: Text(
              "لتعيين كلمة مرور جديدة",
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          CustomTextFormField(TextInputType.emailAddress,false,"البريد الالكتروني",Icon(Icons.email)),
          SizedBox(
            height: height * 0.06,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            child: Container(
              height: 55,
              child: FlatButton(
                onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AdminPasswordChange2()),
    );

                },
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
