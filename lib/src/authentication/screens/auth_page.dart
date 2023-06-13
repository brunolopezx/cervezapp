//@dart = 2.19
import 'package:cervezapp2/main.dart';
import 'package:cervezapp2/src/authentication/repositories/auth_repository/auth.dart';

import 'package:cervezapp2/src/authentication/screens/signup/sign_up_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CervezAppHome();
          } else {
            return SignUpScreen();
          }
        },
      ),
    );
  }
}
