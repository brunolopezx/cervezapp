import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class EditDeleteBares extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar o Eliminar'),
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
  final ubicacionController = TextEditingController();
  final hAperturaController = TextEditingController();
  final hCierreController = TextEditingController();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    idController.text = args["id"];
    nombreController.text = args["nombre"];
    ubicacionController.text = args["ubicacion"];
    hAperturaController.text = args["horarioApertura"];
    hCierreController.text = args["horarioCierre"];
    print(idController.text);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
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
                  height: 15,
                ),
                TextFormField(
                  controller: ubicacionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese la ubicación";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Ubicación",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: hAperturaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el horario de apertura";
                    }
                    if (int.tryParse(value) == null) {
                      return "Solo se permiten números";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Horario Apertura",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: hCierreController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el horario de cierre";
                    }
                    if (int.tryParse(value) == null) {
                      return "Solo se permiten números";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Horario Cierre",
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
                                  .collection("bares")
                                  .doc(idController.text)
                                  .update({
                                'nombre': nombreController.text,
                                'ubicacion': ubicacionController.text,
                                'horarioApertura': hAperturaController.text,
                                'horarioCierre': hCierreController.text,
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
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("bares")
                                .doc(idController.text)
                                .delete()
                                .then((_) {
                              var snackBar = SnackBar(
                                content: Text("Eliminado con éxito"),
                                action: SnackBarAction(
                                    label: "Ok",
                                    textColor: colorAccent,
                                    onPressed: () {}),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            backgroundColor: colorPrincipal,
                            foregroundColor: colorSecundario,
                            side: BorderSide(color: colorSecundario),
                            padding:
                                EdgeInsets.symmetric(vertical: buttonHeight),
                          ),
                          child: Text('Eliminar'.toUpperCase())),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
