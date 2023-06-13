// @dart=2.19
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/colors.dart';
import '../../../providers/cart_item.dart';

class CervezasListCliente extends StatelessWidget {
  final idBar = TextEditingController();
  final nombreBar = TextEditingController();
  CervezasListCliente();

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    idBar.text = args["idBar"];
    nombreBar.text = args["nombreBar"];
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cervezas de " + nombreBar.text),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("bares")
            .doc(idBar.text)
            .collection("beers")
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

                  return ListTile(
                    title: Text(
                      data['nombre'],
                      style: TextStyle(color: colorSecundario),
                    ),
                    trailing: MaterialButton(
                        onPressed: () async {
                          cart.addItem(
                              snapshot.data!.docs[i].id,
                              double.parse(snapshot.data?.docs[i]["precio"]),
                              snapshot.data?.docs[i]["nombre"],
                              TimeOfDay.now().toString());
                          Navigator.pushNamed(context, '/ventas',
                              arguments: {"idBar": idBar.text});
                        },
                        child: Icon(Icons.shopping_cart_outlined)),
                    shape: BeveledRectangleBorder(),
                  );
                }),
          );
        },
      ),
    );
  }
}
