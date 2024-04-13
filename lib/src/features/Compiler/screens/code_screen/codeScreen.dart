import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:login/src/features/Compiler/controllers/codeEditorController.dart';

class codeTextScreen extends StatelessWidget {
  codeTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
  var cdctrl = Get.put(codeEditorController());
    return CodeTheme(
        data: const CodeThemeData(styles: monokaiSublimeTheme),
        child: Obx(() => CodeField(
              // background: const Color.fromARGB(255, 44, 45, 45),

              enabled: !cdctrl.changeScreen.value,
              controller: cdctrl.codeController.value,
              textStyle: const TextStyle(
                fontFamily: 'sourceCodePro',
              ),
              cursorColor: const Color.fromARGB(255, 60, 81, 124),
              expands: true,
              wrap: true,
              horizontalScroll: true,
              lineNumberStyle: const LineNumberStyle(
                background: Color.fromARGB(255, 54, 53, 53),
                margin: 10,
                width: 40,
              ),
              onChanged: (codeValue) {
                int base = cdctrl.codeController.value.selection.baseOffset;
                int offset = cdctrl.codeController.value.text.length;
                cdctrl.codeController.value.text = codeValue;
                cdctrl.codeController.value.selection =
                    TextSelection.fromPosition(TextPosition(offset: base + codeValue.length-offset));
               
              },
            )));
  }
}
