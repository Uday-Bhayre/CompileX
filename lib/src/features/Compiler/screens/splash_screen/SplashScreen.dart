import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/src/features/Compiler/screens/welcomeScreen/welcomeScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use GetX's `onInit` method to add a delay before navigating to the next screen
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the next screen after 3 seconds
      Get.off(() => const welcomeScreen());
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(
          103, 0, 200, 255), // You can change the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Your splash screen content goes here
            const SizedBox(
                height: 110,
                child: Image(
                  image: AssetImage('assets/images/app_icon.png'),
                )),
            const SizedBox(height: 5),

            AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TyperAnimatedText('Compilex',
                    textStyle: const TextStyle(
                      fontFamily: 'dancingScript',
                      fontSize: 40,
                      color: Color.fromARGB(255, 182, 225, 201),
                    ),
                    speed: const Duration(milliseconds: 100))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
