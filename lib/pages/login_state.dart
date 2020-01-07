import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState with ChangeNotifier{
  bool _loggedIn=false;
  bool _loading=true;

  SharedPreferences _prefs;
  FirebaseUser _user;

  LoginState(){
    loginState();
  }
  bool isLoggedIn()=>_loggedIn;
  bool isLoading()=>_loading;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser currentUser()=>_user;

  void login() async{
    _loading=true;
    notifyListeners();
    var user= await _handleSignIn();
    _loading=false;
    if(user!=null){
    _prefs.setBool('isLoggedIn', true);
     _loggedIn=true;
     notifyListeners();
    }else{
      _loggedIn=false;
      notifyListeners();
    }
  }
  void logout(){
    _prefs.clear();
    _googleSignIn.signOut();
    _loggedIn=false;
    notifyListeners();
  }

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }
  void loginState()async{
    _prefs=await SharedPreferences.getInstance();
    if(_prefs.containsKey('isLoggedIn')){
      _user=await _auth.currentUser();
      _loggedIn=_user!=null;
      _loading=false;
      notifyListeners();
    }else{
      _loading=false;
      notifyListeners();
    }
  }
}