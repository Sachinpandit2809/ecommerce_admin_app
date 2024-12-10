import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // creating new account using eamil  password method

  Future<String> createAccountWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // login with email    password  method
  Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Login Succesful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // LOG OUT user
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // reset password
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  // check whether the user is sign in or not
  Future<bool> isLoggedIn() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
