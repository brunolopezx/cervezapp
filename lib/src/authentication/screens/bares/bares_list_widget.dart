// @dart=2.19
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class BaresListWidget extends StatelessWidget {
  static Stream<QuerySnapshot> getStream() => FirebaseFirestore.instance
      .collection("bares")
      .orderBy("nombre")
      .snapshots();

  const BaresListWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/saveBares');
        },
      ),
      appBar: AppBar(
        title: Text("Bares"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("bares").snapshots(),
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
                    shape: BeveledRectangleBorder(),
                    onTap: () {
                      Navigator.pushNamed(context, '/cervezas', arguments: {
                        "idBar": snapshot.data?.docs[i].id,
                      });
                    },
                    onLongPress: () {
                      Navigator.pushNamed(context, '/editDeleteBares',
                          arguments: {
                            "id": snapshot.data?.docs[i].id,
                            "nombre": snapshot.data?.docs[i]["nombre"],
                            "ubicacion": snapshot.data?.docs[i]["ubicacion"],
                            "horarioApertura": snapshot.data?.docs[i]
                                ["horarioApertura"],
                            "horarioCierre": snapshot.data?.docs[i]
                                ["horarioCierre"],
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
