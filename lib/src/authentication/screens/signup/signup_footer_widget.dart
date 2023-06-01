import 'package:cervezapp2/src/constants/images_strings.dart';
import 'package:flutter/material.dart';

import '../../../constants/texts_strings.dart';
import '../../repositories/auth_repository/auth.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () async {
              await Auth().singInWithGoogle().then((_) {
                var snackBar = SnackBar(
                  content: Text("Cuenta de Google creada con éxito"),
                  action: SnackBarAction(
                      label: "Ok", textColor: Colors.blue, onPressed: () {}),
                );
                CircularProgressIndicator();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
              Navigator.pushNamed(context, '/auth');
            },
            icon: const Image(
              image: AssetImage(googleLogo),
              width: 20.0,
            ),
            label: Text(
              tSignInWithGoogle,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: tAlreadyHaveAccount,
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
                text: "  " + tLogin, style: TextStyle(color: Colors.blueAccent))
          ])),
        )
      ],
    );
  }
}
