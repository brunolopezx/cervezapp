import 'package:cervezapp2/src/constants/colors.dart';
import 'package:cervezapp2/src/constants/images_strings.dart';
import 'package:cervezapp2/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../constants/texts_strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(welcomeImage),
              height: height * 0.6,
            ),
            Column(
              children: [
                Text(
                  tWelcomeTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  tWelcomeSubtitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        foregroundColor: colorSecundario,
                        side: BorderSide(color: colorSecundario),
                        padding: EdgeInsets.symmetric(vertical: buttonHeight),
                      ),
                      child: Text(tLogin.toUpperCase())),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        backgroundColor: blanco,
                        foregroundColor: colorSecundario,
                        side: BorderSide(color: colorSecundario),
                        padding: EdgeInsets.symmetric(vertical: buttonHeight),
                      ),
                      child: Text(tSignup.toUpperCase())),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
