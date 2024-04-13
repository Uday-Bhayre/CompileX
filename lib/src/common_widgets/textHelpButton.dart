import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/src/features/Compiler/controllers/codeEditorController.dart';

class textHelpButton extends StatelessWidget {
  textHelpButton({super.key, required this.add, required this.show});
  final String add;
  final String show;
  final codeController = Get.put(codeEditorController());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
            // shadowColor: MaterialStatePropertyAll(Colors.black),
            backgroundColor: MaterialStatePropertyAll(Colors.black),
            fixedSize: MaterialStatePropertyAll(
              Size(45, 40),
            ),
            elevation: MaterialStatePropertyAll(2),
            padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
            minimumSize: MaterialStatePropertyAll(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // maximumSize: MaterialStatePropertyAll(Size.fromWidth(40)),
            shape: MaterialStatePropertyAll(BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2))))),
        onPressed: () {
          int base = codeController.codeController.value.selection.baseOffset;
          codeController.codeController.value.text =
              codeController.codeController.value.text.substring(0, base) +
                  add +
                  codeController.codeController.value.text.substring(base);
          if (show == 'TAB') {
            base++;
          }
          codeController.codeController.value.selection =
              TextSelection.fromPosition(TextPosition(offset: base + 1));
        },
        child: Text(
          show,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ));
  }
}
