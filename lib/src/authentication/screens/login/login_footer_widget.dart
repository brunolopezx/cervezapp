import 'package:cervezapp2/src/authentication/repositories/auth_repository/auth.dart';
import 'package:cervezapp2/src/constants/images_strings.dart';
import 'package:cervezapp2/src/constants/sizes.dart';
import 'package:cervezapp2/src/constants/texts_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void route() {
      User? user = FirebaseAuth.instance.currentUser;
      // ignore: unused_local_variable
      var kk = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (documentSnapshot.get('rool') == "Dueño") {
            Navigator.pushNamed(context, '/home');
          } else {
            Navigator.pushNamed(context, '/clienteHome');
          }
        } else {
          print('Document does not exist on the database');
        }
      });
    }

    Future sign() async {
      await Auth().singInWithGoogle();
      route();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: tFormHeight - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(image: AssetImage(googleLogo), width: 20.0),
            onPressed: () async {
              await sign().then((_) {
                var snackBar = SnackBar(
                  content: Text("Inicio con Google exitoso"),
                  action: SnackBarAction(
                      label: "Ok", textColor: Colors.blue, onPressed: () {}),
                );
                CircularProgressIndicator();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
              // Navigator.pushNamed(context, '/auth');
            },
            label: const Text(
              tSignInWithGoogle,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: tFormHeight - 20),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          child: Text.rich(
            TextSpan(
                text: tDontHaveAnAccount,
                style: TextStyle(color: Colors.black),
                children: const [
                  TextSpan(
                      text: tSignup, style: TextStyle(color: Colors.blueAccent))
                ]),
          ),
        ),
      ],
    );
  }
}
