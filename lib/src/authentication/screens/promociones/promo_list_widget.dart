// @dart=2.19
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class PromocionesScreen extends StatelessWidget {
  final idBar = TextEditingController();
  final nombreBar = TextEditingController();
  PromocionesScreen();

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    idBar.text = args["idBar"];
    nombreBar.text = args["nombreBar"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Promociones de " + nombreBar.text),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("bares")
            .doc(idBar.text)
            .collection("promociones")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> items = snapshot.data!.docs;

          return Container(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, i) {
                  Map<String, dynamic> data =
                      items[i].data() as Map<String, dynamic>;

                  sino() {
                    if (snapshot.data?.docs[i]['activo'] == true) {
                      return 'Consulte en caja por la promoción';
                    } else {
                      return 'No disponemos de esta promo';
                    }
                  }

                  return ListTile(
                    title: Text(
                      data['Nombre'],
                      style: TextStyle(color: colorSecundario),
                    ),
                    subtitle: Text(sino()),
                    shape: BeveledRectangleBorder(),
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  'Desea activar esta promoción?',
                                  style: TextStyle(color: colorAccent),
                                ),
                                icon: Icon(Icons.question_mark),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('bares')
                                          .doc(idBar.text)
                                          .collection('promociones')
                                          .doc(snapshot.data?.docs[i].id)
                                          .update({
                                        'activo': true,
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Sí',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('bares')
                                            .doc(idBar.text)
                                            .collection('promociones')
                                            .doc(snapshot.data?.docs[i].id)
                                            .update({
                                          'activo': false,
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(color: Colors.black),
                                      ))
                                ],
                              ));
                    },
                  );
                }),
          );
        },
      ),
    );
  }
}
