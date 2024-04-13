// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LdotCircle extends StatelessWidget {
  const LdotCircle({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      height: 15,
      width: 15,
    );
  }
}
