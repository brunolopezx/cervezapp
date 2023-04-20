import 'package:cervezapp2/src/constants/images_strings.dart';
import 'package:flutter/material.dart';

import '../../../constants/texts_strings.dart';

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
            onPressed: () {},
            icon: const Image(
              image: AssetImage(googleLogo),
              width: 20.0,
            ),
            label: Text(tSignInWithGoogle),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: tAlreadyHaveAccount,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextSpan(
              text: tLogin,
            )
          ])),
        )
      ],
    );
  }
}
