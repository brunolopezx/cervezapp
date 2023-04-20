import 'package:cervezapp2/src/constants/colors.dart';
import 'package:flutter/material.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();
  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: colorSecundario,
    floatingLabelStyle: TextStyle(color: colorSecundario),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: colorSecundario),
    ),
  );
  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: colorPrincipal,
    floatingLabelStyle: TextStyle(color: colorPrincipal),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: colorPrincipal),
    ),
  );
}
