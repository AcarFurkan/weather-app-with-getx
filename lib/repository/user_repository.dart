import 'package:weather_auth_app_with_bloc/model/user.dart';
import 'package:weather_auth_app_with_bloc/service/firebase_auth_service.dart';
import 'package:weather_auth_app_with_bloc/utils/locator/locator.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository {
  FirebaseAuthService _firebaseAuthService = getIt<FirebaseAuthService>();
  AppMode appMode = AppMode.RELEASE;

  Future<MyUser?> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      return await _firebaseAuthService.currentUser();
    } else {
      MyUser? _user = await _firebaseAuthService.currentUser();
      if (_user == null) {
        print("2");
        return null;
      }
      print("1");
      return await _firebaseAuthService.currentUser();
    }
  }

  Future<MyUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _firebaseAuthService.createUserWithEmailAndPassword(
          email, password);
    } else {
      MyUser? _user = await _firebaseAuthService.createUserWithEmailAndPassword(
          email, password);
      return _user;
    }
  }

  Future<MyUser?> signInWithEmailAndPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      return await _firebaseAuthService.signInWithEmailAndPassword(
          email, password);
    } else {
      MyUser? _user = await _firebaseAuthService.signInWithEmailAndPassword(
          email, password);

      return _user;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
  }
}
