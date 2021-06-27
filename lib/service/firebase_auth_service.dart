import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_auth_app_with_bloc/model/user.dart';

class FirebaseAuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<MyUser?> currentUser() async {
    User? user = await _firebaseAuth.currentUser;
    print(3);
    print(user == null ? "null user" : user.email);
    MyUser? user2 = await _userFromFirebase(user);

    return user2;
  }

  Future<MyUser?> _userFromFirebase(User? user) {
    if (user == null) {
      print("5");
      return Future.value(null);
    }
    print("6");
    return Future.value(MyUser(id: user.uid, email: user.email!));
  }

  Future<MyUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(userCredential.user);
  }

  Future<MyUser?> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(userCredential.user);
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}
