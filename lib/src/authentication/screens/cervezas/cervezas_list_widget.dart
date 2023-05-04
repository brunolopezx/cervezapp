import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class CervezasListWidget extends StatelessWidget {
  static Stream<QuerySnapshot> getStream() => FirebaseFirestore.instance
      .collection("cervezas")
      .orderBy("nombre")
      .snapshots();

  const CervezasListWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/saveCervezas');
        },
      ),
      appBar: AppBar(
        title: Text("Cervezas"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("cervezas").snapshots(),
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
                  print("______");
                  print(data);

                  return ListTile(
                    title: Text(
                      data['nombre'],
                      style: TextStyle(color: colorSecundario),
                    ),
                    trailing: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ventas');
                        },
                        child: Icon(Icons.shopping_cart_outlined)),
                    shape: BeveledRectangleBorder(),
                    onLongPress: () {
                      Tooltip(
                        message: 'Ir a editar',
                      );
                      Navigator.pushNamed(context, '/editDeleteCervezas',
                          arguments: {
                            "id": snapshot.data?.docs[i].id,
                            "nombre": snapshot.data?.docs[i]["nombre"],
                            "tipo": snapshot.data?.docs[i]["tipo"],
                            "sabor": snapshot.data?.docs[i]["sabor"],
                            "ibu": snapshot.data?.docs[i]["ibu"],
                            "abv": snapshot.data?.docs[i]["abv"],
                            "precio": snapshot.data?.docs[i]["precio"]
                          });
                    },
                  );
                }),
          );
        },
      ),
    );
  }
}
