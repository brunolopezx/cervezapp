// @dart=2.19

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? gUser;
  GoogleSignInAccount? get user => gUser;
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future logout() async {
    await googleSignIn.disconnect();
    await _firebaseAuth.signOut();
  }

  Future desloguear() async {
    await FirebaseAuth.instance.signOut();
  }

  Future singInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    gUser = googleUser;

    final googleAuth = await googleUser.authentication;

    final _credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(_credential);
    notifyListeners();
  }
}



// Future<void> sendUserDataToDB() async {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   var currentUser = _auth.currentUser;

//   CollectionReference _collectionRef =
//       FirebaseFirestore.instance.collection("users-form-data");
//   return _collectionRef
//       .doc(currentUser!.email)
//       .set({
//         "name": _nameController.text,
//         "phone": _phoneController.text,
//         "dob": _dobController.text,
//         "gender": _genderController.text,
//         "age": _ageController.text,
//       })
//       .then((value) => Navigator.push(
//           context, MaterialPageRoute(builder: (_) => BottomNavController())))
//       .catchError((error) => print("something is wrong. $error"));
// }
