import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  static String id = "LoginScreen";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  var errorMessage;

  void _submitAuthForm(
    String email,
    String password,
    String confirmPassword,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential userCredential;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else if (password == confirmPassword) {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // final ref = FirebaseFirestore.instance
        //     .ref()
        //     .child('user_image')
        //     .child(userCredential.user.uid + '.jpg');

        // await ref.putFile(image).onComplete;

        // final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'username': username,
          'email': email,
        });
      } else {
        setState(() {
          _isLoading = false;
          errorMessage = "password does not match";
          Scaffold.of(ctx).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message;
        setState(() {
          errorMessage = message;
        });
        print(message);
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        errorMessage = error.toString();
      });
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AuthForm(
          _submitAuthForm,
          _isLoading,
        ),
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String confirmPassword,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _confirmPassword = '';

  bool hidePassword = true;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (!_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _confirmPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                !_isLogin
                    ? SizedBox(
                        height: 0,
                      )
                    : Image.asset(
                        "assets/delivery_logo.png",
                        height: height * 0.2,
                      ),
                // if (!_isLogin) UserImagePicker(_pickedImage, widget.isLoading),
                Container(
                  width: width,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    key: ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Email address',
                        prefixIcon: Icon(Icons.lock),
                        border: InputBorder.none),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                ),
                SizedBox(height: 12),
                if (!_isLogin)
                  Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      key: ValueKey('username'),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.edit),
                        border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  ),
                SizedBox(height: 12),
                Container(
                  width: width,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.lock),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                        hintText: 'Password',
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.vpn_key,
                        )),
                    obscureText: hidePassword,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                ),
                SizedBox(height: 12),
                if (!_isLogin)
                  Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.vpn_key,
                          )),
                      obscureText: hidePassword,
                      onSaved: (value) {
                        _confirmPassword = value;
                      },
                    ),
                  ),
                SizedBox(height: 12),
                widget.isLoading
                    ? CircularProgressIndicator()
                    : InkWell(
                        onTap: _trySubmit,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: width,
                          child: Center(
                              child: Text(
                            _isLogin ? 'Login' : 'Sign Up',
                          )),
                        ),
                      ),
                if (!widget.isLoading)
                  FlatButton(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: _isLogin
                              ? "Don't have an account? "
                              : "Already have an account?",
                        ),
                        TextSpan(
                          text: _isLogin ? "Sign Up" : "Log In",
                        )
                      ]),
                    ),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
                Image.asset(
                  "assets/delivery_logo.png",
                  height: height * 0.26,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
