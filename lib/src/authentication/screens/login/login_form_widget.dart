// @dart=2.19
import 'package:cervezapp2/src/constants/sizes.dart';
import 'package:cervezapp2/src/constants/texts_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../repositories/auth_repository/auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _FormKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future signInWithEmailAndPassword() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await Auth().signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      route();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
        Navigator.pop(context);
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
        Navigator.pop(context);
      } else if (e.code == 'email-already-in-use') {
        emailAlreadyInUseMessage();
        Navigator.pop(context);
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
                'Email incorrecto',
                style: TextStyle(color: Colors.yellow),
              ));
        });
  }

  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
                'Contraseña incorrecta',
                style: TextStyle(color: Colors.yellow),
              ));
        });
  }

  void emailAlreadyInUseMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
                'Email en uso',
                style: TextStyle(color: Colors.yellow),
              ));
        });
  }

  bool invisible = true;

  Widget build(BuildContext context) {
    return Form(
      key: _FormKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Ingrese el email";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tEmail,
                hintText: tEmail,
              ),
            ),
            const SizedBox(
              height: tFormHeight,
            ),
            TextFormField(
              controller: _password,
              obscureText: invisible,
              enableSuggestions: false,
              autocorrect: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Ingrese la contraseña";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                suffixIcon: GestureDetector(
                  onLongPress: () {
                    setState(() {
                      invisible = false;
                    });
                  },
                  onLongPressUp: () {
                    setState(() {
                      invisible = true;
                    });
                  },
                  child: Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(
                                'Se ha enviado un mail de recuperación. \n'
                                'Revise su correo',
                                style: TextStyle(fontSize: 18),
                              ),
                              icon: Icon(Icons.assignment_ind_rounded),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ));
                  },
                  child: Text(
                    tForgetPassword,
                    style: TextStyle(color: Colors.blueAccent),
                  )),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_FormKey.currentState!.validate()) {
                    await signInWithEmailAndPassword().then((_) {
                      var snackBar = SnackBar(
                        content: Text("Logueado con éxito"),
                        action: SnackBarAction(
                            label: "Ok",
                            textColor: Colors.blue,
                            onPressed: () {}),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }
                  //Navigator.pushNamed(context, '/auth');

                  //dispose();
                },
                child: Text(tLogin.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }

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
}
