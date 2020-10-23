import 'package:firebase_auth/firebase_auth.dart';
import 'package:sajeda_app/classes/admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var _prefs = SharedPreferences.getInstance();
  String _storageKeyMobileToken = "token";

  // create user object

  // signIn
  Future signIn (String email, String password) async{
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
      //return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user.uid;
    } catch(e) {
      print(e.message);
    }

  }

  // signOut
  signOut() {
    return _firebaseAuth.signOut();
  }

  // keep user logged in
  Future<bool> _setMobileToken(String token , String useremail, String userID) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("useremail", useremail);
    prefs.setString("userID", userID);

    return prefs.setString(_storageKeyMobileToken, token);
  }


}
