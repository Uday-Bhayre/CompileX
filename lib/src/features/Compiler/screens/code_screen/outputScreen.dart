// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/src/common_widgets/LTextFormField.dart';
import 'package:login/src/common_widgets/dotCircle.dart';
import 'package:login/src/features/Compiler/controllers/codeEditorController.dart';

class outputScreen extends StatelessWidget {
  const outputScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var codeController = Get.put(codeEditorController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          codeController.changeScreen.value = false;
          codeController.compilationError.value = false;
          codeController.killProcess();
        },
        child: Container(
          height: double.maxFinite,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {},
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.all(
                        10,
                      ),
                      decoration: BoxDecoration(
                        color: codeController.compilationError.value
                            ? Colors.red
                            : Colors.green,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(2)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Console',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 0, 0, 0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            padding: const EdgeInsets.all(
                              10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LdotCircle(color: Colors.red),
                                    LdotCircle(color: Colors.amberAccent),
                                    LdotCircle(color: Colors.blue),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                ),
                                Obx(
                                  () => Container(
                                    height: 200,
                                    padding: const EdgeInsets.all(10),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          codeController.isLoading.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Text(
                                                  codeController.output.value
                                                      .replaceAll(
                                                          codeController
                                                              .inputHint,
                                                          ''),
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                          if (codeController
                                              .isInputRequired.value)
                                            SizedBox(
                                              height: 150,
                                              child: Column(children: [
                                                LTextFormField(
                                                  controller: codeController
                                                      .inputController,
                                                  hint: 'Input',
                                                  prefixIcon: Icons.input,
                                                  isDarkMode: true,
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      if (codeController
                                                          .inputController
                                                          .text
                                                          .isNotEmpty) {
                                                        codeController
                                                            .submitInput();
                                                        codeController
                                                                .inputController
                                                                .value =
                                                            TextEditingValue
                                                                .empty;
                                                        codeController
                                                            .isInputRequired
                                                            .value = false;
                                                      }
                                                    },
                                                    style: TextButton.styleFrom(
                                                      minimumSize: Size.zero,
                                                      padding: EdgeInsets.zero,
                                                      tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                    ),
                                                    child: const Text("Submit"))
                                              ]),
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
