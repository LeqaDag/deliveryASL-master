import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:AsyadLogistic/components/businessComponent/business_main.dart';
import 'package:AsyadLogistic/components/driverComponent/driverAccount/driver_main.dart';
import 'package:AsyadLogistic/components/pages/loadingData.dart';
import '../../constants.dart';
import '../../services/auth/authentication_service.dart';
import 'admin_home.dart';
import 'package:provider/provider.dart';

class LoginAdmin extends StatefulWidget {
  static String id = "LoginScreen";

  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  final _formKey = GlobalKey<FormState>();
  String error;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                margin:
                    EdgeInsets.only(right: width * 0.09, left: width * 0.09),
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
                margin:
                    EdgeInsets.only(right: width * 0.09, left: width * 0.09),
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
                  validator: (input) {
                    if (input.isEmpty) {
                      return "الرجاء ادخال كلمة المرور";
                    }
                    // } else if (input.length < 7) {
                    //   return 'كلمة المرور غير مطابقة';
                    // }
                    return null;
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
                      //signIn(emailController.text,  passwordController.text);
                      // _signInWithEmailAndPassword();
                      context.read<AuthenticationService>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
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
      ),
    );
  }

  Future signIn(String email, String password) async {
    String errorMessage;

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on PlatformException catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e);
    }
  }

  void _signInWithEmailAndPassword() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
      }).catchError((err) {
        if (err) {
          print(err.message);
        }
      });
    }
  }
}

// void _showDialog() {
//   // flutter defined function
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       // return object of type Dialog
//       return AlertDialog(
//         title: new Text("كلمة المرور خاطئة"),
//         content: new Text("يرجى التاكد من البريد الالكتروني او كلمة المرور"),
//         actions: <Widget>[
//           // usually buttons at the bottom of the dialog
//           new FlatButton(
//             child: new Text("اغلاق"),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

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
