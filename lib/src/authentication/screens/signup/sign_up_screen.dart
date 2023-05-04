// import 'package:cervezapp2/src/authentication/repositories/auth_repository/authentication_repository.dart';
import 'package:cervezapp2/src/authentication/screens/signup/signup_footer_widget.dart';
import 'package:cervezapp2/src/constants/images_strings.dart';
import 'package:cervezapp2/src/constants/sizes.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants/texts_strings.dart';
import 'form_header_widget.dart';
import 'signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

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
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
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
