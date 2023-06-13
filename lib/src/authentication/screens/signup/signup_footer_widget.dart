import 'package:cervezapp2/src/constants/images_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/texts_strings.dart';
import '../../repositories/auth_repository/auth.dart';

class SignUpFooterWidget extends StatefulWidget {
  SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFooterWidget> createState() => _SignUpFooterWidgetState();
}

class _SignUpFooterWidgetState extends State<SignUpFooterWidget> {
  Future signIn() async {
    var email;
    var nombre;
    var phone;
    var password = '';
    var rool = 'Cliente';
    try {
      await Auth().singInWithGoogle();
      var user = Auth().gUser;
      email = user!.email.trim();
      nombre = user.displayName?.trim();
      phone = '';
      print(user.email.trim());
    } catch (e) {
      print('error');
    }
    addUserDetails(email, nombre, phone, password, rool);
  }

  Future addUserDetails(String nombre, String email, int tel, String password,
      String rool) async {
    var user = Auth().gUser;
    CollectionReference ref =
        await FirebaseFirestore.instance.collection('users');
    ref.doc(user!.id).set({
      'nombre': nombre,
      'telefono': tel,
      'email': email,
      'password': password,
      'rool': rool,
    });
    // await FirebaseFirestore.instance.collection("users").add({
    //   'nombre': nombre,
    //   'telefono': tel,
    //   'email': email,
    //   'password': password,
    //   'rool': rool,
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () async {
              await signIn().then((_) {
                var snackBar = SnackBar(
                  content: Text("Cuenta de Google creada con éxito"),
                  action: SnackBarAction(
                      label: "Ok", textColor: Colors.blue, onPressed: () {}),
                );
                CircularProgressIndicator();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
              Navigator.pushNamed(context, '/login');
            },
            icon: const Image(
              image: AssetImage(googleLogo),
              width: 20.0,
            ),
            label: Text(
              tSignInWithGoogle,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: tAlreadyHaveAccount,
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
                text: "  " + tLogin, style: TextStyle(color: Colors.blueAccent))
          ])),
        ),
      ],
    );
  }
}
