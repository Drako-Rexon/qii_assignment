import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // * login
  Future loginWithUserNameAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (err) {
      return err.message;
    }
  }

  // * register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (err) {
      return err.message;
    }
  }

  // * sign out
  Future signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (err) {
      return err;
    }
  }
}
