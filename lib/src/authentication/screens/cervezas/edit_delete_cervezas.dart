import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class EditDeleteCervezas extends StatelessWidget {
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
  final tipoController = TextEditingController();
  final saborController = TextEditingController();
  final ibuController = TextEditingController();
  final abvController = TextEditingController();
  final precioController = TextEditingController();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    idController.text = args["id"];
    nombreController.text = args["nombre"];
    tipoController.text = args["tipo"];
    saborController.text = args["sabor"];
    ibuController.text = args["ibu"];
    abvController.text = args["abv"];
    precioController.text = args["precio"];
    print(idController.text);

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
                  controller: tipoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el tipo";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Tipo",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: saborController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el sabor";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Sabor",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: ibuController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el IBU";
                    }
                    if (int.tryParse(value) == null) {
                      return "Solo se permiten números";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "IBU",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: abvController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el ABV";
                    }
                    if (int.tryParse(value) == null) {
                      return "Solo se permiten números";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "ABV",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: precioController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese el precio";
                    }
                    if (int.tryParse(value) == null) {
                      return "Solo se permiten números";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Precio",
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
                                  .collection("cervezas")
                                  .doc(idController.text)
                                  .update({
                                'nombre': nombreController.text,
                                'tipo': tipoController.text,
                                'sabor': saborController.text,
                                'ibu': ibuController.text,
                                'abv': abvController.text,
                                'precio': precioController.text
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
                                .collection("cervezas")
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
