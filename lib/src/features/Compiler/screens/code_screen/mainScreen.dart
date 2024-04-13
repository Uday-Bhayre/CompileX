import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/src/common_widgets/textHelpButton.dart';
import 'package:login/src/features/Compiler/controllers/codeEditorController.dart';
import 'package:login/src/features/Compiler/screens/code_screen/codeScreen.dart';
import 'package:login/src/features/Compiler/screens/code_screen/outputScreen.dart';

class codeScreen extends StatelessWidget {
  const codeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var codeController = Get.put(codeEditorController());
    Rx<bool> isInfo = false.obs;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 175, 188),
        scrolledUnderElevation: 0,
        leading: const SizedBox(),
        
        actions: [
          const Row(
            children: [
              Image(
                image: AssetImage('assets/images/leadingIcon1.png'),
                height: 30,
              ),
              Text(
                'CompileX',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(199, 255, 255, 255),
                ),
              ),
              Image(
                image: AssetImage('assets/images/leadingIcon2.png'),
                height: 30,
              ),
            ],
          ),
          const Spacer(),

          Obx(
            () => Text(
              codeController.language.value[0].toUpperCase() +
                  codeController.language.value.substring(1),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            child: Container(
              // color: const Color.fromARGB(172, 92, 181, 193),
              padding: const EdgeInsetsDirectional.only(end: 30),
              child: const Image(
                height: 35,
                image: AssetImage(
                  "assets/images/coderun.png",
                ),
              ),
            ),
            onTap: () {
              codeController.changeScreen.value = true;
              print(codeController.changeScreen.value);
              codeController.compileAndRunCode();
            },
          ),
        ],
      ),
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: codeController.height,
                child: Column(
                  children: [
                    Container(
                      height: codeController.height * 0.78,
                      margin: const EdgeInsets.all(10),
                      child: codeTextScreen(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Column(
                children: [
                  IconButton(
                      style: const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 216, 216, 216)),
                          fixedSize: MaterialStatePropertyAll(
                            Size(30, 35),
                          ),
                          padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                          minimumSize: MaterialStatePropertyAll(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: MaterialStatePropertyAll(
                              BeveledRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))))),
                      onPressed: () => codeController.copyToClipboard(),
                      icon: const Icon(Icons.copy)),
                  IconButton(
                      style: const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 216, 216, 216)),
                          fixedSize: MaterialStatePropertyAll(
                            Size(30, 35),
                          ),
                          padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                          minimumSize: MaterialStatePropertyAll(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: MaterialStatePropertyAll(
                              BeveledRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2))))),
                      onPressed: () => codeController.pasteFromClipboard(),
                      icon: const Icon(Icons.paste)),
                  IconButton(
                    style: const ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 216, 216, 216)),
                        fixedSize: MaterialStatePropertyAll(
                          Size(30, 35),
                        ),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                        minimumSize: MaterialStatePropertyAll(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2))))),
                    onPressed: () =>
                        codeController.codeController.value.text = '',
                    icon: const Icon(Icons.delete_outline_rounded),
                    iconSize: 30,
                  ),
                  IconButton(
                    style: const ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 216, 216, 216)),
                        fixedSize: MaterialStatePropertyAll(
                          Size(30, 35),
                        ),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                        minimumSize: MaterialStatePropertyAll(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2))))),
                    onPressed: () {
                      isInfo.value = !isInfo.value;
                    },
                    icon: const Icon(Icons.info_outline_rounded),
                    iconSize: 27,
                  ),
                ],
              ),
            ),
            if (isInfo.value)
              Positioned(
                top: 140,
                right: 36,
                child: Container(
                  padding: EdgeInsets.all(codeController.width * 0.06),
                  // height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                        topLeft: Radius.circular(7)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "In Case of taking input with any loop...\nalways use Curly Braces ('{}')\n",
                        style: TextStyle(color: Colors.black),
                      ),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'for(...) ',
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: '{   ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            TextSpan(
                              text: '\\\\ Taking Input',
                              style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: '   }',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (!codeController.changeScreen.value)
              Positioned(
                  bottom: 1,
                  child: Container(
                    height: codeController.height * 0.08,
                    width: codeController.width,
                    // margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: const Color.fromARGB(255, 95, 207, 215),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          textHelpButton(add: '{}', show: '{'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: '}', show: '}'),
                          const SizedBox(
                            width: 15,
                          ),
                          textHelpButton(add: '()', show: '('),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: ')', show: ')'),
                          const SizedBox(
                            width: 15,
                          ),
                          textHelpButton(add: '""', show: '"'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: '\'\'', show: '\''),
                          const SizedBox(
                            width: 15,
                          ),
                          textHelpButton(add: ':', show: ':'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: ';', show: ';'),
                          const SizedBox(
                            width: 10,
                          ),
                          textHelpButton(add: '\t', show: 'TAB'),
                          const SizedBox(
                            width: 15,
                          ),
                          textHelpButton(add: '<', show: '<'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: '>', show: '>'),
                          const SizedBox(
                            width: 10,
                          ),
                          textHelpButton(add: '+', show: '+'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: '-', show: '-'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: '*', show: '*'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: '/', show: '/'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: '%', show: '%'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: '=', show: '='),
                          const SizedBox(
                            width: 10,
                          ),
                          textHelpButton(add: '!', show: '!'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: '\$', show: '\$'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: '|', show: '|'),
                          const SizedBox(
                            width: 4,
                          ),
                          textHelpButton(add: '&', show: '&'),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  )),
            if (codeController.changeScreen.value) const outputScreen(),
          ],
        ),
      ),
    );
  }
}
