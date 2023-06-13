import 'package:cervezapp2/src/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants/texts_strings.dart';
import '../../repositories/auth_repository/auth.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  String? errorMessage = "";
  final _FormKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _fullName = TextEditingController();
  final _phoneNo = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _fullName.dispose();
    _phoneNo.dispose();
    super.dispose();
  }

  Future createUserWithEmailAndPassword() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
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
    addUserDetails(_fullName.text.trim(), _email.text.trim(),
        int.parse(_phoneNo.text.trim()), _password.text.trim(), rool);
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
  var options = ['Dueño', 'Cliente'];
  var _currentItemSelected = 'Cliente';
  var rool = 'Cliente';

  Future addUserDetails(String nombre, String email, int tel, String password,
      String rool) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref =
        await FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({
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

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _FormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _fullName,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Ingrese su nombre";
                }
                return null;
              },
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: _phoneNo,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Ingrese su teléfono";
                }
                return null;
              },
              decoration: const InputDecoration(
                  label: Text(tPhone), prefixIcon: Icon(Icons.numbers)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Ingrese su email";
                }
                return null;
              },
              decoration: const InputDecoration(
                  label: Text(tEmail), prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: _password,
              obscureText: invisible,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Ingrese su contraseña";
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
            const SizedBox(height: tFormHeight - 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cuenta de: ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.blue[900],
                  isDense: false,
                  isExpanded: false,
                  iconEnabledColor: Colors.black,
                  focusColor: Colors.black,
                  items: options.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValueSelected) {
                    setState(() {
                      _currentItemSelected = newValueSelected!;
                      rool = newValueSelected;
                    });
                  },
                  value: _currentItemSelected,
                ),
              ],
            ),
            const SizedBox(height: tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_FormKey.currentState!.validate()) {
                    await createUserWithEmailAndPassword().then((_) {
                      var snackBar = SnackBar(
                        content: Text("Cuenta creada con éxito"),
                        action: SnackBarAction(
                            label: "Ok",
                            textColor: Colors.blue,
                            onPressed: () {}),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                    CircularProgressIndicator();
                  }
                  Navigator.pushNamed(context, '/login');
                  dispose();
                },
                child: Text(tSignup.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
