import 'package:cervezapp2/src/authentication/repositories/auth_repository/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class EditUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
      ),
      body: Container(
        child: _FormEdit(),
      ),
    );
  }
}

class _FormEdit extends StatelessWidget {
  final _FormKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final telefonoController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;

    nombreController.text = args["nombre"];
    telefonoController.text = args["telefono"];
    emailController.text = args['email'];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Form(
            key: _FormKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: nombreController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el nombre";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: telefonoController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el telefono";
                    }
                    if (int.tryParse(value) == null) {
                      return "Solo se permiten números";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Teléfono",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () async {
                            if (_FormKey.currentState!.validate()) {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(Auth().currentUser!.uid)
                                  .update({
                                'nombre': nombreController.text,
                                'telefono': telefonoController.text
                              }).then((_) {
                                var snackBar = SnackBar(
                                  content: Text("Actualizado con éxito"),
                                  action: SnackBarAction(
                                      label: "Ok",
                                      textColor: colorAccent,
                                      onPressed: () {}),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              });
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            backgroundColor: colorPrincipal,
                            foregroundColor: colorSecundario,
                            side: BorderSide(color: colorSecundario),
                            padding:
                                EdgeInsets.symmetric(vertical: buttonHeight),
                          ),
                          child: Text('Actualizar'.toUpperCase())),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
