import 'package:flutter/material.dart';
import 'package:login/src/constants/colors.dart';

class LTextFormField extends StatefulWidget {
  const LTextFormField({
    super.key,
    required this.isDarkMode,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
  });
  final TextEditingController controller;
  final bool isDarkMode;
  final String hint;
  final IconData prefixIcon;

  @override
  State<LTextFormField> createState() => _LTextFormFieldState();
}

class _LTextFormFieldState extends State<LTextFormField> {
  var isPassword = false;
  var isPassVisible = true;
  @override
  Widget build(BuildContext context) {
    isPassword = widget.hint == "Password";
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      height: 60,
      child: TextFormField(
        cursorHeight: 22,
        cursorColor: widget.isDarkMode ? LWhiteColor : LDarkColor,
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        obscureText: !isPassVisible,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            fontSize: 16,
          ),
          labelText: widget.hint,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: widget.isDarkMode ? LWhiteColor : LDarkColor,
          ),
          suffix: isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isPassVisible = !isPassVisible;
                    });
                  },
                  icon: Icon(
                      isPassVisible ? Icons.visibility : Icons.visibility_off))
              : null,
          contentPadding: const EdgeInsets.only(
            bottom: 50,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                color: widget.isDarkMode ? LWhiteColor : LDarkColor,
              )),
        ),
      ),
    );
  }
}
