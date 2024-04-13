import 'package:flutter/material.dart';
import 'package:login/src/utils/theme/widget_themes/textTheme.dart';

class LAppTheme {
  LAppTheme._();
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: LtextTheme.lightTextTheme,
    appBarTheme: const AppBarTheme(),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    elevatedButtonTheme: const ElevatedButtonThemeData(),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: LtextTheme.darkTextTheme,
    appBarTheme: const AppBarTheme(),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    elevatedButtonTheme:const  ElevatedButtonThemeData(),
    useMaterial3: true,
  );
}


// primarySwatch: const MaterialColor(0xFFFFE200, <int, Color>{
//       50: Color(0x1AFFE200),
//       100: Color(0x33FFE200),
//       200: Color(0x4DFFE200),
//       300: Color(0x66FFE200),
//       400: Color(0x80FFE200),
//       500: Color(0xFFFFE200),
//       600: Color(0x99FFE200),
//       700: Color(0xB3FFE200),
//       800: Color(0xCCFFE200),
//       900: Color(0xE6FFE200),
//     }),