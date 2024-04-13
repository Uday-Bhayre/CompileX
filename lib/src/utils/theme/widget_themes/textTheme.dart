// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LtextTheme {
  static TextTheme lightTextTheme = const TextTheme(
    displayMedium: TextStyle(
      fontFamily: 'montserrat',
      color: Colors.black87,
    ),
    titleSmall: TextStyle(
      fontFamily: 'poppins',
      color: Colors.deepPurple,
      fontSize: 24,
    ),
  );
  static TextTheme darkTextTheme = const TextTheme(
    displayMedium: TextStyle(
      fontFamily: 'montserrat',
      color: Colors.white70,
    ),
    titleSmall: TextStyle(
      fontFamily: 'poppins',
      color: Colors.white60,
      fontSize: 24,
    ),
  );
}
