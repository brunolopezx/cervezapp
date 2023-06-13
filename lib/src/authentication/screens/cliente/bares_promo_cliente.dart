// @dart=2.19
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class BaresPromoCliente extends StatelessWidget {
  static Stream<QuerySnapshot> getStream() => FirebaseFirestore.instance
      .collection("bares")
      .orderBy("nombre")
      .snapshots();

  const BaresPromoCliente();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promociones"),
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
                      Navigator.pushNamed(context, '/promocionesCliente',
                          arguments: {
                            "idBar": snapshot.data?.docs[i].id,
                            "nombreBar": snapshot.data?.docs[i]["nombre"],
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
