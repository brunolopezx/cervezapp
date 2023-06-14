// @dart=2.19
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BaresInfoCliente extends StatelessWidget {
  final idBar = TextEditingController();
  final nombreBar = TextEditingController();

  BaresInfoCliente();

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    idBar.text = args["idBar"];
    nombreBar.text = args["nombreBar"];
    return Scaffold(
      appBar: AppBar(
        title: Text("Info de " + nombreBar.text),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("bares")
            .where('nombre', isEqualTo: nombreBar.text)
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
                                icon: Icon(Icons.access_alarm_outlined)),
                            Text(
                              'Horario Apertura: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              snapshot.data!.docs[i]['horarioApertura'] + ' PM',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.alarm_off)),
                            Text('Horario Cierre: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                                snapshot.data!.docs[i]['horarioCierre'] + ' AM',
                                style: TextStyle(fontStyle: FontStyle.italic))
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.location_on)),
                            Text('Ubicación: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(snapshot.data!.docs[i]['ubicacion'],
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
