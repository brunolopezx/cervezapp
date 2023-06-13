//@dart = 2.19

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../repositories/auth_repository/auth.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final _user = Auth().currentUser;

  getEmail() {
    if (_user!.email == null) {
      return 'N/A';
    } else {
      return _user!.email.toString();
    }
  }

  getName() {
    if (_user!.displayName == null) {
      return 'N/A';
    } else {
      return _user!.displayName.toString();
    }
  }

  getPhone() {
    if (_user!.phoneNumber == null) {
      return 'N/A';
    } else {
      return _user!.phoneNumber.toString();
    }
  }

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
            Text("Email: " + getEmail()),
            Text("Nombre: " + getName()),
          ],
        ),
      ),
    );
  }
}
