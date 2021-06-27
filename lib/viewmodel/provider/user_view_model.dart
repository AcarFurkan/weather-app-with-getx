import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_auth_app_with_bloc/repository/user_repository.dart';
import 'package:weather_auth_app_with_bloc/utils/locator/locator.dart';

enum UserState { loggedIn, notLoggedIn, logging, signInPage, loginPage }

class UserAuthViewModel with ChangeNotifier {
  /* MyUser? _myUser = MyUser();*/

  FirebaseAuth _auth = FirebaseAuth.instance;
  UserState _userState = UserState.notLoggedIn;

  User? _firebaseUser;

  User? get user => _firebaseUser;

  set user(User? value) {
    _firebaseUser = value;
  }

  UserState get userState => _userState;

  set userState(UserState value) {
    _userState = value;
    notifyListeners();
  }

  /// User? get user => _firebaseUser;
  UserAuthViewModel() {
    _auth.authStateChanges().listen(_authStateChanged);
  }

  void _authStateChanged(User? user) {
    if (user == null) {
      user = null;

      userState = UserState.notLoggedIn;
      print(this.user);
      print(userState);
    } else {
      print(this.user);

      this.user = user;
      userState = UserState.loggedIn;
      print(userState);
    }
  }

  UserRepository _userRepository = getIt<UserRepository>();
/*
  Future<MyUser?> currentUser() async {
    MyUser? user = await _userRepository.currentUser();
    print(user);
    myUser = user;
    print(user == null ? "null user" : user.email);
    return user;
  }*/

  Future<User?> createUserWithEmailandPassword(
      String email, String password) async {
    try {
      userState = UserState.logging;
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? newUser = _credential.user;
      userState = UserState.loggedIn;
      user = newUser;
      return newUser;
    } catch (e) {
      userState = UserState.notLoggedIn;

      debugPrint("Create user error");
      return null;
    }
  }

  Future<User?> signInUserWithEmailandPassword(
      String email, String password) async {
    try {
      userState = UserState.logging;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? loggedInUser = userCredential.user;
      userState = UserState.loggedIn;
      user = loggedInUser;
      return loggedInUser;
    } catch (e) {
      userState = UserState.notLoggedIn;
      debugPrint("sign in method error");
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      user = null;
      userState = UserState.notLoggedIn;
      return true;
    } catch (e) {
      debugPrint("sign out methodunda hat çıktı");
      return false;
    }
  }

  /*MyUser? get myUser => _myUser;

  set myUser(MyUser? value) {
    _myUser = value;
    notifyListeners();
  }*/
/*
  void signOut() {
    clear();
    print(10);
    _userRepository.signOut();
    print(11);
  }*/
/*
  void clear() {
    myUser = null;
  }*/
}
