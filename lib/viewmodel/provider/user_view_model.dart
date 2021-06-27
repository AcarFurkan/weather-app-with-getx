/*

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_auth_app_with_bloc/model/user.dart';
import 'package:weather_auth_app_with_bloc/repository/user_repository.dart';
import 'package:weather_auth_app_with_bloc/utils/locator/locator.dart';

enum UserState { loggedIn, notLoggedIn, logging, error }

class UserAuthViewModel with ChangeNotifier {
  UserRepository _userRepository = getIt<UserRepository>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserState _userState = UserState.notLoggedIn;

  MyUser? _myUser = null;

  MyUser? get user => _myUser;

  set user(MyUser? value) {
    _myUser = value;
  } //User? _firebaseUser;

  //User? get user => _firebaseUser;
/*
  set user(User? value) {
    _firebaseUser = value;
  }*/

  UserState get userState => _userState;

  set userState(UserState value) {
    _userState = value;
    notifyListeners();
  }

  UserAuthViewModel() {
    _auth.authStateChanges().listen(_authStateChanged);
  }

  void _authStateChanged(User? user) {
    if (user == null) {
      this.user = null;
      userState = UserState.notLoggedIn;
      print(userState);
    } else {
      print(this.user);
      MyUser? myUser = _userFromFirebase(user);
      this.user = myUser;
      userState = UserState.loggedIn;
      print(userState);
    }
  }

  MyUser? _userFromFirebase(User? user) {
    if (user == null) {
      print("5");
      return null;
    }
    print("6");
    return MyUser(id: user.uid, email: user.email!);
  }

  Future<MyUser?> createUserWithEmailandPassword(
      String email, String password) async {
    try {
      userState = UserState.logging;
      _userRepository.createUserWithEmailAndPassword(email, password);
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? newUser = _credential.user;
      MyUser? myNewUser = _userFromFirebase(newUser);
      this.user = myNewUser;
      userState = UserState.loggedIn;
      return myNewUser;
    } catch (e) {
      userState = UserState.notLoggedIn;

      debugPrint("Create user error");
      return null;
    }
  }

  Future<MyUser?> signInUserWithEmailandPassword(
      String email, String password) async {
    try {
      userState = UserState.logging;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? loggedInUser = userCredential.user;
      MyUser? myNewUser = _userFromFirebase(loggedInUser);
      this.user = myNewUser;
      userState = UserState.loggedIn;
      return myNewUser;
    } catch (e) {
      userState = UserState.notLoggedIn;
      debugPrint("sign in method error");
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      this.user = null;
      userState = UserState.notLoggedIn;
      return true;
    } catch (e) {
      debugPrint("sign out methodunda hat çıktı");
      return false;
    }
  }
}
*/
