import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'SUCCESS';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  //SIGN IN METHOD
  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'SUCCESS';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
    print('signout');
  }
}
