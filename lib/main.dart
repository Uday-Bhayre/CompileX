import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/src/features/Compiler/screens/splash_screen/SplashScreen.dart';
import 'package:login/src/utils/theme/theme.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LAppTheme.lightTheme,
      darkTheme: LAppTheme.darkTheme,
      themeMode: ThemeMode.system, // here we have 3 options light,dark,system
      defaultTransition: Transition.leftToRight,
      transitionDuration: const Duration(
        milliseconds: 1000,
      ),
      home: const AppHome(),
    );
  }
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SplashScreen(),
      ),
    );
  }
}
