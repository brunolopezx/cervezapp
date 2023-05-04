// ignore_for_file: deprecated_member_use

import 'package:cervezapp2/src/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

import '../../../constants/texts_strings.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CO\nDE",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 80.0),
            ),
            Text("Verificación".toUpperCase(),
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 20.0),
            const Text("Ingresa el codigo recibido",
                textAlign: TextAlign.center),
            const SizedBox(height: 10.0),
            OTPTextField(
                textFieldAlignment: MainAxisAlignment.center,
                length: 6,
                otpFieldStyle: OtpFieldStyle(
                    backgroundColor: Colors.black.withOpacity(0.1)),
                onCompleted: (code) => print("OTP is => $code")),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: const Text(tNext)),
            ),
          ],
        ),
      ),
    );
  }
}
