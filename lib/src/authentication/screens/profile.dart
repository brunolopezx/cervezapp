//@dart = 2.19

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../repositories/auth_repository/auth.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _user = Auth().currentUser;

  final nombreControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Logueado"),
          centerTitle: true,
          actions: [
            TextButton(
              child: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('¿Desea cerrar sesión?'),
                          icon: Icon(Icons.assignment_ind_rounded),
                          actions: [
                            TextButton(
                              child: Text(
                                "Sí",
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () async {
                                await Auth().desloguear();
                                var snackBar = SnackBar(
                                  content: Text("Sesión cerrada"),
                                  action: SnackBarAction(
                                      label: "Ok",
                                      textColor: Colors.blue,
                                      onPressed: () {}),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pushNamed(context, '/home');
                              },
                            ),
                            TextButton(
                              child: Text(
                                'No',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ));
                if (FirebaseAuth.instance.currentUser == null) {
                  CircularProgressIndicator();
                  Navigator.pushNamed(context, '/home');
                } else
                  return;
              },
            )
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where('email', isEqualTo: _user!.email)
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
                      // ignore: unused_local_variable
                      Map<String, dynamic> data =
                          items[i].data() as Map<String, dynamic>;

                      return Container(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/profile.png',
                                ),
                                width: 200,
                                height: 200,
                                alignment: Alignment.center,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.supervised_user_circle)),
                                Text(
                                  'Nombre: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data!.docs[i]['nombre'],
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.email)),
                                Text('Email: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(snapshot.data!.docs[i]['email'],
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic))
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.verified_user)),
                                Text('Rol: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(snapshot.data!.docs[i]['rool'],
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic))
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.phone_android)),
                                Text('Teléfono: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                    snapshot.data!.docs[i]['telefono']
                                        .toString(),
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(),
                                    backgroundColor: colorPrincipal,
                                    foregroundColor: colorSecundario,
                                    side: BorderSide(color: colorSecundario),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/editarUser',
                                        arguments: {
                                          'nombre': snapshot.data!.docs[i]
                                              ['nombre'],
                                          'telefono': snapshot
                                              .data!.docs[i]['telefono']
                                              .toString(),
                                          'email': snapshot.data!.docs[i]
                                              ['email']
                                        });
                                  },
                                  label: Text('Editar usuario'),
                                  icon: Icon(
                                    Icons.edit,
                                    size: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              );
            }));
  }
}
