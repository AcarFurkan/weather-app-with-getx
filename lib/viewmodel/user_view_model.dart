import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/repository/user_repository.dart';
import 'package:weather_auth_app_with_bloc/utils/locator/locator.dart';

enum AuthState { loggedIn, loggingIn, loginFailed }

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;
  @override
  onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
    print("hello");
  }

  /* Rx<AuthState> _authState = AuthState.loginFailed.obs;

  AuthState get authState => _authState.value;

  set authState(AuthState value) {
    _authState.value = value;
  } //var _myUser = MyUser().obs;
*/

  UserRepository _userRepository = getIt<UserRepository>();
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
