import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sajeda_app/components/businessComponent/addComponent/add_company.dart';
import 'package:sajeda_app/components/businessComponent/business_main.dart';
import 'package:sajeda_app/components/driverComponent/driver_main.dart';
import '../../constants.dart';
import 'admin_home.dart';
// import 'package:buy_it/widgets/custom_textfield.dart';
// widgets/admin_login_custom_text_field

class LoginAdmin extends StatefulWidget {
  static String id = "LoginScreen";

  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  final _formKey = GlobalKey<FormState>();
  bool _success;
  String _email, _password, error;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // double width = MediaQuery
    //     .of (context)
    //     .size
    //     .width;
    return Scaffold(
      backgroundColor: KAdminLoginMainColor,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: height * 0.06,
            ),
            Image.asset("assets/delivery_logo.png"),
            Container(
              margin: EdgeInsets.only(right: width * 0.09, left: width * 0.09),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right: 10.0, left: 10.0),
                  hintText: "البريد الالكتروني",
                  hintStyle: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 18.0,
                  ),
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
                // onSaved: (input) => _email = input,
                validator: (input) {
                  if (input.isEmpty) {
                    return "الرجاء ادخال البريد الالكتروني ";
                  } else if (!input.contains('@')) {
                    return 'الرجاء ادخال بريد الكتروني صحيح!';
                  }
                  return null;
                },
                controller: emailController,
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),

            Container(
              margin: EdgeInsets.only(right: width * 0.09, left: width * 0.09),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(right: 10.0, left: 10.0),
                  hintText: "كلمة المرور",
                  hintStyle: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 18.0,
                  ),
                  prefixIcon: Icon(Icons.lock),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
                //onSaved: (input) => _password = input,
                validator: (input) {
                  if (input.isEmpty) {
                    return "الرجاء ادخال كلمة المرور";
                  }
                  return null;
                  //  else if (!input.contains('@')) {
                  //   return 'الرجاء ادخال بريد الكتروني صحيح!';
                  // }
                },
                controller: passwordController,
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Container(
                height: 50,
                child: FlatButton(
                  onPressed: () {
                    _signInWithEmailAndPassword();
                  },
                  color: kAdminLoginBackGroundButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    "دخول",
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 25,
                      color: kAdminLoginButtonColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ), // flat button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      //checkColor: Colors.green,
                      activeColor: kCheckBoxActiveColor,
                      value: monVal,
                      // onChanged: ,
                      onChanged: (bool value) {
                        setState(() {
                          monVal = value;
                        });
                      },
                    ),
                    Text(
                      "تذكير الحساب ",
                      style: TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddCompany()),
                      //MaterialPageRoute(builder: (context) => EmailSignUp()),
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => AdminPasswordChange()),
                    // );
                  },
                  child: Text(
                    "هل نسيت كلمة المرور؟",
                    style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Image.asset("assets/delivery_master.png"),
          ],
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    if (_formKey.currentState.validate()) {
      await _firebaseAuth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) {
        FirebaseFirestore.instance
            .collection('admin')
            .where('userID', isEqualTo: result.user.uid)
            .get()
            .then((value) {
          print(value.docs[0]["userID"]);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AdminHome(name: value.docs[0]["name"])),
          );
        });

        FirebaseFirestore.instance
            .collection('businesss')
            .where('userID', isEqualTo: result.user.uid)
            .get()
            .then((value) {
          print(value.docs[0]["userID"]);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BusinessMain(
                    name: value.docs[0]["name"], uid: value.docs[0].id)),
          );
        });

        FirebaseFirestore.instance
            .collection('drivers')
            .where('userID', isEqualTo: result.user.uid)
            .get()
            .then((value) {
          print(value.docs[0]["userID"]);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DriverMain(
                    name: value.docs[0]["name"], uid: value.docs[0].id)),
          );
        });
      }).catchError((err) {
        print(err.message);
        // _showDialog();
      });
    }

    /*final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    if (_formKey.currentState.validate()) {
      await _firebaseAuth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) {
        FirebaseFirestore.instance
            .collection('users')
            .where('userID', isEqualTo: result.user.uid)
            .get()
            .then((value) {
          print(value.docs[0]["userType"]);
          if (value.docs[0]["userType"] == '0') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminHome(name: value.docs[0]["name"])),
            );
          } else if (value.docs[0]["userType"] == '1') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BusinessMain(
                      name: value.docs[0]["name"], uid: value.docs[0].id)),
            );
          } else if (value.docs[0]["userType"] == '2') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DriverMain(
                      name: value.docs[0]["name"], uid: value.docs[0].id)),
            );
          }
        }).catchError((e) => Toast.show(
                "يرجى التاكد من البريد الالكتروني او كلمة المرور", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM));
      }).catchError((err) {
        print(err.message);
        // _showDialog();
      });
    }*/
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("كلمة المرور خاطئة"),
          content: new Text("يرجى التاكد من البريد الالكتروني او كلمة المرور"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("اغلاق"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // _remmemberMe(bool value) async {
  //   var sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     monVal = value;
  //     sharedPreferences.setBool("check", monVal);
  //     // sharedPreferences.setString("username", username.text);
  //     //  sharedPreferences.setString("password", password.text);
  //     //getCredential();
  //   });
  // }

}
