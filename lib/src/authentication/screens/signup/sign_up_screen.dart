import 'package:cervezapp2/src/authentication/screens/signup/signup_footer_widget.dart';
import 'package:cervezapp2/src/constants/images_strings.dart';
import 'package:cervezapp2/src/constants/sizes.dart';
import 'package:cervezapp2/src/constants/texts_strings.dart';
import 'package:flutter/material.dart';

import 'form_header_widget.dart';
import 'signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              children: const [
                FormHeaderWidget(
                  image: welcomeImage,
                  title: "Nueva cuenta",
                  imageHeight: 0.20,
                ),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
