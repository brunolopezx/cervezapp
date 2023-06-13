// @dart=2.19
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class PromocionesCliente extends StatelessWidget {
  final idBar = TextEditingController();
  final nombreBar = TextEditingController();
  PromocionesCliente();

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    idBar.text = args["idBar"];
    nombreBar.text = args["nombreBar"];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Promociones de " + nombreBar.text,
          style: TextStyle(fontSize: 18),
        ),
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
                  );
                }),
          );
        },
      ),
    );
  }
}
