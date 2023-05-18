import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

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

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
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
