import 'package:cervezapp2/src/authentication/screens/login/login_footer_widget.dart';
import 'package:cervezapp2/src/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'login_form_widget.dart';
import 'login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [LoginHeaderWidget(), LoginForm(), LoginFooterWidget()],
            ),
          ),
        ),
      ),
    );
  }
}
