//@dart = 2.19

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../repositories/auth_repository/auth.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final _user = Auth().currentUser;
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
            onPressed: () async {
              await Auth().desloguear().then((_) async {
                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Sesión cerrada...'),
                          icon: Icon(Icons.assignment_ind_rounded),
                          actions: [
                            TextButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ));
              });
              if (FirebaseAuth.instance.currentUser == null) {
                CircularProgressIndicator();
                Navigator.pushNamed(context, '/home');
              } else
                return;
            },
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Image(
                image: AssetImage(
                  'assets/images/profile.png',
                ),
                width: 100,
                height: 100,
                alignment: Alignment.topCenter,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Email: " + _user!.email.toString()),
            Text("Nombre: " + _user!.displayName.toString()),
            Text("Teléfono: " + _user!.phoneNumber.toString()),
            // StreamBuilder(
            //     stream:
            //         FirebaseFirestore.instance.collection("users").snapshots(),
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) {
            //         return Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //       List<DocumentSnapshot> users = snapshot.data!.docs;

            //       return Container(child: ListView.builder(itemBuilder: (_, i) {
            //         Map<String, dynamic> data =
            //             users[i].data() as Map<String, dynamic>;

            //         if (snapshot.data!.docs[i]['email'] == _user!.email) {}
            //         return ListTile(
            //           title: Text(data['email']),
            //           subtitle: Text(data['nombre']),
            //         );
            //       }));
            //     })
          ],
        ),
      ),
    );
  }
}
