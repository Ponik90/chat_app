import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseHelper {
  static FireBaseHelper fireBaseHelper = FireBaseHelper._();

  FireBaseHelper._();

  User? user;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signinAuth(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("", 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar("", 'Wrong password provided for that user.');
      }
      Get.snackbar(e.code, "");
    }
    checkUser();
  }

  Future<void> signUpAuth(email, password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(e.code, "");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(e.code, "");
      }
      Get.snackbar(e.code, "");
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }

  bool checkUser() {
    user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<void> googleSignIn() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await firebaseAuth.signInWithCredential(credential);
  }
}
