import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/user.dart';
import 'package:weather_auth_app_with_bloc/repository/user_repository.dart';
import 'package:weather_auth_app_with_bloc/utils/locator/locator.dart';
import 'package:weather_auth_app_with_bloc/view/pages/initial_page.dart';

enum UserState { loggedIn, logging, notLoggedIn, loginError }

class UserAuthViewModel extends GetxController {
  UserRepository _userRepository = getIt<UserRepository>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<UserState> _userState = UserState.notLoggedIn.obs;

  MyUser? _myUser = null;

  MyUser? get user => _myUser;

  set user(MyUser? value) {
    _myUser = value;
  }

  UserState get userState => _userState.value;

  set userState(UserState value) {
    _userState.value = value;
    print(userState);
  }

  @override
  onInit() {
    super.onInit();
    //_firebaseUser.bindStream(_auth.authStateChanges());
    _auth.authStateChanges().listen(_authStateChanged);
    print("hello");
  }

  Future<void> _authStateChanged(User? user) async {
    if (user == null) {
      this.user = null;
      print("**************************");
      userState = UserState.notLoggedIn;
    } else {
      MyUser? myUser = await _userFromFirebase(user);
      print(myUser!.email! + "aaaaaaaaaaaaaaaaaaaaaa");
      this.user = myUser;
      userState = UserState.loggedIn;
    }
  }

  Future<MyUser?> _userFromFirebase(User? user) {
    if (user == null) {
      print("5");
      return Future.value(null);
    }
    print("6");
    return Future.value(MyUser(id: user.uid, email: user.email!));
  }

  Future<MyUser?> createUserWithEmailandPassword(
      String email, String password) async {
    try {
      MyUser? myUser =
          await _userRepository.createUserWithEmailAndPassword(email, password);
      Get.offAll(Root());
      this.user = myUser;
      userState = UserState.loggedIn;
      return myUser;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          Get.snackbar("Kayıt hata", "Email zaten kullanımda.");
      }
    } catch (e) {
      debugPrint("Create user error");
      return null;
    }
  }

  Future<MyUser?> signInUserWithEmailandPassword(
      String email, String password) async {
    try {
      userState = UserState.logging;
      print("11111111111111111");
      MyUser? myUser =
          await _userRepository.signInWithEmailAndPassword(email, password);
      user = myUser;
      print("2222222222222222222222222");
      userState = UserState.loggedIn;
      return myUser;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          Get.snackbar("Giriş hata ", "Kayıtlı kullanıcı bulunamadı.");
          userState = UserState.notLoggedIn;
      }
    } catch (e) {
      userState = UserState.notLoggedIn;
      debugPrint("sign in method error");
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      _userRepository.signOut();
      this.user = null;
      userState = UserState.notLoggedIn;
      return true;
    } catch (e) {
      debugPrint("sign out methodunda hat çıktı");
      userState = UserState.notLoggedIn;
      return false;
    }
  }

  // Future<User?> signIn

/* Rx<AuthState> _authState = AuthState.loginFailed.obs;

  AuthState get authState => _authState.value;

  set authState(AuthState value) {
    _authState.value = value;
  } //var _myUser = MyUser().obs;
*/

/*
  Future<MyUser?> currentUser() async {
    MyUser? user = await _userRepository.currentUser();
    print(user);
    myUser = user;
    print(user == null ? "null user" : user.email);
    return user;
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
