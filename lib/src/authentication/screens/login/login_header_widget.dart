import 'package:cervezapp2/src/constants/images_strings.dart';
import 'package:cervezapp2/src/constants/texts_strings.dart';
import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(welcomeImage),
          height: size.height * 0.2,
        ),
        Text(tLoginTitle, style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}
