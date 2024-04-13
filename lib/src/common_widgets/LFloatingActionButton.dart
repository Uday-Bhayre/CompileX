// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/src/features/Compiler/screens/code_screen/mainScreen.dart';

class LFloatingActionButton extends StatelessWidget {
  const LFloatingActionButton({
    super.key,
    required this.isDarkMode,
    required this.activeScreen,
  });
  final bool isDarkMode;
  final String activeScreen;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          activeScreen,
          style: const TextStyle(
            fontFamily: 'openSans',
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 15,
          ),
        ),
      ),
      backgroundColor:
          isDarkMode ? Colors.black : const Color.fromARGB(163, 0, 0, 0),
      onPressed: () {
        Get.to(const codeScreen());
      },
    );
  }
}
