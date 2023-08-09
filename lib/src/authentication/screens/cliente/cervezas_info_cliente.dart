// @dart=2.19
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CervezasInfoCliente extends StatelessWidget {
  final idC = TextEditingController();
  final nombreC = TextEditingController();
  final idBar = TextEditingController();

  CervezasInfoCliente();

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    idC.text = args["idCerveza"];
    nombreC.text = args["nombreCer"];
    idBar.text = args["idBar"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Info de " + nombreC.text),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("bares")
            .doc(idBar.text)
            .collection("beers")
            .where('nombre', isEqualTo: nombreC.text)
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
                  print("______");
                  print(data);

                  return Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.format_quote)),
                            Text(
                              'Sabor: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              snapshot.data!.docs[i]['sabor'],
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.title)),
                            Text('Tipo: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(snapshot.data!.docs[i]['tipo'],
                                style: TextStyle(fontStyle: FontStyle.italic))
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.attach_money)),
                            Text('Precio: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(snapshot.data!.docs[i]['precio'],
                                style: TextStyle(fontStyle: FontStyle.italic))
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.wine_bar)),
                            Text('IBU (Amargor): ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(snapshot.data!.docs[i]['ibu'],
                                style: TextStyle(fontStyle: FontStyle.italic))
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.percent)),
                            Text('ABV (% de alcohol): ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(snapshot.data!.docs[i]['abv'] + '%',
                                style: TextStyle(fontStyle: FontStyle.italic))
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
