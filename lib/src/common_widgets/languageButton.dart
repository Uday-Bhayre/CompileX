// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/src/features/Compiler/controllers/codeEditorController.dart';
import 'package:login/src/features/Compiler/screens/code_screen/mainScreen.dart';

class languageButton extends StatelessWidget {
  const languageButton({
    super.key,
    required this.language,
  });
  final String language;
  @override
  Widget build(BuildContext context) {
    var codeController = Get.put(codeEditorController());

    double height = codeController.height;
    return GestureDetector(
      onTap: () {
        codeController.language.value = language.toLowerCase();
        codeController.changeHighlight(language.toLowerCase());
        codeController.changeScreen.value = false;
        Get.to(() => const codeScreen());
      },
      child: Container(
        alignment: Alignment.center,
        height: height * 0.15,
        width: height * 0.15,
        decoration: const BoxDecoration(
            color: Color.fromARGB(236, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
          alignment: Alignment.center,
          height: height * 0.125,
          width: height * 0.125,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(17))),
          child: Text(
            language,
            style: const TextStyle(
                fontSize: 25, color: Color.fromARGB(203, 0, 0, 0)),
          ),
        ),
      ),
    );
  }
}
