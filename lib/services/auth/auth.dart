import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var _prefs = SharedPreferences.getInstance();
  String _storageKeyMobileToken = "token";

  User _userFromFirebaseUser(User user) {
    return user != null ?  user : null;
  }

  Stream<User> get user {
    return _firebaseAuth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // signIn
  Future signIn(String email, String password) async {
    try {
      return (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
    } catch (e) {
      print(e.message);
    }
  }

  // signOut
  signOut() {
    return _firebaseAuth.signOut();
  }

  // keep user logged in
  Future<bool> _setMobileToken(
      String token, String useremail, String userID) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("useremail", useremail);
    prefs.setString("userID", userID);

    return prefs.setString(_storageKeyMobileToken, token);
  }
}
