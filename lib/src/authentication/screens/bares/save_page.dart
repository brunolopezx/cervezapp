import 'package:cervezapp2/src/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SaveBaresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guardar'),
      ),
      body: Container(
        child: _FormSave(),
      ),
    );
  }
}

class _FormSave extends StatelessWidget {
  final _FormKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final ubicacionController = TextEditingController();
  final hAperturaController = TextEditingController();
  final hCierreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Form(
            key: _FormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                ElevatedButton(
                    onPressed: () async {
                      if (_FormKey.currentState!.validate()) {
                        print("valido");
                        await FirebaseFirestore.instance
                            .collection("bares")
                            .add({
                          'nombre': nombreController.text,
                          'ubicacion': ubicacionController.text,
                          'horarioApertura': hAperturaController.text,
                          'horarioCierre': hCierreController.text,
                        }).then((_) {
                          var snackBar = SnackBar(
                            content: Text("Guardado con exito"),
                            action: SnackBarAction(
                                label: "Ok",
                                textColor: colorAccent,
                                onPressed: () {}),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Text('Guardar')),
              ],
            )),
      ),
    );
  }
}
